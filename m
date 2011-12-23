From: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [PATCH 6/8] ASoC: s6000: Add .owner to struct
	snd_soc_card
Date: Fri, 23 Dec 2011 12:31:41 +0100
Message-ID: <20111223113140.GA24001@emlix.com>
References: <1324622828.2295.0.camel@phoenix> <1324623142.2295.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.238])
	by alsa0.perex.cz (Postfix) with ESMTP id CF3F5103F9A
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 12:25:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324623142.2295.5.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 23, 2011 at 02:52:22PM +0800, Axel Lin wrote:
> Add missing .owner of struct snd_soc_card. This prevents the module from =
being
> removed from underneath its users.
> =

> Reported-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/s6000/s6105-ipcam.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Acked-by: Daniel Gl=F6ckner <dg@emlix.com>
