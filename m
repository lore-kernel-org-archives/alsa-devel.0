From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Thu, 1 Sep 2016 00:26:14 +0900
Message-ID: <47fa0f7b-cf3a-b3dd-7e7e-7d45369ddaac@sakamocchi.jp>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
 <8bb43ca3-eaf1-9f03-1f73-540f96941ae1@ladisch.de>
 <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
 <20160830145136.GE9355@localhost>
 <38f437e4-56e7-dc7a-6892-c1d812fd56d3@sakamocchi.jp>
 <20160831042040.GO9355@localhost> <57C65D4A.9090209@sakamocchi.jp>
 <20160831090552.GZ21682@localhost.localdomain> <s5hzintgtsr.wl-tiwai@suse.de>
 <e95db80c-682d-b186-ea9e-a4a8a5501329@ladisch.de>
 <s5ha8ftgmyh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D1FE1266F02
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2016 17:26:19 +0200 (CEST)
In-Reply-To: <s5ha8ftgmyh.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, omair.m.abdullah@intel.com, alsa-devel@alsa-project.org, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

On Aug 31 2016 21:08, Takashi Iwai wrote:
> On Wed, 31 Aug 2016 13:54:37 +0200,
> Clemens Ladisch wrote:
>>
>> Takashi Iwai wrote:
>>> TLV has never been and (will never be) an API to handle a
>>> generic binary stream.
>>
>> It would be possible to define something like SNDRV_CTL_TLVT_HWDEP_BLOB
>> or _COEFFICIENTS, or to reserve a range of TLVT values for driver-
>> defined types.  (But we cannot change soc-wm-adsp to support only proper
>> TLV data, because this would introduce a regression.)
> 
> Well, passing the random hw-specific data is fine, but what I meant is
> that a "stream" isn't suitable with TLV.  (And I don't mean it's
> impossible, either :)

I'm few interested in whether it's binary stream or not, or
hardware-specific or not. The returned length is the most, in a point of
application developers. I'll show you two cases.

1.Let's see current implementation of 'snd_soc_bytes_tlv_callback()' in
sound/soc/soc-ops.c.

http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/soc/soc-ops.c?h=v4.8-rc4#n772

Here, 'size' argument is struct snd_ctl_tlv.length and 'tlv' argument is
&struct snd_ctl_tlv.tlv[2].

The size of actual I/O is smaller value between the length and hardcoded
'params->max'.

When applications give larger buffer to TLV feature of ALSA control
interface, then the early part of the buffer is filled. On the other
hand, applications cannot get to know the actual length.

2.Let's see core implementation user-defined control element set.

http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/control.c?h=v4.8-rc4#n1140

The 'size' and 'tlv' arguments are the same as the first example.

When write operation, the given buffer and length is stored to a control
element set. When read operation, the given buffer is filled by the
stored data with the stored length. On the other hand, applications
cannot get to know the actual length.

When we're considering just about pure threshold information, there's no
concern about the length, due to struct snd_ctl_tlv.tlv[1]. But now
we've already decided to use this feature to transfer arbitrary length
of data. It's better to consider about what is better for applications.
In this point, I believe that my patchset is not fishy at all.

In the end of this message, I put a sample program for second example.


Regards

Takashi Sakamoto

----- 8< -----

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sound/asound.h>

int main(void)
{
    struct snd_ctl_tlv *packet;
    int fd;
    struct snd_ctl_elem_info info = {0};

    packet = malloc(100);
    if (packet == NULL) {
        printf("malloc(3): %s\n", strerror(ENOMEM));
        goto end_malloc;
    }

    fd = open("/dev/snd/controlC0", O_RDONLY);
    if (fd < 0) {
        printf("open(2): %s\n", strerror(errno));
        goto end_malloc;
    }

    /* Add my control element set. Don't forget to remove them. */
    info.id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
    info.owner = 100;
    strcpy((char *)info.id.name, "sample");
    info.access = SNDRV_CTL_ELEM_ACCESS_READ |
              SNDRV_CTL_ELEM_ACCESS_WRITE |
              SNDRV_CTL_ELEM_ACCESS_TLV_READ |
              SNDRV_CTL_ELEM_ACCESS_TLV_WRITE;
    info.count = 128;
    info.type = SNDRV_CTL_ELEM_TYPE_INTEGER;
    info.value.integer.min = 0;
    info.value.integer.max = 100;
    info.value.integer.step = 1;
    if (ioctl(fd, SNDRV_CTL_IOCTL_ELEM_ADD, &info) < 0) {
        printf("ioctl(ADD): %s\n", strerror(errno));
        goto end_malloc;
    }

    /* In a case to store arbitrary data. */
    packet->numid = info.id.numid;
    packet->length = 6 * sizeof(packet->tlv[0]);
    packet->tlv[0] = 'a';
    packet->tlv[1] = 'b';
    packet->tlv[2] = 'c';
    packet->tlv[3] = 'd';
    packet->tlv[4] = 'e';
    packet->tlv[5] = 'f';
    if (ioctl(fd, SNDRV_CTL_IOCTL_TLV_WRITE, packet) < 0) {
        printf("ioctl(TLV_WRITE): %s\n", strerror(errno));
        goto end_addition;
    }

    /* This simulates the other processes to read it. */
    packet->length = 100 - sizeof(struct snd_ctl_tlv);
    if (ioctl(fd, SNDRV_CTL_IOCTL_TLV_READ, packet) < 0) {
        printf("ioctl(TLV_READ): %s\n", strerror(errno));
        goto end_addition;
    }

    printf("struct snd_ctl_tlv.length: %d\n", packet->length);
    printf("But I store %ld bytes.\n", 6 * sizeof(unsigned int));
end_addition:
    /* For a combination of PulseAudio and alsa-lib 1.1.1. */
    sleep(2);
    if (ioctl(fd, SNDRV_CTL_IOCTL_ELEM_REMOVE, &info.id) < 0)
        printf("ioctl(REMOVE): %s\n", strerror(errno));
end_malloc:
    free(packet);

    return EXIT_SUCCESS;
}
