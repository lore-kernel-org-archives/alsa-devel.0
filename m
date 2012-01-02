From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: soc-pcm: Allocate PCM operations
 dynamically to support multiple DAIs
Date: Mon, 2 Jan 2012 13:30:29 +0000
Message-ID: <20120102133028.GO4300@opensource.wolfsonmicro.com>
References: <1325492110-12743-1-git-send-email-sangsu4u.park@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78BF0103956
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 14:30:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325492110-12743-1-git-send-email-sangsu4u.park@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangsu Park <sangsu4u.park@samsung.com>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, sangsu@gmail.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 02, 2012 at 05:15:10PM +0900, Sangsu Park wrote:
> The original code does not cover the case that two DAIs(CPU) have different
> ASoC core PCM operations(like mmap, pointer...). Currently we have only one
> global soc_pcm_ops for ASoC core PCM operation. When two DAIs have different
> pointer functions, second DAI's pointer function is set for both first DAI
> and second DAI in case of original code.
> 
> This patch uses runtime's pcm_ops instead of global pcm_ops for each DAIs. So
> each DAIs can have different ASoC core PCM operations. This is needed to
> support multiple DAIs.
> ---

Actually I can't apply this as you haven't signed it off.  Please supply
a Signed-off-by for the patch.
