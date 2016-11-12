From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC 0/4] ALSA controls management using
 index/device/sub-devices fields
Date: Sat, 12 Nov 2016 13:23:09 +0900
Message-ID: <a92aab32-03a1-5d89-0f3b-c080cc6bb938@sakamocchi.jp>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
 <c28a3623-3cf1-5fc1-1ba8-e6785fb967ca@sakamocchi.jp>
 <cb9cf7f0-ae86-307b-c4d6-b4d3120d4e88@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 2AB9F266621
 for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2016 05:23:19 +0100 (CET)
In-Reply-To: <cb9cf7f0-ae86-307b-c4d6-b4d3120d4e88@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 9 2016 23:38, Arnaud Pouliquen wrote:
>> In my view, this patchset includes two attempts:
>> 1.to add a framework into ALSA SoC part to relate some control element
>> sets to PCM devices
>> 2.to allow drivers in ALSA SoC part to add some control element sets
>> from the same codes according to entries of dtb
>>
>> To achieve above 2nd attempt, it changes ALSA control core to accept
>> several control element sets with the same name by assigning proper
>> indexes to the sets.
>>
>> Well, since your former messages, you continue using the word, 'general'
>> or 'generic'. If it were somewhat general, it should satisfy
>> requirements in whole this subsystem. Actually, there's none of such
>> requirements outside of ALSA SoC part. For the drivers outside of ALSA
>> SoC part, design of target sound card is fixed in advance, therefore
>> programmers can assign control element sets to PCM devices in usual
>> ways. At least, current infrastructure in ALSA control core can satisfy
>> the programmers.
>>
>> Therefore, I think that your attempts includes over-generalization. In
>> theory, it can bring over-specification easily and it causes code
>> complication or unmaintained codes.
>
> I based my RFC on the fact that i was facing same kind of problem than
> HDA driver (last time i mention it). In this context, i don't think that
> it was senseless to have a global approach.

Unless you have special interests in verb parser of HDA specification 
and work for it, it's better not to address to it. Else, you would be 
involved into more complicated stories; old and new Intel HDA driver, 
historical reasons of former Intel HDA driver, variations of HDA codecs 
produced by several vendors, vendor-dependent quirks of ACPI table, and 
so on.

> If not the good approach, let's refocus on ASoC, that's fine by me.

In my taste, this approach is better for your main issue. After solving 
the issue and you have enough rest to work for more-generic one, you 
could do it.

>> Focusing on ALSA SoC part, there's a requirement to register control
>> element sets from the same code, in fact. So I wonder why you don't
>> start your explanation in an aspect of it. In short, I can't understand
>> the reason that you adhere to such an inappropriate generalization for
>> this subsystem.
>>
>> In this patchset, you adhere to usage of 'index' field. But there's
>> another way; assigning different identification information to the
>> control element sets. Let us to start discussion from this point? At
>> least, Iwai-san said, former driver for Intel High Definition Audio is
>> necessarily not a good example for a model to c
>> onsider about this issue and the usage of 'index' is not
>> well-generalized[1].
>>
>> Finally, it's better to clear main points of your issue, for practical
>> and meaningful discussion for better approaches, before starting this
>> discussion, I think. At least, there's over-generalization,
>> misunderstandings of design and interfaces, driver-specific historical
>> reasons and so on.
>>
>>
>> [1] [alsa-devel] [RFC 0/4] ALSA controls management using
>> index/device/sub-devices fields
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/114430.html
>>
> So I propose to continue discussion on a simple and concrete use case:
> The 'IEC958 Playback Default' control.
>
> In my ASoC driver i have one HDMI and one SPDIF outputs.
> so I have 2'IEC958 Playback Default' PCM controls.
> => Each control can be set independently.

Yes. It's a demand in your issue.
(here, I ignore a process to generalize the issue for wider range in 
this subsystem because it's another issue.)

> Regarding control identification field (struct snd_ctl_elem_i):
>  .numid;  => set by ALSA framework
>  .iface;  => must be SNDRV_CTL_ELEM_IFACE_PCM
>  .device; => must be linked to PCM device , but not possible for
>              ASoC DAI...
>  .subdevice => not used in ASoC implementation
>  .name      => 'IEC958 Playback Default'
>  .index     => not used in ASoC, forced to 0 by snd_soc_cnew
>
> Other solution: use control "prefix"? not possible as control has a
> pre-defined name.
>
> => Only solution to differentiate the control: "device" field.
>    (that seems coherent as it a PCM device).

This is one of solutions we can perform for this issue. As a feasibility 
study, in the end of this message, I wrote a small program with a 
feature of 'user-defined control element set' in ALSA control core.

I think usage of 'device' field is better than usage of prefix for 
'name' field. It clearly represents the relationship between control 
element set and PCM devices. And it's just suitable for this issue.

> Issues:
>      - use "device" in ASOC DAI driver means that driver needs to
>        define a "virtual" PCM device value, not the PCM device.
> 	=> this break the rule that mention that PCM control should be
>         linked to a PCM device.

Please show me where related codes and structures are. At least, I 
cannot understand what you said because it's really abstracted.

>        Furthermore, this "virtual" value has to be aligned with the one
>        defined in alsa-lib conf file(s).

Ditto.

>      - iecset uses only index to differentiate IEC controls. But in
>        ASoC implementation this is not possible as index is forced to 0.

_Apparently_, mixer APIs in alsa-lib is not well-designed to represent 
capacity of ALSA control core. It's not better to judge somwthing 
according to its design.

Although we need to improve iecset tool, this is another issue.

-------- 8< --------

#include <stdio.h>
#include <stdlib.h>

#include <string.h>
#include <errno.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <sys/ioctl.h>

#include <unistd.h>

#include <sound/asound.h>

int main(void)
{
     int fd;
     struct snd_ctl_elem_info info = {0};
     int first_numid = 0;
     int second_numid = 0;

     fd = open("/dev/snd/controlC0", O_RDWR);
     if (fd < 0) {
         printf("open(2): %s\n", strerror(errno));
         return EXIT_FAILURE;
     }

     /* Identification information. */
     info.id.iface = SNDRV_CTL_ELEM_IFACE_PCM;
     info.id.subdevice = 0;
     strncpy(info.id.name, "IEC958 Playback Default", sizeof(info.id.name));
     info.id.index = 0;

     /* Common information. */
     info.type = SNDRV_CTL_ELEM_TYPE_IEC958;
	info.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
     info.count = 1;
     info.owner = 1;

     /* Add the first control element set. */
     info.id.numid = 0;
     info.id.device = 0;
     if (ioctl(fd, SNDRV_CTL_IOCTL_ELEM_ADD, &info) < 0) {
         printf("ioctl(2): %s\n", strerror(errno));
         goto end;
     }
     first_numid = info.id.numid;

     /* Add the second control element set. */
     info.id.numid = 0;
     info.id.device = 1;
     if (ioctl(fd, SNDRV_CTL_IOCTL_ELEM_ADD, &info) < 0) {
     }
     second_numid = info.id.numid;
end:
     if (first_numid > 0) {
         info.id.numid = first_numid;
         ioctl(fd, SNDRV_CTL_IOCTL_ELEM_REMOVE, &info);
     }

     if (second_numid > 0) {
         info.id.numid = second_numid;
         ioctl(fd, SNDRV_CTL_IOCTL_ELEM_REMOVE, &info);
     }

     close(fd);

     return EXIT_SUCCESS;
}

Regards

Takashi Sakamoto
