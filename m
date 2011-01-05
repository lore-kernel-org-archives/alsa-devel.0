From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove needless inclusion of
 tlv320aic3x.h from machine drivers
Date: Wed, 5 Jan 2011 11:29:38 +0000
Message-ID: <20110105112938.GB27706@opensource.wolfsonmicro.com>
References: <1294221944-6400-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 538F5103962
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 12:29:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294221944-6400-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2011 at 12:05:44PM +0200, Jarkko Nikula wrote:
> After multi-component conversion these machine drivers don't actually need
> anything from sound/soc/codecs/tlv320aic3x.h so don't include it.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Applied, thanks.
