From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 7
Date: Fri, 13 Apr 2012 09:32:17 +0200
Message-ID: <CAFz=ag7_Yj_VkfW9HWnB1=y6s+rFVJZ_VK06-jZ70U_k=Y_Ksw@mail.gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
	<CACckToUX5iLjbdtjsEFOPk1uBw63EBROe=bj9qokaczB6P5LrQ@mail.gmail.com>
	<CACckToU+zq2jrPFRJmYGA05REtfPkRjf05JqiGY+bSyDkk=p+w@mail.gmail.com>
	<4F87C587.9000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DCE42433A
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 09:32:18 +0200 (CEST)
Received: by ggni2 with SMTP id i2so1569795ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2012 00:32:17 -0700 (PDT)
In-Reply-To: <4F87C587.9000101@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, blablack@gmail.com, Grant Diffey <gdiffey@gmail.com>, clemens@ladisch.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

>> if all volumes are max on module insert. the ftu is essentially unusable
>> untill they're corrected

Yes, the current defaults for the FTUs are horrible.

But I don't know if I really like the "diagonal" state that you
proposed as a default state. At least for my setup it's not more
usable than the "all-volumes-maxed" state. I probably would prefer a
"everything-muted" default. Then you only have to deal with the
controls you actually need and don't have to bother with tons of other
controls. (And, it's more in line with non-USB devices).

If there aren't any objections to the "everything-muted-by-default"
approach, I will prepare a patch this weekend.


> What about alsactl? Set the mixers once, then call "alsactl store". Does
> that help?

Yes, for sure. That's what I have been using for a long time. It would
be desirable though if the state was stored on diconnect/shutdown of
the device. Is this possible with a udev rule?


While we're at it I would even like to discuss the FTU's control
naming scheme again.
As someone (Grant?) was pointing out some time ago the capture volumes
really are no capture volumes. It just came in handy to name them this
way to easily switch between both groups of control in alsamixer etc.

Suggestions anyone?

Regards,
Felix
