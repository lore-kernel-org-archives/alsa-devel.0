From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8776: add missing break in sample
	size switch
Date: Fri, 23 Dec 2011 18:07:32 +0000
Message-ID: <20111223180731.GA6361@opensource.wolfsonmicro.com>
References: <CAGhQ9Vw4=ab2_DyYk6rcnEZyxh0MA1NiWB+AE3iovsbEC1rc8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8517510402A
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 19:07:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAGhQ9Vw4=ab2_DyYk6rcnEZyxh0MA1NiWB+AE3iovsbEC1rc8Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 23, 2011 at 05:32:25PM +0100, Joachim Eastwood wrote:
> Broken in commit d1dc698a54259cb454284456483b45f67c865cf8
> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>

Applied, but I had to manually fix the word wrapping your mail program
introduced:

> +++ b/sound/soc/codecs/wm8776.c
> @@ -241,6 +241,7 @@ static int wm8776_hw_params(struct
> snd_pcm_substream *substream,

which meant patch couldn't understand it.
