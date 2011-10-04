From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 06/12] ASoC: twl6040: Prepare for core
 put_volsw/volsw_2r merger
Date: Tue, 4 Oct 2011 16:34:04 +0100
Message-ID: <20111004153403.GO6934@opensource.wolfsonmicro.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
	<1317728389-22062-7-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34ADD1039AD
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 17:34:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317728389-22062-7-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 02:39:43PM +0300, Peter Ujfalusi wrote:
> Avoid using the mc->rreg to identify the 2r type of gain control.
> Introduce a variable to track this.
> This change is needed to avoid breakage with the upcoming volsw volsw_2r
> merger.

I've applied this one, I'll not even try with the rest due to dependency
issues but I'm going to carry on with the review.
