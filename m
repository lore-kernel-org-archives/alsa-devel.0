From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: VIA VT1708 bugs
Date: Wed, 5 Jan 2011 07:32:02 +0800
Message-ID: <AANLkTinjHQ5+4JOsc6GRZr2m+9x3jjdkwv11AGc9DDV1@mail.gmail.com>
References: <4D22C24A.1080302@canonical.com>
	<AANLkTik8uKj97GOOOtPuftePUDcs01nP8aAHsOtAmiZE@mail.gmail.com>
	<4D22E69E.1000101@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5DEF5243BD
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 00:32:05 +0100 (CET)
Received: by ewy19 with SMTP id 19so6142948ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 04 Jan 2011 15:32:03 -0800 (PST)
In-Reply-To: <4D22E69E.1000101@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/4 David Henningsson <david.henningsson@canonical.com>

>
>
> Ok, that makes some sense. It translates to me as
> * With independent HP turned off - activates auto-mute between
> speaker-out/line-out and headphone out. Note the difference between VIA
> and Realtek/Sigmatel here as line-out are auto-muted as well.
>

The point is using ac97 front panel connector does not allow you to know
whether the headphone plugged in , the presence of headphone is only know
when you are using HDA front panel and HDA codec. so line-out of a desktop
is usually not auto muted

http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm
