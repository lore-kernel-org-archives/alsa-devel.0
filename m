From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: WM8994: Improve robustness in
	some use cases
Date: Fri, 11 Feb 2011 11:15:49 +0000
Message-ID: <20110211111549.GD7180@opensource.wolfsonmicro.com>
References: <1297344478-30490-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9D911037F2
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 12:15:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297344478-30490-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 10, 2011 at 01:27:57PM +0000, Dimitris Papastamos wrote:
> Ensure that on disabling certain registers such as AIF1DAC1L,
> AIF1DAC1R etc. the AIF1CLK and AIF2CLK remain enabled.  Similarly
> when enabling those registers, AIF1CLK and AIF2CLK will remain
> disabled.

These don't apply against 2.6.38 - could you please regenerate them
against that?
