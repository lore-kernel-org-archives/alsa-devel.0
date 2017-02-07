From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC v2] [ALSA][CONTROL] 1. Added 2 ioctls for
 reading/writing values of multiple controls in one go (at once) 2.
 Restructured the code for read/write of a single control
Date: Tue, 7 Feb 2017 13:33:05 +0900
Message-ID: <0fece5db-0bde-19eb-1863-bead3e86ce4d@sakamocchi.jp>
References: <CGME20170203052820epcas4p2287bdd4bb4de9e5e4c363bcd6872681e@epcas4p2.samsung.com>
 <1486099688-8057-1-git-send-email-satendra.t@samsung.com>
 <s5hefzfivfh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 03A15266EF6
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 05:33:08 +0100 (CET)
In-Reply-To: <s5hefzfivfh.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Satendra Singh Thakur <satendra.t@samsung.com>
Cc: hemanshu.s@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, nishant.s4@samsung.com
List-Id: alsa-devel@alsa-project.org

Hi Satendra,

As long as I review, this patch becomes worse than your previous
patches, because at least two topics are accumulated to the patch:
  * Code refactoring to aggregate several functions.
  * Add new ioctl(2) command to handle several elements in one operation.

In this case, patches with mixture topics easily brings long discussion,
because it includes many points worth to discuss. Thus, it's preferable
to post patches for each of the topics. In your case, they're related
each other, therefore post the one after another is merged to upstream
after enough discussions. In this my message, I focus on the second
topic.

Next, your idea has large impacts to Linux sound subsystem. I can
assume that all of devices and applications in this world get affects
from your work as long as the devices are handled by this subsystem. In
this case, it's also preferable to discuss between developers. There're
already below two questions to your patch in this mailing list; the
below ones from Clemens and Iwai-san;

On Feb 3 2017 02:22, Clemens Ladisch wrote:
> Satendra Singh Thakur wrote:
>> -Added an ioctl to read values of multiple elements at once
>> -Added an ioctl to write values of multiple elements at once
>> -In the absence of above ioctls user needs to call N ioctls to
>>  read/write value of N elements which requires N context switches
>
> And why are these N context switches a problem?
>
>> -Above mentioned ioctl will be useful for alsa utils such as amixer
>>  which reads all controls of given sound card
>
> Is there a noticeable difference?

On Feb 3 2017 16:29, Takashi Iwai wrote:
> But, could you answer to the question Clemens posted for v1 patch?
> Namely, do N-times context switching really matter?  Does it give the
> severe performance issue?
>
> If we have a measured number, this thing is worth to consider.
> OTOH, without the actual measurement but "just because it must be
> better", it's no good reason for adding a new API/ABI.

They're maintainers of this subsystem. It's better for you to have
enough communication with them, because they need to find some
advantages of your code, to go ahead this discussion.


Well, in my opinion, current shape of your code is not better for your
idea, because driver developers can program their control functionality
so that an operation in one element can change status of the others.
Let's assume that user space programs manage to change several elements
with your code. If target elements depends each other due to the above
design, what's is the preferable result from the operation? I don't
have exact conclusion yet, but there's a need to add some restrictions
to handled elements; e.g. only for elements belong to one control
element set.


On Feb 3 2017 16:24, Takashi Iwai wrote:
> On Thu, 02 Feb 2017 04:45:48 +0100,
> Takashi Sakamoto wrote:
>>
>> I'm _strongly_ interested in your two patches, because it has a
>> potentiality to purge ASoC abuse of TLV feature, which was introduced
>> in  2014 with a bad reviewing process.
>
> I don't think it can be a replacement for the extended TLV usages.
> The proposed API is nothing but a loop of ctl elem read/write, and I'm
> not sure whether it worth to introduce the new ioctls just for that.

In my opinion, an idea to handle several control elements in one system
call could perhaps overcome current limitation of control elements,
which comes from definition of 'struct snd_ctl_elem_value'. Aim of the
abuse of TLV feature in ASoC part essentially comes from the
limitation, as long as I understand. In this aspect, I was interested
in his patchset. Of cource, I know this patchset has little functional
merits in current shape, and better designs are needed to solve the
abuse. (I have an opinion that it should have been implemented with
hwdep interface, but being too late...)

By the way, it's not time for me to work for the abuse because I have a
lot more in the other parts of this subsystem, therefore I'd like
developers to discuss this patchset without the aspect. Sorry to
introduce the other points to discuss.


Regards

Takashi Sakamoto
