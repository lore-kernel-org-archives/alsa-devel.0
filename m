From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: [BUG] (via82xx) no sound on VIA 8235 sound card
 with CMI9739 codec
Date: Thu, 02 Dec 2004 19:14:37 +0100
Message-ID: <m2llcgsh2q.fsf@vador.mandrakesoft.com>
References: <m2d5y0tnhe.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2d5y0tnhe.fsf@vador.mandrakesoft.com> (Thierry Vignaud's
 message of "Fri, 26 Nov 2004 20:32:45 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thierry Vignaud <tvignaud@mandrakesoft.com> writes:

> The problem:
> ============
> 
> the card does not produce any sound (interestingly, it does neither
> with the OSS driver) whatever muted/unmuted mixer combinaison we use.
> 
> both alsa-1.0.2 and alsa-1.0.7 drivers display :
> via82xx: Assuming DXS channels with 48k fixed sample rate.
>          Please try dxs_support=1 or dxs_support=4 option
>          and report if it works on your machine.

in fact, sound was almost unheardable when DXS and main chanels were
at max.

plugging external HPs showed that this was an hardware bug (it was a
prototype of amd64 laptop)

thus bug is invalid



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
