From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 1/2] ASoC: Fix kirkwood i2s mono playback
Date: Tue, 13 Jul 2010 12:38:19 +0100
Message-ID: <20100713113819.GG12686@rakim.wolfsonmicro.main>
References: <20100711212830.815827907@rtp-net.org>
	<20100711213505.842221724@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C770124435
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 13:38:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100711213505.842221724@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: arnaud.patard@rtp-net.org
Cc: alsa-devel@alsa-project.org, tbm@cyrius.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 11, 2010 at 11:28:31PM +0200, arnaud.patard@rtp-net.org wrote:
> Kirkwood controller needs to be informed if the audio stream is mono
> or not. Failing to do so will result in playing at the wrong speed.

Applied both, thanks.
