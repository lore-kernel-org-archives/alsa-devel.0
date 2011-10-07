From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Suppress early calls to
	snd_soc_dapm_sync()
Date: Fri, 7 Oct 2011 15:33:42 +0100
Message-ID: <20111007143341.GJ14518@opensource.wolfsonmicro.com>
References: <1317994442-21459-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1381533.VkWoivMzrE@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D2EDF103B91
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 16:33:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1381533.VkWoivMzrE@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 07, 2011 at 05:18:19PM +0300, P=E9ter Ujfalusi wrote:
> On Friday 07 October 2011 14:34:02 Mark Brown wrote:

> >  	card->instantiated =3D 1;
> > +	snd_soc_dapm_sync(&card->dapm);

> Without prior snd_soc_dapm_new_widgets() call we just moved the kernel cr=
ash
> here.

As I keep saying new_wigets() is orthogonal to the syncing.  They are
two totally separate issues.  There's a good solid reason why I didn't
mention any issues with uninitialized widgets in the changelog which is
that this patch is not intended to help with that in any way, it's
intended to stop us wasting our time (and potentially introducing pops
and clicks from bouncing power) performing needless syncs while starting
up.

The syncs that are being suppressed are totally pointless regardless of
anything else.
