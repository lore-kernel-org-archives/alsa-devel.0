From: Philippe =?ISO-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using mc13783
 codec
Date: Wed, 25 Jan 2012 16:45:40 +0100
Message-ID: <2667396.yifGumf5nD@laptop>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
 <4E1711EA.5070209@televic.com> <201107271028.09928.philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201107271028.09928.philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lambrecht =?ISO-8859-1?Q?J=FCrgen?= <J.Lambrecht@televic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, =?ISO-8859-1?Q?J=FCrgen?= Lambrecht <juergen.lambrecht@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi

> Le vendredi 8 juillet 2011 16:19:22, Lambrecht J=FCrgen a =E9crit :
> > indeed, doesn't work at all. I know it used to work on 2.6.34.
> > We also have a fsl linux 2.6.22 were it works.
> > I must say: when i use aplay to play a mono file, then there is no
> > error, it just never ends, and no sound also.
> > For a stereo file, it gives the error.
> > Mark also that when I use madplay (v0.15.2) (or mp3play) to play a mono
> > or stereo mp3, it allocates 3 DMA channels, but only frees one after the
> > error.
> =

> Did you made any progress on this ?

I have a working sound support for the mx31moboard boards available here:
http://github.com/retornaz/linux/commits/moboard-sound

It's basically Sascha mc13783 codec driver (from his git tree) rebased on 3=
.2 =

and some mx31moboad specific code.

I can playback & record sound on our board (2 channels@16Khz) with the sdma.

Sascha, do you have any plan to upstream the mc13783 codec driver ? =


Thanks,

Philippe
