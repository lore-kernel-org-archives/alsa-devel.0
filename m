From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.37] ASoC: Fix bias power down of
	non-DAPM codec
Date: Mon, 13 Dec 2010 16:37:31 +0000
Message-ID: <20101213163731.GC25519@rakim.wolfsonmicro.main>
References: <20101210174227.GH3200@rakim.wolfsonmicro.main>
	<1292007235-22090-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BDCF24666
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 17:37:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292007235-22090-1-git-send-email-jhnikula@gmail.com>
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

On Fri, Dec 10, 2010 at 08:53:55PM +0200, Jarkko Nikula wrote:
> Currently bias of non-DAPM codec will be powered down (standby/off) whenever
> there is a stream stop. This is wrong in simultaneous playback/capture since
> the bias is put down immediately after stopping the first stream.
> 
> Fix this by using the codec->active count when figuring out the needed bias
> level after stream stop.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Applied, thanks.
