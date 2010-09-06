From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/1] SOUND: wm8753, remove dead code
Date: Mon, 06 Sep 2010 11:32:30 +0100
Message-ID: <1283769150.3078.15.camel@odin>
References: <1283605929-15961-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id B358F24501
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 12:32:34 +0200 (CEST)
Received: by wyb32 with SMTP id 32so4497444wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Sep 2010 03:32:34 -0700 (PDT)
In-Reply-To: <1283605929-15961-1-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lg@opensource.wolfsonmicro.com>, jirislaby@gmail.com, tiwai@suse.de, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-09-04 at 15:12 +0200, Jiri Slaby wrote:
> There is adangling code in wm8753_probe which is never executed.
> Remove it.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Liam Girdwood <lg@opensource.wolfsonmicro.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Jaroslav Kysela <perex@suse.cz>
> ---
>  sound/soc/codecs/wm8753.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
> index 4844232..4a945d3 100644
> --- a/sound/soc/codecs/wm8753.c
> +++ b/sound/soc/codecs/wm8753.c
> @@ -1600,9 +1600,6 @@ static int wm8753_probe(struct snd_soc_codec *codec)
>  	wm8753_add_widgets(codec);
>  
>  	return 0;
> -
> -	run_delayed_work(&codec->delayed_work);
> -	return ret;
>  }
>  
>  /* power down chip */

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
