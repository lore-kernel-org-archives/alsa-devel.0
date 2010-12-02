From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/2] ASoC: tlv320dac33: Request for reordered
 update power sequence
Date: Thu, 2 Dec 2010 12:24:23 +0000
Message-ID: <20101202122423.GB859@rakim.wolfsonmicro.main>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291291390-8669-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A744E10381B
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 13:24:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291291390-8669-3-git-send-email-peter.ujfalusi@nokia.com>
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

On Thu, Dec 02, 2010 at 02:03:10PM +0200, Peter Ujfalusi wrote:

> +	codec->dapm.dapm_reorder_pupdate = 1;

Sorry, meant to say on the previous patch: it's also not ideal that this
affects all widgets on the CODEC, it means that this is an all or
nothing change which isn't ideal.
