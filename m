From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen
 para-virtualized frontend driver
Date: Thu, 10 Aug 2017 11:10:11 +0300
Message-ID: <b9e34f0e-4a9a-9ccf-6165-04cd22a070ac@gmail.com>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
 <7e62a406-7dcd-b5c9-b2de-ea52e1d2afd0@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 44648267471
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 10:10:15 +0200 (CEST)
Received: by mail-lf0-f68.google.com with SMTP id x16so19656lfb.4
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 01:10:15 -0700 (PDT)
In-Reply-To: <7e62a406-7dcd-b5c9-b2de-ea52e1d2afd0@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

Hi,

thank you very much for valuable comments and your time!

On 08/10/2017 06:14 AM, Takashi Sakamoto wrote:
> Hi,
>
> On Aug 7 2017 21:22, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> This patch series adds support for Xen [1] para-virtualized
>> sound frontend driver. It implements the protocol from
>> include/xen/interface/io/sndif.h with the following limitations:
>> - mute/unmute is not supported
>> - get/set volume is not supported
>> Volume control is not supported for the reason that most of the
>> use-cases (at the moment) are based on scenarious where
>> unprivileged OS (e.g. Android, AGL etc) use software mixers.
>>
>> Both capture and playback are supported.
>>
>> Thank you,
>> Oleksandr
>>
>> Resending because of rebase onto [2] + added missing patch
>>
>> [1] https://xenproject.org/
>> [2] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/?h=for-next
>>
>> Oleksandr Andrushchenko (12):
>>    ALSA: vsnd: Introduce Xen para-virtualized sound frontend driver
>>    ALSA: vsnd: Implement driver's probe/remove
>>    ALSA: vsnd: Implement Xen bus state handling
>>    ALSA: vsnd: Read sound driver configuration from Xen store
>>    ALSA: vsnd: Implement Xen event channel handling
>>    ALSA: vsnd: Implement handling of shared buffers
>>    ALSA: vsnd: Introduce ALSA virtual sound driver
>>    ALSA: vsnd: Initialize virtul sound card
>>    ALSA: vsnd: Add timer for period interrupt emulation
>>    ALSA: vsnd: Implement ALSA PCM operations
>>    ALSA: vsnd: Implement communication with backend
>>    ALSA: vsnd: Introduce Kconfig option to enable Xen PV sound
>>
>>   sound/drivers/Kconfig     |   12 +
>>   sound/drivers/Makefile    |    2 +
>>   sound/drivers/xen-front.c | 2107 
>> +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 2121 insertions(+)
>>   create mode 100644 sound/drivers/xen-front.c
>
> For this patchset, I have the same concern which Clemens Ladisch
> denoted[1]. If I can understand your explanation about queueing between
> Dom0/DomU stuffs, the concern can be described in short words; this
> driver works without any synchronization to data transmission by actual
> sound hardwares.
>
Yes, both your concerns and understanding are correct
> In design of ALSA PCM core, drivers are expected to synchronize to
> actual hardwares for semi-realtime data transmission. The
> synchronization is done by two points:
> 1) Interrupts to respond events from actual hardwares.
> 2) Positions of actual data transmission in any serial sound interfaces
>    of actual hardwares.
>
> These two points comes from typical designs of actual hardwares, thus
> they doesn't come from unfair, unreasonable, intrusive demands from
> software side.
>
This clear, thank you
> In design of typical stuffs on para-virtualization, Dom0 stuffs are hard
> to give enough abstraction of sound hardwares in these two points for
> DomU stuffs. Especially, it cannot abstract point 2) at all because the
> value of position should be accurate against actual time frame, while
> there's an overhead for DomU stuffs to read it. When DomU stuffs handles
> the value, the value is enough past due to context switches between
> Dom0/DomU. Therefore, this driver must rely on point 1) to synchronize
> to actual sound hardwares.
Which will also introduce some latency too: time needed to deliver and
handle interrupt from Dom0 to DomU
> Typically, drivers configure hardwares to
> generate interrupts per period of PCM buffer. This means that this
> driver should notify to Dom0 about the value of period size requested
> by applications.
>
> In 'include/xen/interface/io/sndif.h', there's no functionalities I
> described the above:
> 1. notifications from DomU to Dom0 about the size of period for
>    interrupts from actual hardwares. Or no way from Dom0 to DomU about
>    the configured size of the period.
Ok, then on "open" command I will pass from DomU to Dom0 an additional
parameter, period size. Then Dom0 will respond with actual period size
for DomU to use. So, this way period size will be negotiated.
Does the above look ok to you?
> 2. notifications of the interrupts from actual hardwares to DomU.
>
Ok, I will introduce an event from Dom0 to DomU to signal period elapsed.

Taking into account the fact that period size may be as small as,
say, 1ms, do you think we can/need to mangle period size in 1) on Dom0 side
to be reasonable, so we do not flood with interrupts/events from Dom0 to 
DomU?
Do you see any "formula" to determine that reasonable/acceptable
period limit, so both Dom0 and DomU are happy?

> For the reasons, your driver used kernel's timer interface to generate
> 'pseudo' interrupts for the purpose. However, it depends on Dom0's
> abstraction different from sound hardwares and Linux kernel's
> abstraction for timer functionality. In this case, gap between 'actual'
> interrupts from hardware and the 'pseudo' interrupts from a combination
> of several components brings unexpected result on several situations.
>
You are right
> I think this is defects of 'sndif' interface in Xen side. I think it
> better for you to work in Xen community to improve the above interface
> at first, then work for Linux stuffs.
>
Please see above for planned changes to the protocol
>
> Additionally, in next time, please remind of several points below:
>  * When a first patch adds an initial code for drivers, it should
>    include entries for Makefile and Kconfig, so that the driver can be
>    built even if it's still in an initial shape.
Will do
> Each patch should be
>    self-contained and should be in a shape so that developers easily run
>    bisecting. In other words, your first patch[2] includes modification
>   for Makefile and Kconfig in your last patch[3].
Will do
>  * When any read-only symbols is added,  it should have 'const'
>    qualifier so that the symbol places to .rodata section of ELF
>    binaries. For example, in your code, 'alsa_sndif_formats' is such an
>    symbol. In recent Linux development, some developers work for
>    constifying such symbols. Please remind of their continuous works in
>    upstream[4].
Will do
>  * You can split your driver to several files. In
>    'include/xen/interface/io/sndif.h', Dom0 produces functionalities for
>    DomU to control gain/volume/mute and in future your driver may get
>    more codes. If split to several files make it readable, it should be
>    done.
Will do. If I split, do you think it would be better to move the driver
from sound/drivers to sound/xen folder, so all those files do not mix
with the rest?
>  * In my taste, a prefix of the subject line should be 'xen-front',
>   instead of 'vsnd'. It comes from name of your driver.
>
Will do
> [1] [alsa-devel] [PATCH 08/11] ALSA: vsnd: Add timer for period 
> interrupt emulation
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/123617.html 
>
> [2] [PATCH RESEND1 01/12] ALSA: vsnd: Introduce Xen para-virtualized 
> sound frontend driver
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/123654.html 
>
> [3] [alsa-devel] [PATCH RESEND1 12/12] ALSA: vsnd: Introduce Kconfig 
> option to enable Xen PV sound
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/123662.html 
>
> [4] You can see many posts for this; e.g. [alsa-devel] [PATCH 0/7] 
> constify ALSA usb_device_id.
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/123564.html 
>
>
> Regards
>
> Takashi Sakamoto
Thank you,
Oleksandr
