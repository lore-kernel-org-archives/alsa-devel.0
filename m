From: The Source <thesourcehim@gmail.com>
Subject: Re: Long-standing SDL ALSA bug
Date: Tue, 13 Oct 2009 07:36:31 +0400
Message-ID: <4AD3F5BF.4070006@gmail.com>
References: <3adffa60910121114p54e74010r541c6cee86db6721@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id B4CC91037FF
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 05:36:34 +0200 (CEST)
Received: by ewy21 with SMTP id 21so78055ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2009 20:36:34 -0700 (PDT)
In-Reply-To: <3adffa60910121114p54e74010r541c6cee86db6721@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sam Lantinga <slouken@libsdl.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

12.10.2009 22:14, Sam Lantinga ?????:
> Hey guys, we're in the process of getting ready to release SDL 1.2.14,
> and we're trying to fix a long standing issue with crackling and pops
> in ALSA with some configurations:
> http://bugzilla.libsdl.org/show_bug.cgi?id=650
>
> What's really puzzling is that we're not able to reproduce it ourselves at all.
>
> I'm attaching the latest versions of the SDL audio files, and I'd
> really appreciate it if you take a look and sanity check our code.
> You can get the full pre-release here:
> http://www.libsdl.org/tmp/SDL-1.2.zip
>
> Thanks!
>    
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>    
I may be wrong but I have a feeling that the problem is in the 
pulseaudio actually not in alsa.
There's a thing called alsa-plugins-pulseaudio which creates virtual 
alsa device. This device sends all sound output to pulseaudio.
Many modern distributions like to use this device as default. And 
pulseaudio still has some crackling issues, yes.
