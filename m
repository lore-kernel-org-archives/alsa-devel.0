From: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>
Subject: Re: [PATCH 13/19] ASoC: s6000: Don't set unused struct
 snd_pcm_hardware fields
Date: Sun, 22 Dec 2013 23:21:40 +0100
Message-ID: <20131222222140.GA6220@minime.bse>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-13-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 89EA82610A0
 for <alsa-devel@alsa-project.org>; Sun, 22 Dec 2013 23:21:45 +0100 (CET)
Received: from minime.bse ([77.20.120.199]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MQih7-1W4Ntc0AY9-00U4XW for
 <alsa-devel@alsa-project.org>; Sun, 22 Dec 2013 23:21:45 +0100
Content-Disposition: inline
In-Reply-To: <1387545625-19240-13-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 20, 2013 at 02:20:19PM +0100, Lars-Peter Clausen wrote:
> -	.formats =3D (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE),

I'm still interested in the outcome of the DPCM issue mentioned in the
Kirkwood thread, but as the only known board using this driver is not
affected:

Acked-by: Daniel Gl=F6ckner <daniel-gl@gmx.net>
