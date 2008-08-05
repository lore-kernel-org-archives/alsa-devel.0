From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 09/11] wss_lib: use wss pcm code instead of
	ad1848 one
Date: Tue, 05 Aug 2008 05:41:56 +0200
Message-ID: <4897CC04.9020100@keyaccess.nl>
References: <20080731210932.7fb9db4b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E30A24565
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 05:42:00 +0200 (CEST)
In-Reply-To: <20080731210932.7fb9db4b.krzysztof.h1@poczta.fm>
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

On 31-07-08 21:09, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Use the wss pcm code and kill the ad1848 pcm code.
> 
> The AD1848 chip is much slower than CS4231 chips
> so the waiting loop was increased 100x (10x is not 
> enough).
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> 
> Changes since previous version:
> 
> 1. Condition in snd_wss_capture_open() fixed.
> 2. Few very small formatting improvements.

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.
