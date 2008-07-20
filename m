From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] wss: fix capture formats limitations
Date: Sun, 20 Jul 2008 20:30:44 +0200
Message-ID: <48838454.7020701@keyaccess.nl>
References: <20080720201452.d4155736.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 574962446E
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 20:28:33 +0200 (CEST)
In-Reply-To: <20080720201452.d4155736.krzysztof.h1@poczta.fm>
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
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 20-07-08 20:14, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Fix copy-paste error with Interwave instead of ad1848
> chip condition.
> Limit opti93x cards capture formats to only linear ones.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Added: http://members.home.nl/rene.herman/wss/

> Thank you Rene for collecting, testing and reviewing my
> patches. I found one mistake in the series and this patch
> fixes it.
> 
> I have also limited capture formats for opti93x chips because
> the opti93x manual states that it supports mu-law, a-law and 
> ADPCM decompression. The word "decompression" probably 
> suggest that compression (recording) is not possible as its
> manufacturer could just state the card supported mu-law, a-law 
> and ADPCM.

That sounds likely... will look.

Rene.
