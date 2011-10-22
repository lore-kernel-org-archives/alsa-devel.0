From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc: keep pointer to resource so it
	can be freed
Date: Sat, 22 Oct 2011 10:47:08 +0100
Message-ID: <20111022094708.GB3382@opensource.wolfsonmicro.com>
References: <1318950399-17201-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B866103819
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Oct 2011 11:47:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318950399-17201-1-git-send-email-julia@diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 18, 2011 at 05:06:39PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Add a new variable for storing resources accessed subsequent to the one
> accessed using request_mem_region, so the one accessed using
> request_mem_region can be released if needed.

Applied, thanks.

Please try to match your subject lines with those normally used for the
subsystem.
