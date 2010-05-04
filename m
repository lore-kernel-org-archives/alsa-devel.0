From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: TLV mapping for tpa6140a2
Date: Tue, 4 May 2010 10:41:43 +0100
Message-ID: <20100504094142.GA15454@rakim.wolfsonmicro.main>
References: <1272960498-9560-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A2412458D
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 11:41:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272960498-9560-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, ilkka.koskinen@nokia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 04, 2010 at 11:08:18AM +0300, Peter Ujfalusi wrote:
> Both tpa6130a2, and tpa6140a2 is supported by the
> same driver, but the gain dB scaling is different on
> the amplifiers.
> 
> Provide different mixer control for the chips with correct
> TLV mapping.
> 
> User space will see:
> "TPA6130A2 Headphone Playback Volume" in case of 6130
> "TPA6140A2 Headphone Playback Volume" in case of 6140
> 
> The way machine drivers are using this amplifier remained
> the same.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
