From: Cyril Hrubis <metan.lists@gmail.com>
Subject: Re: TASCAM US-122mkII
Date: Fri, 19 Aug 2011 13:54:09 +0200
Message-ID: <20110819115409.GA21095@yumi>
References: <20110819100156.GA31665@yumi>
	<CACTFLANmONgmCtPKFpofJGQ72a5BSbZHkj5+e=yGfDrynDPrQA@mail.gmail.com>
	<20110819113727.GA9522@yumi>
	<CACTFLAPnWpq7AQ3KZakqkLRV7CtgDG-fXM77T9NLK5o90hfxzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id EB9D524664
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 13:54:07 +0200 (CEST)
Received: by fxh10 with SMTP id 10so2060733fxh.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2011 04:54:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACTFLAPnWpq7AQ3KZakqkLRV7CtgDG-fXM77T9NLK5o90hfxzA@mail.gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!
> > As far as I understand it, there are two endpoints for audio and two for
> > MIDI. The MIDI part seems to be initalized fine although I don't have
> > any MIDI device to test it.
> >
> > And in the log from windows machine the audio part does some
> > intialization and then only buch of isochronous transfers.
> 
> Hmm, so it seems that our only option is really to look at these
> Windows dumps and reverse-engineer the protocol.

Looks so, anybody could lend a helping hand (or a good HOWTO), I'm still
new to USB, kernel USB subsystem and alsa.

-- 
Cyril Hrubis
