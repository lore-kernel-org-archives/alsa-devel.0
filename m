From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: pcm: Require both CODEC and CPU
 support when declaring stream caps
Date: Mon, 03 Jun 2013 09:47:31 +0100
Message-ID: <1370249251.2476.2.camel@loki>
References: <1370124976-25047-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 269C8261A1E
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 10:47:34 +0200 (CEST)
In-Reply-To: <1370124976-25047-1-git-send-email-broonie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2013-06-01 at 23:16 +0100, Mark Brown wrote:
> When declaring playback and capture capabilities check for both CODEC
> side and CPU side support rather than only checking for CODEC side
> support.  While it is unusual some CPUs do have unidirectional DAIs.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
