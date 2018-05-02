From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-lib][PATCH 2/2] conf/ucm: increase the input
 volume for LineIn
Date: Wed, 2 May 2018 08:44:08 +0200
Message-ID: <479c1517-5fce-4059-3c2e-b3740c9c22f5@perex.cz>
References: <1525241286-16498-1-git-send-email-hui.wang@canonical.com>
 <1525241286-16498-2-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB0C2673A6
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 08:44:12 +0200 (CEST)
In-Reply-To: <1525241286-16498-2-git-send-email-hui.wang@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Applied. Thanks.

Dne 2.5.2018 v 08:08 Hui Wang napsal(a):
> Otherwise, the boost value is 0, and the sound captured from that
> LineIn jack is too weak for users.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  src/conf/ucm/HDAudio-Lenovo-DualCodecs/HiFi.conf | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/conf/ucm/HDAudio-Lenovo-DualCodecs/HiFi.conf b/src/conf/ucm/HDAudio-Lenovo-DualCodecs/HiFi.conf
> index 5096789..ece780d 100644
> --- a/src/conf/ucm/HDAudio-Lenovo-DualCodecs/HiFi.conf
> +++ b/src/conf/ucm/HDAudio-Lenovo-DualCodecs/HiFi.conf
> @@ -99,6 +99,7 @@ SectionDevice."LineIn" {
>  	EnableSequence [
>  		cdev "hw:PCH"
>  		cset "name='Input Source' Line"
> +		cset "name='Line Boost Volume' 3"
>  	]
>  }
>  
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
