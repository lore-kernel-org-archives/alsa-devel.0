From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8903: Fix Digital Capture
	Volume	range
Date: Tue, 10 May 2011 10:49:18 +0100
Message-ID: <20110510094918.GB20459@sirena.org.uk>
References: <1304980323-18857-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CCA941038E7
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 11:49:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304980323-18857-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, May 09, 2011 at 04:32:03PM -0600, Stephen Warren wrote:
> Increase the range of the Digital Capture Volume control to be 120 steps.
> Each step is 0.75dB, and the range starts at -72dB, giving a max setting
> of 18dB, which matches the latest datasheet, to the precision of the step
> size.
> 
> Tested-on: Seaboard non-clamshell.
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied, thanks.
