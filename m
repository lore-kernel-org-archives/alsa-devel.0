From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Mono to stereo ?
Date: Fri, 28 Mar 2003 10:21:03 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030328102103.pochini@shiny.it>
References: <E18yjnp-0000ZA-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18yjnp-0000ZA-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net, Manuel Jander <mjander@embedded.cl>
List-Id: alsa-devel@alsa-project.org


On 28-Mar-2003 Paul Davis wrote:
>>>one channel only.
>>>[...]
>>
>>...but, if you are doing mono playback, your sound driver has to setup
>>your soundcard to playback on both channels the same mono channel. The
>>Vortex
>>driver (still not in the main branch) for example splits the mono signal
>>on its internal
>>mixer into 2 identical signals which are feed one into each CODEC channels.
>
> that's a driver author's design decision. if the "hw" PCM device is
> opened with a single channel, it would be equally valid to play on one
> channel only. if the h/w can't handle that, it should not
> advertise itself to be capable of mono operation. IMHO.

I choosed to send the sound to one channel only, so the apps can
use all 8 mono channels.
Since most cards can do mono to stereo in hardware, I would be nice to
add a capability flag for that. Using that features you halve memory
usage for buffers and irq frequency.


Bye.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
