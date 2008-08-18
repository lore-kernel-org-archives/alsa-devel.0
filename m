From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] wss_lib: snd_wss_calibrate_mute improvement
Date: Mon, 18 Aug 2008 10:50:15 +0200
Message-ID: <48A937C7.2040600@keyaccess.nl>
References: <20080817223827.d3250ef5.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id D59AC243FD
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 10:49:19 +0200 (CEST)
In-Reply-To: <20080817223827.d3250ef5.krzysztof.h1@poczta.fm>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17-08-08 22:38, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Mute sound by setting mute bit without
> setting volume to 0. It makes both source code
> and binary shorter.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Grmmbbled-over-by: Rene Herman <rene.herman@gmail.com>

This should be safe and the current function indeed generates crap code 
but in the sense of always expecting the worst broken hardware variants 
to be out there I must say I'd rather have seen that GCC were beter. But 
yes, sure.


Rene.
