From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Merge common code in DAI link and
 auxiliary codec probing/removal
Date: Mon, 6 Dec 2010 19:16:06 +0000
Message-ID: <20101206191606.GH1924@rakim.wolfsonmicro.main>
References: <1291645627-4311-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2BDE1038B9
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 20:16:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291645627-4311-1-git-send-email-jhnikula@gmail.com>
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

On Mon, Dec 06, 2010 at 04:27:07PM +0200, Jarkko Nikula wrote:
> Commit 2eea392 "ASoC: Add support for optional auxiliary dailess codecs"
> added much of code that can be shared with DAI link codec probing/removal.
> Merge now this common code into new soc_probe_codec, soc_remove_codec and
> soc_post_component_init functions.

Applied, thanks.
