From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: TWL4030: Introduce PGAs
	for	outputs
Date: Thu, 13 Aug 2009 15:00:58 +0100
Message-ID: <20090813140058.GC31504@sirena.org.uk>
References: <1250168374-24280-1-git-send-email-peter.ujfalusi@nokia.com>
	<1250168374-24280-2-git-send-email-peter.ujfalusi@nokia.com>
	<1250168374-24280-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 309591038BC
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 16:01:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250168374-24280-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 13, 2009 at 03:59:34PM +0300, Peter Ujfalusi wrote:
> Dynamically control and control only the needed output amplifier
> muting/un-muting.
> 
> The original code was muting and un-muting the following output
> amplifiers: Earpiece PreDrivL/R, CarkitL/R at the same time
> regardless which pin is actually in use at the given moment.
> 
> Move these as separate PGA so only the needed amplifier will be touched.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
