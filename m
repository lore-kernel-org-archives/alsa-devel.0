From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH v4] ASoC: Add Freescale SGTL5000 codec
	support
Date: Mon, 21 Feb 2011 08:59:58 -0600
Message-ID: <AANLkTinVCB5RdcB9Um+d5La9-_0x6zKmH-9V5He+wJ+z@mail.gmail.com>
References: <1298246965-22575-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4927E24399
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 16:00:55 +0100 (CET)
Received: by fxm11 with SMTP id 11so1273929fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 07:00:53 -0800 (PST)
In-Reply-To: <1298246965-22575-1-git-send-email-zhaoming.zeng@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhaoming.zeng@freescale.com
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, zengzm.kernel@gmail.com, linuxzsc@gmail.com, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 20, 2011 at 6:09 PM,  <zhaoming.zeng@freescale.com> wrote:

> +#Freescale SGTL5000 codec
> +config SND_SOC_SGTL5000
> + =A0 =A0 =A0 tristate
> +

I meant that you should add actual "help" text so that a person
selecting this driver would know what it is.  Like this:

config SND_SOC_SGTL5000
   tristate "Freescale SGTL5000 audio codec"
   help
      Select this option to enable the Freescale SGTL5000 audio codec, etc =
etc

Add some text that explains the capabilities and limitations of this
driver (e.g. what features of the codec are *not* supported)


Other than that, the driver looks okay to me, although I am surprised
your toolchain insists on the void* cast.

-- =

Timur Tabi
Linux kernel developer at Freescale
