From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Show sequencer sound card numer/PID via
	aconnect
Date: Sat, 13 Feb 2016 21:30:13 +0900
Message-ID: <56BF21D5.1040200@sakamocchi.jp>
References: <1455303396-13915-1-git-send-email-martin@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E883F260536
 for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2016 13:30:17 +0100 (CET)
In-Reply-To: <1455303396-13915-1-git-send-email-martin@mail.zuhause>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Koegler <martin.koegler@chello.at>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 13 2016 03:56, Martin Koegler wrote:
> From: Martin Koegler <martin.koegler@chello.at>
> 
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>

The idea to print owner PID or card number is itself better to me, while
I think you should add some comments to describe your intension about
this patch, at least, for the other developers or users. Would you
please re-post this patch with your comments again?


Regards

Takashi Sakamoto

> ---
>  seq/aconnect/aconnect.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/seq/aconnect/aconnect.c b/seq/aconnect/aconnect.c
> index 8d6cebb..3508e1b 100644
> --- a/seq/aconnect/aconnect.c
> +++ b/seq/aconnect/aconnect.c
> @@ -166,11 +166,19 @@ static void print_port(snd_seq_t *seq, snd_seq_client_info_t *cinfo,
>  		       snd_seq_port_info_t *pinfo, int count)
>  {
>  	if (! count) {
> -		printf(_("client %d: '%s' [type=%s]\n"),
> +		printf(_("client %d: '%s' [type=%s"),
>  		       snd_seq_client_info_get_client(cinfo),
>  		       snd_seq_client_info_get_name(cinfo),
>  		       (snd_seq_client_info_get_type(cinfo) == SND_SEQ_USER_CLIENT ?
>  			_("user") : _("kernel")));
> +		int owner = snd_seq_client_info_get_owner(cinfo);
> +		if (owner != -1) {
> +			if (snd_seq_client_info_get_type(cinfo) == SND_SEQ_USER_CLIENT)
> +				printf(",pid=%d", owner);
> +			else
> +				printf(",card=%d", owner);
> +		}
> +		printf("]\n");
>  	}
>  	printf("  %3d '%-16s'\n",
>  	       snd_seq_port_info_get_port(pinfo),
