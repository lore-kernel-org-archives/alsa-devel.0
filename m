From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 30 Apr 2010 13:24:13 +0200
Message-ID: <4BDABDDD.4050502@ladisch.de>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 77C1624347
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 13:24:15 +0200 (CEST)
In-Reply-To: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pl bossart wrote:
> When PulseAudio is used and all PCM is routed through PulseAudio
> (Fedora, Meego, etc), the notion of ALSA periods isn't very useful.
> So why not disable them entirely to reduce the number of wakeups? ...
> There are probably some cases where you don't want this type of
> behavior (broken hardware, legacy code with multiple-buffering,
> disabled timer in PulseAudio),

It's interesting that all ALSA applications except PA are "legacy".  :)

> so I think it would make sense to request the disabling of interrupts
> when hw_params are set, since this is also the time when period sizes
> are set.

Yes.  For compatibility with the existing ALSA API, this needs to be
a flag that is not enabled by default.

> I am aware that some changes would be needed in pcm_lib.c, where all
> the error checks are done.

Plus all the API changes in the ALSA kernel framework, the ALSA kernel/
userspace interface, and the alsa-lib interface.

I'll see if I can get this done over the weekend ...


Regards,
Clemens
