From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: CX20442: fix NULL pointer dereference
Date: Tue, 1 Feb 2011 14:31:16 +0000
Message-ID: <20110201143116.GK12743@opensource.wolfsonmicro.com>
References: <201102011301.17699.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1ABBD103951
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:31:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201102011301.17699.jkrzyszt@tis.icnet.pl>
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

On Tue, Feb 01, 2011 at 01:01:17PM +0100, Janusz Krzysztofik wrote:
> The CX20442 codec driver never provided the snd_soc_codec_driver's 
> .reg_cache_default member. With the latest ASoC framework changes, it 
> seems to be referred unconditionally, resulting in a NULL pointer 
> dereference if missing. Provide it.

Applied, thanks.
