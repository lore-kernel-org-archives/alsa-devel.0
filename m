From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Tue, 14 Jul 2009 11:57:02 -0500
Message-ID: <1247590622.26860.13.camel@localhost.localdomain>
References: <4812c8250907050138w586919d4vd23d71b4ae14e1dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 4039E243C4
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jul 2009 18:55:32 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so1645381anc.2
	for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2009 09:55:31 -0700 (PDT)
In-Reply-To: <4812c8250907050138w586919d4vd23d71b4ae14e1dc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Duke Grable <kejento@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am I missing something?  I got this new driver and did cvscompile then
make install, but it didn't install any xfi stuff.


# ctxfi
alias snd-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
alias snd-card-0 snd-ctxfi
options snd-ctfxi index=0


what am I missing?  I don't have an ssound dir either.
On Sun, 2009-07-05 at 01:38 -0700, Duke Grable wrote: 

> Hello!
> 
> I stumbled upon these X-Fi drivers recently and ended up giving them a try.
> So far they work flawlessly, except for microphone input... I'm wondering if
> this is either just unimplemented, or if it's just an issue of
> configuration? My sound card is an "X-Fi XtremeGamer" and my distro is the
> latest version of openSuSe (2.6.27.23-0.1-default
> ). Let me know if I'm missing anything!
> 
> Thanks,
> Duke
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
