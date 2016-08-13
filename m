From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] amidi: ignore not only Active Sensing
 but also Clock bytes
Date: Sat, 13 Aug 2016 20:14:46 +0900
Message-ID: <b630d5ab-da0d-d92f-010b-b8c8e4698be7@sakamocchi.jp>
References: <ac3f1f9a-5201-7a98-e659-fd9bbcf41ab7@ladisch.de>
 <bde1ef45-8255-5ca7-01fc-5dbf0b8f3684@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 16900265AAC
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 13:14:51 +0200 (CEST)
In-Reply-To: <bde1ef45-8255-5ca7-01fc-5dbf0b8f3684@ladisch.de>
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

Hi Clemens,

On Aug 13 2016 19:28, Clemens Ladisch wrote:
> Active Sensing messages are sent by many devices in the background and
> would only interfere with the actual messages that amidi is supposed to
> capture.  Therefore, amidi ignores them by default.  However, there are
> also devices that send Clock messages with the same problem, so it is
> a better idea to filter them out, too.
> 
> Reported-by: Martin Tarenskeen <m.tarenskeen@gmail.com>
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> ---
>  amidi/amidi.1 |   19 ++++++++++++++-----
>  amidi/amidi.c |   13 +++++++++++--
>  2 files changed, 25 insertions(+), 7 deletions(-)
> 
> ...
>
> diff --git a/amidi/amidi.c b/amidi/amidi.c
> index cedf18c..58ac814 100644
> --- a/amidi/amidi.c
> +++ b/amidi/amidi.c
> @@ -77,7 +77,8 @@ static void usage(void)
>  		"-d, --dump             print received data as hexadecimal bytes\n"
>  		"-t, --timeout=seconds  exits when no data has been received\n"
>  		"                       for the specified duration\n"
> -		"-a, --active-sensing   don't ignore active sensing bytes\n");
> +		"-a, --active-sensing   include active sensing bytes\n"
> +		"-c, --clock            include clock bytes\n");
>  }
> 
>  static void version(void)
> @@ -419,10 +420,12 @@ int main(int argc, char *argv[])
>  		{"dump", 0, NULL, 'd'},
>  		{"timeout", 1, NULL, 't'},
>  		{"active-sensing", 0, NULL, 'a'},
> +		{"clock", 0, NULL, 'c'},
>  		{ }

Need to modify a table for short options.

diff --git a/amidi/amidi.c b/amidi/amidi.c
index 290df48..ea61cba 100644
--- a/amidi/amidi.c
+++ b/amidi/amidi.c
@@ -411,7 +411,7 @@ static void add_send_hex_data(const char *str)

 int main(int argc, char *argv[])
 {
-       static const char short_options[] = "hVlLp:s:r:S::dt:a";
+       static const char short_options[] = "hVlLp:s:r:S::dt:a:c";
        static const struct option long_options[] = {
                {"help", 0, NULL, 'h'},
                {"version", 0, NULL, 'V'},

Regards

Takashi Sakamoto
