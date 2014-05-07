From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - aconnect 1/1] fix aconnect -l option
Date: Wed, 07 May 2014 08:51:33 +0200
Message-ID: <5369D7F5.8060001@perex.cz>
References: <1399435607-9730-1-git-send-email-karlbongers@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 809472652B7
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 08:51:35 +0200 (CEST)
In-Reply-To: <1399435607-9730-1-git-send-email-karlbongers@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Karl Bongers <karlbongers@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 7.5.2014 06:06, Karl Bongers wrote:
> aconnect -l would just print usage.
> This fix makes it do what usage says it should do.
> 
> Signed-off-by: Karl Bongers <karlbongers@gmail.com>

Thanks. Applied.

> 
> diff --git a/seq/aconnect/aconnect.c b/seq/aconnect/aconnect.c
> index 8c66cfd..8d6cebb 100644
> --- a/seq/aconnect/aconnect.c
> +++ b/seq/aconnect/aconnect.c
> @@ -292,6 +292,7 @@ int main(int argc, char **argv)
>  			convert_real = 0;
>  			break;
>  		case 'l':
> +			command = LIST;
>  			list_subs = 1;
>  			break;
>  		case 'x':
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
