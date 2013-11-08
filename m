From: "Oskar Schirmer" <oskar@scara.com>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-fiq: Remove unused
	'runtime' variable
Date: 8 Nov 2013 07:56:11 +0000
Message-ID: <20131108075611.GA5473@curry>
References: <1383879300-19947-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from skyrme.org (skyrme.org [193.175.80.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 344C8265615
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 08:56:14 +0100 (CET)
Received: from p5b3071f2.dip0.t-ipconnect.de ([91.48.113.242]
 helo=curry.scara.com)
 by skyrme.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.63) (envelope-from <oskar@scara.com>) id 1VegvO-0004z4-6d
 for alsa-devel@alsa-project.org; Fri, 08 Nov 2013 07:56:14 +0000
Content-Disposition: inline
In-Reply-To: <1383879300-19947-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 08, 2013 at 00:55:00 -0200, Fabio Estevam wrote:
> Commit 68f9672b (ASoC: fsl: imx-pcm-fiq: remove bogus period delta calculation)
> introduced the following build warning:
> 
> sound/soc/fsl/imx-pcm-fiq.c:53:26: warning: unused variable 'runtime' [-Wunused-variable]
> 
> Remove the unused 'runtime' variable.

Acked-by: Oskar Schirmer <oskar@scara.com>
