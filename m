From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: DaVinci: i2s,
	reduce underruns by combining	into 1 element
Date: Thu, 19 Nov 2009 10:50:54 +0000
Message-ID: <20091119105054.GD15460@sirena.org.uk>
References: <1258591794-18416-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E62B1037EA
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 11:50:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258591794-18416-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 18, 2009 at 05:49:51PM -0700, Troy Kisky wrote:
> Allow the left and right 16 bit samples to be shifted out as 1
> 32 bit sample.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Applied all four (finally!), thanks.
