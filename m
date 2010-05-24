From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: usb/caiaq: fix Traktor Kontrol X1
	ABS_HAT2X axis
Date: Mon, 24 May 2010 23:09:02 +0200
Message-ID: <20100524210902.GK30804@buzzloop.caiaq.de>
References: <1274357704-15113-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A747210385B
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 23:09:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 1F91B7F403B
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 23:09:18 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yVtWAj6SHV03 for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 23:09:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274357704-15113-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ping - Just to make sure this isn't getting lost :)


On Thu, May 20, 2010 at 02:15:04PM +0200, Daniel Mack wrote:
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> ---
>  sound/usb/caiaq/input.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
> index 8bbfbfd..dcb6207 100644
> --- a/sound/usb/caiaq/input.c
> +++ b/sound/usb/caiaq/input.c
> @@ -171,7 +171,7 @@ static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *dev,
>  		input_report_abs(input_dev, ABS_HAT0Y, (buf[4] << 8)  | buf[5]);
>  		input_report_abs(input_dev, ABS_HAT1X, (buf[12] << 8) | buf[13]);
>  		input_report_abs(input_dev, ABS_HAT1Y, (buf[2] << 8)  | buf[3]);
> -		input_report_abs(input_dev, ABS_HAT2X, (buf[15] << 8) | buf[15]);
> +		input_report_abs(input_dev, ABS_HAT2X, (buf[14] << 8) | buf[15]);
>  		input_report_abs(input_dev, ABS_HAT2Y, (buf[0] << 8)  | buf[1]);
>  		input_report_abs(input_dev, ABS_HAT3X, (buf[10] << 8) | buf[11]);
>  		input_report_abs(input_dev, ABS_HAT3Y, (buf[6] << 8)  | buf[7]);
> -- 
> 1.7.1
> 
