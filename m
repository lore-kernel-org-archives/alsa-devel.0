From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] amidi: ignore not only Active Sensing
 but also Clock bytes
Date: Sat, 13 Aug 2016 20:27:27 +0900
Message-ID: <7982b196-edae-3330-86a8-83338e182f3e@sakamocchi.jp>
References: <ac3f1f9a-5201-7a98-e659-fd9bbcf41ab7@ladisch.de>
 <bde1ef45-8255-5ca7-01fc-5dbf0b8f3684@ladisch.de>
 <b630d5ab-da0d-d92f-010b-b8c8e4698be7@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 56B6E2659FE
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 13:27:34 +0200 (CEST)
In-Reply-To: <b630d5ab-da0d-d92f-010b-b8c8e4698be7@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Aug 13 2016 20:14, Takashi Sakamoto wrote:
> Need to modify a table for short options.
> 
> diff --git a/amidi/amidi.c b/amidi/amidi.c
> index 290df48..ea61cba 100644
> --- a/amidi/amidi.c
> +++ b/amidi/amidi.c
> @@ -411,7 +411,7 @@ static void add_send_hex_data(const char *str)
> 
>  int main(int argc, char *argv[])
>  {
> -       static const char short_options[] = "hVlLp:s:r:S::dt:a";
> +       static const char short_options[] = "hVlLp:s:r:S::dt:a:c";

Oops. This should be "hVlLp:s:r:S::dt:ac"...

>         static const struct option long_options[] = {
>                 {"help", 0, NULL, 'h'},
>                 {"version", 0, NULL, 'V'},


Regards

Takashi Sakamoto
