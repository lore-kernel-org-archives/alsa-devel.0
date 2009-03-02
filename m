From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH] ASoC: make ops a pointer in 'struct
 snd_soc_dai'
Date: Mon, 02 Mar 2009 11:13:11 +0000
Message-ID: <1235992391.31223.181.camel@vega.slimlogic.co.uk>
References: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id E0342244FC
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 12:13:22 +0100 (CET)
In-Reply-To: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-03-02 at 11:25 +0800, Eric Miao wrote:
> Considering the fact that most cpu_dai or codec_dai are using a same
> 'snd_soc_dai_ops' for several similar interfaces, 'ops' would be better
> made a pointer instead, to make sharing easier and code a bit cleaner.
> 
> The patch below is rather preliminary since the asoc tree is being
> actively developed, and this touches almost every piece of code,
> (and possibly many others in development need to be changed as
> well). Building of all codecs are OK, yet to every SoC, I didn't test
> that.
> 
> Signed-off-by: Eric Miao <eric.miao@marvell.com>

Ack

Mark, could you put this your tree. I'm a little snowed under atm.

Thanks

Liam
