From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] wss_lib: do not mess mixer settings during
	probe
Date: Sun, 24 Aug 2008 20:36:56 +0200
Message-ID: <48B1AA48.7020403@keyaccess.nl>
References: <20080824180804.b88effc0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id E5CF424375
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Aug 2008 20:35:29 +0200 (CEST)
In-Reply-To: <20080824180804.b88effc0.krzysztof.h1@poczta.fm>
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

On 24-08-08 18:08, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Use the wss_dout function which does not mess
> shadowed register values during chip probing.
> Otherwise, user ends up with stupid mixer settings
> after driver loading.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Acked-by: Rene Herman <rene.herman@gmail.com>

Must say that I only now notice that we're doing that init loop there. I 
believe it could be better to introduce an inline __snd_wss_out() with 
just the two outb()s and use that from snd_wss_out() and here directly.

And with respect to the mb() ... if anywhere, should't that be between 
the two outb's really?

Rene.
