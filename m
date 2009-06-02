From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: ASoC: TWL4030 driver support multi channel playback
Date: Tue, 2 Jun 2009 09:04:46 +0300
Message-ID: <200906020904.46719.peter.ujfalusi@nokia.com>
References: <ef0d8a250906010720n144bb53bl4c6cc3e79e0f8db9@mail.gmail.com>
	<200906020816.41806.peter.ujfalusi@nokia.com>
	<ef0d8a250906012233n477a3afdtf8eb7a71f5e8378e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id A7FF62441C
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 08:04:50 +0200 (CEST)
In-Reply-To: <ef0d8a250906012233n477a3afdtf8eb7a71f5e8378e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 02 June 2009 08:33:59 ext Naveen Krishna Ch wrote:
> 2. Backport the twl4030 codec driver with minimal amount of ASoC changes
> I tried this last night,  i was able to boot the board...
> Except the following thing
>
> Advanced Linux Sound Architecture Driver Version 1.0.18rc3.
> No device for DAI twl4030
> No device for DAI twl4030 Voice
> No device for DAI omap-mcbsp-dai-0
> No device for DAI omap-mcbsp-dai-1
> No device for DAI omap-mcbsp-dai-2
> No device for DAI omap-mcbsp-dai-3
> No device for DAI omap-mcbsp-dai-4
> omap3apple SoC init
> ALSA device list:
>   No soundcards found.
>
> I tried to fix this, it seems like a dev structure is missing during the
> codec registration. Can u help me find where i went wrong..

To resolve this you need to backport the changes in sound/soc/omap-* also a=
nd =

probably take a look at arch/arm/plat-omap/mcbsp.c as well.


-- =

P=E9ter
