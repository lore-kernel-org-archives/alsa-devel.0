From: Remi Bernhard <rgbmlist2@free.fr>
Subject: Re: [Alsa-devel] Xruns with Audiophile 2496 M-audio
Date: Sat, 29 May 2004 14:06:31 +0200
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20040529140631.09962c03@pentium233.krystal.net>
References: <20040529114908.2118135c@pentium233.krystal.net>
	<Pine.LNX.4.58.0405291234350.566@autumn>
	<20040529131601.641aa202@pentium233.krystal.net>
	<1085830277.21677.17.camel@eviltwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1085830277.21677.17.camel@eviltwin>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,


> As far as minimizing buffer size is concerned - if
> you are doing live audio or you want to monitor recording with inboard
> effects turned on you need to have a small buffer size.  With the
> envy24 chipset cards you can use hardware monitoring so you can set
> the buffer size to 2048 and have zero latency monitoring.  Don't
> confuse monitoring latency with system latency.


To be more sharp, i need to reduce latency because i use softsynth
(zynaddsubfx, fluidsynth, etc.) that needs a low latency when playing
from midi keyboard, and if not, there is a "lag" time, that man can
hear, between the time when you hit the key, and the time it is played.

I don't know about wich latency i spoke, i think it is system latency.
So I think that buffer size is **the** parameter to change.

Is that true ?

Regards,
	Remi.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
