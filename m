From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl4030: Convert to use DAI DAPM
	widgets
Date: Sat, 22 Sep 2012 10:56:59 -0400
Message-ID: <20120922145659.GC4495@opensource.wolfsonmicro.com>
References: <1348147922-22527-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C2AA3261647
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 16:57:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1348147922-22527-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 20, 2012 at 04:32:02PM +0300, Peter Ujfalusi wrote:
> Use DAPM mapping for stream events and give unique names for the streams.
> This change also fixes the following warning:
> twl4030-codec twl4030-codec: Failed to create Capture debugfs file

Applied, thanks.
