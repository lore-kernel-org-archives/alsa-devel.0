From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Debug wrong parameter
Date: Wed, 22 Dec 2010 11:14:32 +0000
Message-ID: <20101222111431.GD12426@opensource.wolfsonmicro.com>
References: <1293011184-5171-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64A7D10388E
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 12:14:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293011184-5171-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: cw00.choi@samsung.com, alsa-devel@alsa-project.org, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 22, 2010 at 06:46:24PM +0900, Seungwhan Youn wrote:
> snd_soc_jack_new()'s first parameter was changed from snd_soc_card to
> snd_soc_codec after Multi-Component support patches. So, this patch
> fixes parameter that we missed.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Applied, thanks.
