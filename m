From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix codec_dai->ops NULL pointer bug
	for	AC97 codec dai in soc-core
Date: Fri, 16 Oct 2009 10:08:41 +0100
Message-ID: <20091016090840.GI884@sirena.org.uk>
References: <1255658960-20693-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BDC6B24509
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 11:08:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255658960-20693-1-git-send-email-21cnbao@gmail.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 16, 2009 at 10:09:20AM +0800, Barry Song wrote:
> AC97 codec DAIs don't register themselves eg.stac9766, wm9712, wm9713, wm9705.c, ad1980,
> then it loses to the chance to be given a null_dai_ops in snd_soc_register_dai if they
> have no ops. When functions like soc_pcm_open, soc_pcm_hw_params etc. access the ops field
> in these DAIs, panic will happen.

This is the wrong fix - null DAI ops are supposed to be supported for
all devices since not all DAIs will be configurable.
