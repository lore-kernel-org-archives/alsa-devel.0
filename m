From: =?iso-8859-15?Q?Lambrecht_J=FCrgen?= <J.Lambrecht@TELEVIC.com>
Subject: Re: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using
	mc13783 codec
Date: Fri, 8 Jul 2011 16:19:22 +0200
Message-ID: <4E1711EA.5070209@televic.com>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<201107081611.25998.philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201107081611.25998.philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-15?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, =?iso-8859-15?Q?J=FCrgen_Lambrecht?= <juergen.lambrecht@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 07/08/2011 04:11 PM, Philippe R=E9tornaz wrote:
>
> Le vendredi 8 juillet 2011 15:24:51, J=FCrgen Lambrecht a =E9crit :
> > - Started from sound/soc/imx/phycore-mc13783.c
> > - Renamed to general "imx" because also valid for imx27pdk (3ds) and =

> other
> > 3ds platforms. Or should there be a file per platform?
>
> It's also valid on the mx31moboard platforms. So I guess it make sens =

> to have
> a general name.
>
ok
>
> > - Fixed some issues (add names, add read/write functions, changed
> > late_initcall to module_init, configure clock input pin) - Add debug
> > printing and comments.
> > - Result:
> >   * soundcard detection;
> >   * after creating /dev entries, aplay runs;
> >   * both 'aplay song.wav' and 'madplay song.mp3' give the same error:
> >     a time-out waiting for DMA (ALSA pcm_lib.c:1802: playback write =

> error
> > (DMA or IRQ trouble?)) * this driver uses the DMA method; the FIQ method
> > gives the same error
>
> Does it mean this doesn't work at all to play sound ? IIRC Sascha =

> driver used
> to work with the non-dmaengine implementation on 2.6.34.
>
indeed, doesn't work at all. I know it used to work on 2.6.34.
We also have a fsl linux 2.6.22 were it works.
I must say: when i use aplay to play a mono file, then there is no =

error, it just never ends, and no sound also.
For a stereo file, it gives the error.
Mark also that when I use madplay (v0.15.2) (or mp3play) to play a mono =

or stereo mp3, it allocates 3 DMA channels, but only frees one after the =

error.

J=FCrgen
>
>
> Thanks,
>
> Philippe
>


-- =

J=FCrgen Lambrecht
R&D Associate
Tel: +32 (0)51 303045    Fax: +32 (0)51 310670
http://www.televic-rail.com
Televic Rail NV - Leo Bekaertlaan 1 - 8870 Izegem - Belgium
Company number 0825.539.581 - RPR Kortrijk
