From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Add support for
 changing upper threshold
Date: Mon, 7 Jun 2010 10:16:55 +0100
Message-ID: <20100607091655.GA23093@rakim.wolfsonmicro.main>
References: <1275897039-7577-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 89B721037F1
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 11:16:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275897039-7577-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 07, 2010 at 10:50:39AM +0300, Peter Ujfalusi wrote:
> Upper threshold is used in mode7 of DAC33.
> Instead of hard wired UTHR, add control to change the upper threshold
> value.
> Changing upper threshold is not allowed when the playback is already
> running, since wrongly timed change in the UTHR can cause problems
> with the codec.
> With this control the length of the burst in mode7 can be changed.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
