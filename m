From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] wss-lib: move AD1845 frequency setting
 into wss-lib
Date: Sun, 11 Jan 2009 04:48:12 +0100
Message-ID: <20090111044812.64596072.krzysztof.h1@poczta.fm>
References: <20090109231052.606a5497.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C7AB1037EB
	for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2009 04:45:39 +0100 (CET)
In-Reply-To: <20090109231052.606a5497.krzysztof.h1@poczta.fm>
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
Cc: Takashi Iwai <tiwai@suse.de>, "Theodore J. Allen" <tjallen@hws.edu>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Jan 2009 23:10:52 +0100
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This is required to allow the sscape driver
> to autodetect installed codec.
> 
> Also, do not create a timer if detected codec
> has no hardware timer (e.g. AD1848).
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Cc: Rene Herman
> ---
> 
> Ted, please test if the patch helps to make your Soundscape Elite
> card working. If not the patch is required anyway as your last feedback
> showed that frequency setting is incorrect in the sscape driver if
> the codec is not the AD1845.
> 

Ted has confirmed that it makes the Soundscape Elite working (only
audio part, no MIDI yet).

Regards,
Krzysztof

-----------------------------------------------------------------------
Promocja w Speak Up. Kwartal angielskiego za darmo. 
3 miesiace nauki gratis. Sprawdz teraz! >> http://link.interia.pl/f2019
