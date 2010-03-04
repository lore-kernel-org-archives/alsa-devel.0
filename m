From: Risto Suominen <risto.suominen@gmail.com>
Subject: Re: snd-powermac @ G4 DA (PowerMac3,
	4) - headphone 	detection doesn't work
Date: Thu, 4 Mar 2010 23:37:41 +0200
Message-ID: <46e1c7761003041337s6caeb602nac0a740a296dd91e@mail.gmail.com>
References: <29bea45b1002230820m5111e0cu6006e6636201049e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A8C3103834
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 22:37:43 +0100 (CET)
Received: by fxm20 with SMTP id 20so7488119fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 04 Mar 2010 13:37:42 -0800 (PST)
In-Reply-To: <29bea45b1002230820m5111e0cu6006e6636201049e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Douglas Mencken <dougmencken@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sounds strange. MM-ing 'Auto Mute' would mean disabling it, so
plugging anything should have no effect.

You could try running alsamixer while plugging in the headphones. This
should be instantly visible: 'Headphone Detection' MM -> OO, 'PC
Speaker' OO -> MM. (when 'Auto Mute' OO)

On my iMac G4 800 MHz, with Tumbler audio and ALSA driver 1.0.22.1,
everything works with snd-powermac.

Risto
