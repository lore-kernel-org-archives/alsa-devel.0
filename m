From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] ASoC: twl4030/tpa6130a2:
	DB_RANGE	mapping fixes
Date: Fri, 16 Jul 2010 11:24:05 +0100
Message-ID: <20100716102404.GE18376@sirena.org.uk>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 56FA62438C
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 12:24:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Fri, Jul 16, 2010 at 01:17:08PM +0300, Peter Ujfalusi wrote:

> There were 'holes' in the DB_RANGE and SCALE_ITEM mapping, which results
> failure, when user space requests dB value in these holes, since alsa-lib
> will fail to find a range, and can not round the requested dB to raw value.

> Fixing the drivers I'm maintaining to correctly fill the tlv struct.

This seems like a bug in alsa-lib to be honest - it doesn't seem right
to specify two values for the indexes at the edge of each range,
especially when one of those values is going to be inaccurate.
