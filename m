From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 0/5] *** SUBJECT HERE ***ASoC:
 tlv320dac33: FIFO caused delay reporting and fixes
Date: Fri, 23 Apr 2010 16:29:25 +0100
Message-ID: <20100423152925.GF27232@rakim.wolfsonmicro.main>
References: <1272006601-24946-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 906D624651
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 17:29:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272006601-24946-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Fri, Apr 23, 2010 at 10:09:56AM +0300, Peter Ujfalusi wrote:

> The values reported by the delay call has been verified by using one GPIO as a
> signal, and printout from the kernel at the same time with the delay, than
> based on the time scale on the scope several (>100) cases has been hand
> calculated and the results were compared to the kernel reported values.
> The difference were around (or less) the 10 samples, but during the bursts it
> is much harder to count, but the reported value was reasonable accurate there
> as well.

All these look good to me.
