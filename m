From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v6 2/2] amidi: use GNU getopt_long() proper
	argument names
Date: Tue, 30 Aug 2016 08:22:07 +0900
Message-ID: <9216de97-1bea-8848-29fd-2a90f8136626@sakamocchi.jp>
References: <20160823140938.21423-1-eu@felipetonello.com>
 <20160823140938.21423-3-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id F21C7265770
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 01:22:10 +0200 (CEST)
In-Reply-To: <20160823140938.21423-3-eu@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Felipe F. Tonello" <eu@felipetonello.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Aug 23 2016 23:09, Felipe F. Tonello wrote:
> This has no affect besides more clarity to the code.
> 
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
>  amidi/amidi.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/amidi/amidi.c b/amidi/amidi.c
> index d0dbb322f80a..088da56e2139 100644
> --- a/amidi/amidi.c
> +++ b/amidi/amidi.c
> @@ -415,19 +415,19 @@ int main(int argc, char *argv[])
>  {
>  	static const char short_options[] = "hVlLp:s:r:S::dt:acD:";
>  	static const struct option long_options[] = {
> -		{"help", 0, NULL, 'h'},
> -		{"version", 0, NULL, 'V'},
> -		{"list-devices", 0, NULL, 'l'},
> -		{"list-rawmidis", 0, NULL, 'L'},
> -		{"port", 1, NULL, 'p'},
> -		{"send", 1, NULL, 's'},
> -		{"receive", 1, NULL, 'r'},
> -		{"send-hex", 2, NULL, 'S'},
> -		{"dump", 0, NULL, 'd'},
> -		{"timeout", 1, NULL, 't'},
> -		{"active-sensing", 0, NULL, 'a'},
> -		{"clock", 0, NULL, 'c'},
> -		{"delay", 1, NULL, 'D'},
> +		{"help", no_argument, NULL, 'h'},
> +		{"version", no_argument, NULL, 'V'},
> +		{"list-devices", no_argument, NULL, 'l'},
> +		{"list-rawmidis", no_argument, NULL, 'L'},
> +		{"port", required_argument, NULL, 'p'},
> +		{"send", required_argument, NULL, 's'},
> +		{"receive", required_argument, NULL, 'r'},
> +		{"send-hex", optional_argument, NULL, 'S'},
> +		{"dump", no_argument, NULL, 'd'},
> +		{"timeout", required_argument, NULL, 't'},
> +		{"active-sensing", no_argument, NULL, 'a'},
> +		{"clock", no_argument, NULL, 'c'},
> +		{"delay", required_argument, NULL, 'D'},
>  		{ }
>  	};
>  	int c, err, ok = 0;

This patch should be posted separately from this patchset, because it's
just for code improvement regardless of your new feature. This patch
might be independently merged without long discussions.


Regards

Takashi Sakamoto
