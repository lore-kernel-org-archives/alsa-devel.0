From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.38] ASoC: CX20442: fix wrong
 reg_cache_default content
Date: Fri, 11 Feb 2011 11:00:58 +0000
Message-ID: <20110211110057.GA7180@opensource.wolfsonmicro.com>
References: <201102101324.40463.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8601A103875
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 12:00:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201102101324.40463.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 10, 2011 at 01:24:32PM +0100, Janusz Krzysztofik wrote:
> Content of the CX20442's snd_soc_codec_driver.reg_cache_default pointed 
> area, introduced with my recent NULL pointer dereferece fix (commit 
> f019ee5feb344ff0b22b58df4568676295aae14f), occured wrong after further 
> testing, more thorough than just booting successfully. There are two 
> problems with it:

Applied, thanks.
