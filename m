From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd-hdsp driver error?
Date: Fri, 15 Jan 2010 00:02:05 +0800
Message-ID: <4f3252891001140802y7bb31156q74f87ba13bca82f4@mail.gmail.com>
References: <933ed0910911020433j59c4907q94ee073e5f09e328@mail.gmail.com>
	<4f3252890911022248w5d2a2d73s74bb0412e8f4e0c7@mail.gmail.com>
	<933ed0910911031105m608009cbg2ccd1c543887befa@mail.gmail.com>
	<4f3252890911042029m18db97d0qc324b37d1c1dd330@mail.gmail.com>
	<933ed0910911051646u71594153ue23984ae32c70d8e@mail.gmail.com>
	<4f3252890911051753x650bc617te8086af4fc3a745f@mail.gmail.com>
	<933ed0910911060823x4f512b32h546167eea73050df@mail.gmail.com>
	<4f3252890911061512i5f6c439cyd977e5fb67c84693@mail.gmail.com>
	<s5h4op5qp94.wl%tiwai@suse.de>
	<933ed0910911081030p1323d375g7fd719358bfa9e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BBF61038FF
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 17:02:07 +0100 (CET)
Received: by pwj3 with SMTP id 3so5581223pwj.32
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 08:02:05 -0800 (PST)
In-Reply-To: <933ed0910911081030p1323d375g7fd719358bfa9e9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/11/9 Lars Zobbe <fedesensfar@gmail.com>

> Thanks a lot Takashi and Raymond.
>
> I guess that means the fix from tom-ipp, that Raymond referred to, won't
> work. So what can I do to help you fix this. Do you want me to try and run
> something? I would be pleased to help out.
> When you say "the problem is somewhere else". Do you have an idea about
> where that could be?
>
> Greetings
> Lars.
>
>
Refer to

http://pulseaudio.org/ticket/764#comment:1


load-module module-alsa-sink device_id=0 tsched=0 load-module
module-alsa-source device_id=0 tsched=0
