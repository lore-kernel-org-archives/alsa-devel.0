From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: ASoC updates for 2.6.33
Date: Thu, 3 Dec 2009 12:56:52 +0200
Message-ID: <200912031256.52944.peter.ujfalusi@nokia.com>
References: <20091130155032.GC18944@rakim.wolfsonmicro.main>
	<s5hocmgwe3k.wl%tiwai@suse.de>
	<20091203103511.GA24206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C50EC10389C
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 11:57:30 +0100 (CET)
In-Reply-To: <20091203103511.GA24206@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 03 December 2009 12:35:12 ext Mark Brown wrote:
> Due to cross tree merge issues some updates to the TWL4030 MFD code are
> also included, enabling sharing of the CODEC hardware by support for the
> VIBRA interface of the devices.

To be precise: the twl4030-codec MFD driver as such (with updates) is going=
 to =

be introduced through the sound-2.6 tree as far as I know. With this change=
 the =

twl4030 soc codec driver now using much nicer way of loading/probing, this =
also =

affected some OMAP based boards (the changes for their platform code also g=
oing =

via the sound-2.6 tree).
All in all, it was quite a bit of internal change, which actually should no=
t =

affect the users at the end.

-- =

P=E9ter
