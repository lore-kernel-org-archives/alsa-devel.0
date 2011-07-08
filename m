From: Philippe =?iso-8859-15?q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using mc13783
	codec
Date: Fri, 8 Jul 2011 16:11:25 +0200
Message-ID: <201107081611.25998.philippe.retornaz@epfl.ch>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, =?iso-8859-15?q?J=FCrgen_Lambrecht?= <juergen.lambrecht@gmail.com>, s.hauer@pengutronix.de, =?iso-8859-15?q?J=FCrgen_Lambrecht?= <J.Lambrecht@televic.com>
List-Id: alsa-devel@alsa-project.org

Le vendredi 8 juillet 2011 15:24:51, J=FCrgen Lambrecht a =E9crit :
> - Started from sound/soc/imx/phycore-mc13783.c
> - Renamed to general "imx" because also valid for imx27pdk (3ds) and other
> 3ds platforms. Or should there be a file per platform?

It's also valid on the mx31moboard platforms. So I guess it make sens to ha=
ve =

a general name.

> - Fixed some issues (add names, add read/write functions, changed
> late_initcall to module_init, configure clock input pin) - Add debug
> printing and comments.
> - Result:
>   * soundcard detection;
>   * after creating /dev entries, aplay runs;
>   * both 'aplay song.wav' and 'madplay song.mp3' give the same error:
>     a time-out waiting for DMA (ALSA pcm_lib.c:1802: playback write error
> (DMA or IRQ trouble?)) * this driver uses the DMA method; the FIQ method
> gives the same error

Does it mean this doesn't work at all to play sound ? IIRC Sascha driver us=
ed =

to work with the non-dmaengine implementation on 2.6.34.

Thanks,

Philippe
