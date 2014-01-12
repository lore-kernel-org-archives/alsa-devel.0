From: Crazy Audio <daniel@matuschek.net>
Subject: Re: [PATCH] ASoC: wm8804: Cleanup of post_table
Date: Sun, 12 Jan 2014 18:03:22 +0100
Message-ID: <20301DDF-0676-4B70-BC73-9322A5ABDD41@crazy-audio.com>
References: <alpine.DEB.2.02.1401121222180.3093@parallels-Parallels-Virtual-Platform>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 0340E261A9B
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 18:03:26 +0100 (CET)
Received: by mail-ee0-f50.google.com with SMTP id d17so289501eek.9
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 09:03:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1401121222180.3093@parallels-Parallels-Virtual-Platform>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Matuschek <daniel@matuschek.net>
Cc: alsa-devel@alsa-project.org, Dimitris.Papastamos@wolfsonmicro.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Please ignore this patch. I did some regression tests, that shows, that it does not work correctly with MCLK=256xfs
I will create a new patch...


Am 12.01.2014 um 12:31 schrieb Daniel Matuschek <daniel@matuschek.net>:

> 
> Signed-off-by: Daniel Matuschek <inof@crazy-audio.com>
> 
> Existing post_table has duplicate settings for some PLL settings.
> Only the first setting was used with mclk_div=1
> With the updated post_table, the driver
> uses mclk_div=0 whenever it is possible. This allows the WM8804
> to work at 256xfs internal clock and only use 128xfs
> internal clock for high sample rates where 256xfs is not
> supported anymore.
> 
> ---
> sound/soc/codecs/wm8804.c |    2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
> index 1704b1e..f605b8b 100644
> --- a/sound/soc/codecs/wm8804.c
> +++ b/sound/soc/codecs/wm8804.c
> @@ -307,9 +307,7 @@ static struct {
> 	unsigned int mclkdiv;
> } post_table[] = {
> 	{  2,  0, 0 },
> -	{  4,  0, 1 },
> 	{  4,  1, 0 },
> -	{  8,  1, 1 },
> 	{  8,  2, 0 },
> 	{ 16,  2, 1 },
> 	{ 12,  3, 0 },
> -- 
> 1.7.9.5
> 
