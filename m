From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/2] ASoC: tlv320dac33: Request for reordered
 update power sequence
Date: Thu, 2 Dec 2010 13:15:06 +0000
Message-ID: <20101202131505.GE859@rakim.wolfsonmicro.main>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291291390-8669-3-git-send-email-peter.ujfalusi@nokia.com>
	<20101202122423.GB859@rakim.wolfsonmicro.main>
	<201012021452.04720.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36D3E10383E
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 14:15:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012021452.04720.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 02, 2010 at 02:52:04PM +0200, Peter Ujfalusi wrote:

> Back to the naming.. What about reorder_dapm_update_power, and move the flag to 
> the snd_soc_dapm_widget struct?

If we're going down this route I'd rather have a name that reflected the
new ordering rather than the fact that there's an ordering change.  Not
that any ideas occur to me right now.
