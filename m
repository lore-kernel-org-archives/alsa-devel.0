From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Resend] [PATCH] ASoC: Amstrad Delta: fix const
 related build error
Date: Tue, 1 Feb 2011 14:16:28 +0000
Message-ID: <20110201141628.GI12743@opensource.wolfsonmicro.com>
References: <201102011038.29330.jkrzyszt@tis.icnet.pl>
	<201102011111.56190.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 004CB103918
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:16:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201102011111.56190.jkrzyszt@tis.icnet.pl>
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

On Tue, Feb 01, 2011 at 11:11:55AM +0100, Janusz Krzysztofik wrote:
> The Amstrad Delta ASoC driver used to override the digital_mute() 
> callback, expected to be not provided by the on-board CX20442 CODEC 
> driver, with its own implementation. While this is still posssible when 

Applied, thanks.
