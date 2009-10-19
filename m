From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] Fix possible codec_dai->ops NULL
	pointer problems
Date: Mon, 19 Oct 2009 16:16:00 +0100
Message-ID: <20091019151559.GA14507@rakim.wolfsonmicro.main>
References: <1255688018-1301-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4071E243D2
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Oct 2009 17:16:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255688018-1301-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <barry.song@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 16, 2009 at 06:13:38PM +0800, Barry Song wrote:

> Some codec DAIs like stac9766, wm9712, wm9713, ad1980 don't register themselves
> then it loses to the chance to be given a null_dai_ops in snd_soc_register_dai
> if they have no ops. When functions like soc_pcm_open, soc_pcm_hw_params etc.
> access the ops field in these DAIs, panic will happen.
> 
> Signed-off-by: Barry Song <21cnbao@gmail.com>

Applied, thanks.
