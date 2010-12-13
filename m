From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2.6.38] ASoC: Fix build error caused by
 merging a fix for 2.6.37 into 2.6.38
Date: Mon, 13 Dec 2010 16:47:09 +0000
Message-ID: <20101213164709.GD25519@rakim.wolfsonmicro.main>
References: <1292007235-22090-1-git-send-email-jhnikula@gmail.com>
	<1292007289-22124-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F1F8D2466C
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 17:47:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292007289-22124-1-git-send-email-jhnikula@gmail.com>
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

On Fri, Dec 10, 2010 at 08:54:49PM +0200, Jarkko Nikula wrote:
> Fix "ASoC: Fix bias power down of non-DAPM codec" for 3.6.37 will cause a
> build error when merging into ASoC for-2.6.38. Fix the issue by doing a
> change that commit ce6120c "ASoC: Decouple DAPM from CODECs" would do.

Applied, thanks.
