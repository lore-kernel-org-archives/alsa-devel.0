From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoc: tpa6130a2: Remove unnecessary
	variable
Date: Mon, 4 Jan 2010 14:30:36 +0200
Message-ID: <201001041430.36183.peter.ujfalusi@nokia.com>
References: <1262608203-14563-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 06582103801
	for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2010 13:31:00 +0100 (CET)
In-Reply-To: <1262608203-14563-1-git-send-email-ilkka.koskinen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Monday 04 January 2010 14:30:03 Koskinen Ilkka (Nokia-D/Tampere) wrote:
> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
> ---
>  sound/soc/codecs/tpa6130a2.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
> index 0eb33d4..8e98ccf 100644
> --- a/sound/soc/codecs/tpa6130a2.c
> +++ b/sound/soc/codecs/tpa6130a2.c
> @@ -267,12 +267,8 @@ static const struct snd_kcontrol_new
>  tpa6130a2_controls[] = { */
>  static void tpa6130a2_channel_enable(u8 channel, int enable)
>  {
> -	struct	tpa6130a2_data *data;
>  	u8	val;
> 
> -	BUG_ON(tpa6130a2_client == NULL);
> -	data = i2c_get_clientdata(tpa6130a2_client);
> -
>  	if (enable) {
>  		/* Enable channel */
>  		/* Enable amplifier */

Yes, I think this is a leftover from some earlier code that I had.
Good catch!

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
