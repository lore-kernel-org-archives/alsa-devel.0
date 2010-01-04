From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fixup oops in generic AC97 codec glue
Date: Mon, 4 Jan 2010 18:27:52 +0000
Message-ID: <20100104182752.GA19003@rakim.wolfsonmicro.main>
References: <1262618989-15018-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5212245E0
	for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2010 19:27:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1262618989-15018-1-git-send-email-manuel.lauss@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, pascal@pabr.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 04, 2010 at 04:29:49PM +0100, Manuel Lauss wrote:
> Initialize the glue by calling snd_soc_new_ac97_codec() as is done
> in other ASoC AC97 codecs.  Fixes an oops caused by dereferencing
> uninitialized members in snd_soc_new_pcms().
> 
> Run-tested on Au1250.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Excellent, thanks for tracking this down.
