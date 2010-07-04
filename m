From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: codec: Add WM8987 device id to
	WM8750 driver
Date: Sun, 4 Jul 2010 17:59:41 +0900
Message-ID: <20100704085940.GC16825@opensource.wolfsonmicro.com>
References: <4c2e8854.cf7d0e0a.166f.3e5a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50AB024133
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Jul 2010 10:59:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4c2e8854.cf7d0e0a.166f.3e5a@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 03, 2010 at 02:46:10AM +0200, Maurus Cuelenaere wrote:
> The WM8987 codec is register compatible with the WM8750, so just add it t=
o the
> SPI and I=B2C device table.

> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

Applied, thanks.  Though...

>  	.driver =3D {
> -		.name	=3D "wm8750",
> +		.name	=3D "WM8750 SPI Codec",

...that naming isn't going to look pretty in kernel logs with dev_()
print statements.
