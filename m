From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 07/11] wss_lib: use CS4231P instead of
 AD1848P (kill the AD1848P)
Date: Tue, 05 Aug 2008 05:41:41 +0200
Message-ID: <4897CBF5.9050108@keyaccess.nl>
References: <20080731210730.a14d5262.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id B55A124569
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 05:41:44 +0200 (CEST)
In-Reply-To: <20080731210730.a14d5262.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 31-07-08 21:07, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Use CS4231P instead of AD1848P (kill the AD1848P).
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> Changes since previous version:
> 
> 1. No reformatting of the snd_ad1848_debug()
>    as the file is going to be killed.
> 1. Nicer formatting of WSS_SINGLE and WSS_DOUBLE
>    macros.

I believe 1 no. 2 is a cut & paste error? There are no such changes in 
this patch.

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.
