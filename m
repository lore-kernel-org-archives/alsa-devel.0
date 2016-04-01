From: Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH - aconnect 1/1] Fix aconnect printing card
 and pid on older kernels
Date: Fri, 1 Apr 2016 23:28:05 +0200
Message-ID: <20160401212805.GB20661@mail.zuhause>
References: <1459532101-6582-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe04-2.mx.upcmail.net
 (vie01a-dmta-pe04-2.mx.upcmail.net [62.179.121.164])
 by alsa0.perex.cz (Postfix) with ESMTP id CA1F72651D1
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 23:28:07 +0200 (CEST)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1am6bv-0006Q8-F1
 for alsa-devel@alsa-project.org; Fri, 01 Apr 2016 23:28:07 +0200
Content-Disposition: inline
In-Reply-To: <1459532101-6582-1-git-send-email-agoode@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@google.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, martin.koegler@chello.at
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 01, 2016 at 01:35:01PM -0400, Adam Goode wrote:
> alsa-lib is changed to return a distinct negative value if running on
> an older kernel. -1 is only returned now if the kernel knows for sure
> that there is no card or pid. On older kernels, alsa-lib will return
> -ENOSYS.
> 

Shouldn't we also update the default values of card/pid to -ENOSYS to be more consistent:
                int card = -1, pid = -1;

> @@ -177,13 +177,13 @@ static void print_port(snd_seq_t *seq, snd_seq_client_info_t *cinfo,
>  #ifdef HAVE_SEQ_CLIENT_INFO_GET_CARD
>  		card = snd_seq_client_info_get_card(cinfo);
>  #endif
> -		if (card != -1)
> +		if (card >= 0)
>  			printf(",card=%d", card);

aconnect from alsa-utils 1.1.1 will break with alsa-lib containing your patch.

The new API is propably not yet widely used, so I think that a ABI change can still be possible.
But in that case, alsa-lib/alsa-utils 1.1.1 need quickly be replaced by new releases, so that people
don't start using the old API.

Regards,
Martin
