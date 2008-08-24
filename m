From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] wss_lib: do not mess mixer settings during
 probe
Date: Sun, 24 Aug 2008 21:48:32 +0200
Message-ID: <20080824214832.daa13d68.krzysztof.h1@poczta.fm>
References: <20080824180804.b88effc0.krzysztof.h1@poczta.fm>
	<48B1AA48.7020403@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 11EAF24133
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Aug 2008 21:42:19 +0200 (CEST)
In-Reply-To: <48B1AA48.7020403@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 24 Aug 2008 20:36:56 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 24-08-08 18:08, Krzysztof Helt wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Use the wss_dout function which does not mess
> > shadowed register values during chip probing.
> > Otherwise, user ends up with stupid mixer settings
> > after driver loading.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Acked-by: Rene Herman <rene.herman@gmail.com>
> 
> Must say that I only now notice that we're doing that init loop there. 

I noticed it on at least three different cards.

> I 
> believe it could be better to introduce an inline __snd_wss_out() with 
> just the two outb()s and use that from snd_wss_out() and here directly.
> 

snd_wss_dout() is almost the same. The waiting loop should never trigger
there and it is safer in case some write needs few micro-secs to finish.

> And with respect to the mb() ... if anywhere, should't that be between 
> the two outb's really?
> 

>From the Documentation/memory-barriers.txt
"
(*) inX(), outX():
...
    They are guaranteed to be fully ordered with respect to each other.

    They are not guaranteed to be fully ordered with respect to other types of
     memory and I/O operation.
...
"

No barriers are needed in this case. 

Regards,
Krzysztof

----------------------------------------------------------------------
Alergia na seks?
>> http://link.interia.pl/f1eec
