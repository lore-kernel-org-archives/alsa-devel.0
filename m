From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Sat, 3 Sep 2016 12:38:16 +0100
Message-ID: <20160903113816.GH21682@localhost.localdomain>
References: <38f437e4-56e7-dc7a-6892-c1d812fd56d3@sakamocchi.jp>
 <20160831042040.GO9355@localhost> <57C65D4A.9090209@sakamocchi.jp>
 <20160831090552.GZ21682@localhost.localdomain>
 <s5hzintgtsr.wl-tiwai@suse.de>
 <e95db80c-682d-b186-ea9e-a4a8a5501329@ladisch.de>
 <s5ha8ftgmyh.wl-tiwai@suse.de>
 <47fa0f7b-cf3a-b3dd-7e7e-7d45369ddaac@sakamocchi.jp>
 <s5ha8fteyle.wl-tiwai@suse.de>
 <2450af02-a554-6374-d92f-d4d0666c7138@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id DC3CE26736F
 for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2016 13:38:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2450af02-a554-6374-d92f-d4d0666c7138@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2016 at 08:30:33PM +0900, Takashi Sakamoto wrote:
> Sorry to be late. I'm a bit busy for my daily work and things related
> to my poor life.
> 
> On Sep 1 2016 00:40, Takashi Iwai wrote:
> > Which application do you have in mind?
> 
> At first, I did never suggest that 'TLV feature should handle byte
> stream' or 'TLV feature should be extended to somewhere'. I just
> addressed that 'Now, TLV feature is not used only for transmission of
> pure threshold information between applications/drivers, but it's also
> used for I/O operation. Unfortunately, protocol of TLV packet payload is
> not kept anymore.'
> 
> It's not my intension to discuss about this patchset in a point of 'byte
> stream'. It comes from your bias, and the other developers are led to
> the wrong direction, sigh. I really hope them to read my comment in this
> patchset carefully and compare them to actual code implementations
> in driver/core/library and applications[1][2][3].
> 
> Again, I have few interests about actual implementation of TLV feature
> in driver side and for what purposes applications are developed to
> utilize TLV feature. They're free for developers in each area now, and
> for future. What we should do is how to assist their activity via the
> design of APIs. This is my place in this patchset. It's not my intension
> to request extensions of TLV feature.
> 
> 
> > Applications would access via either alsa-lib or tinyalsa.  And these
> libraries do already care about how to access via TLV.
> 
> Without enough care due to implementation in kernel land.
> 
> As I already cleared, current TLV feature has a difficulty not to return
> the length of actually handled bytes[4]. Correspondingly, APIs in these
> libraries have defections, as APIs for I/O operation or transmission of
> arbitrary data, because applications cannot get to know the actual
> length of handled data.
> 

    /* This simulates the other processes to read it. */
    packet->length = 100 - sizeof(struct snd_ctl_tlv);
    if (ioctl(fd, SNDRV_CTL_IOCTL_TLV_READ, packet) < 0) {
        printf("ioctl(TLV_READ): %s\n", strerror(errno));
        goto end_addition;
    }

    printf("struct snd_ctl_tlv.length: %d\n", packet->length);
    printf("But I store %ld bytes.\n", 6 * sizeof(unsigned int));

Here you wrote 6 items into the control but the read said it
gave you 100 items and you would have preferred it to have said
6 items? But you have created a 128 item long ALSA control if we
forget about the TLV aspect (which in my view is just a means to
access the control) and assume this was a regular ALSA control
then you would never expect that to give you less data than the
size of the control, so this behaviour would be expected.

As this was originally intended (at least AFAIK) as a mechanism
to provide byte controls >512 bytes, my point is really just that
I would expect this to work like a normal control. There is no
need to pass the length actually processed because this isn't
for arbitrary length data its just a way to read/write a control
which is something that already has a defined size.

> There's no way for user space to get appropriate length in advance, this
> brings contradiction for content of given buffer. For example, in ALSA
> SoC part, the length is trimmed according to a parameter of driver
> instance, implicitly[5]. As a result, users are beguiled. They requests
> a certain length of buffer to be handled via TLV feature. Even if they
> receive success, a _part_ of buffer is actually handled. This is not
> good for software stacks in a point of abstraction layer of hardware.
> There's no transparency independent from hardwares. Application
> developers is forced to consider about device driver's codes which are
> not open via APIs.
> 

That length you refer to is not some secret internal length it
is the length of the control as returned by the info ioctl. I
guess we could make the read/write fail if it was larger than the
control, that might be better behaviour than just silently not
handling all the data.

Thanks,
Charles
