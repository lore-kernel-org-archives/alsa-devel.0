From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/7] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Wed, 18 Jan 2012 10:37:40 +0000
Message-ID: <20120118103739.GA8732@opensource.wolfsonmicro.com>
References: <1326879895-2973-1-git-send-email-peter.ujfalusi@ti.com>
	<1326879895-2973-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E379A245C7
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 11:37:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326879895-2973-2-git-send-email-peter.ujfalusi@ti.com>
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

On Wed, Jan 18, 2012 at 10:44:49AM +0100, Peter Ujfalusi wrote:
> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Most devices accept data in formats that don't correspond directly to
> their internal format. ALSA allows us to set a msbits constraint which

Please send this series against for-3.4.
