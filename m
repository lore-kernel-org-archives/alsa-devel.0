From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Wrong creation of emulated volume control.
Date: Mon, 14 Feb 2005 13:57:00 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502141356140.10867-100000@studcom.urz.uni-halle.de>
References: <42107591.7090806@mail.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <42107591.7090806@mail.ru>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Petr Gladkikh <batyi@mail.ru>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Petr Gladkikh wrote:
> I have sound card with PCM having only mute switch (no volume
> control). I have installed alsa-lib-1.8.0 (release). My control list
> now have following PCM control (following is part of amixer output):
>
>  >>>
> Simple mixer control 'PCM',0
>    Capabilities: pvolume pswitch pswitch-joined
>    Playback channels: Front Left - Front Right - Front Center - Rear
> Left - Rear Right - Woofer - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
> - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
>    Limits: Playback 0 - 0
>    Front Left: Playback 0 [0%] [on]
>    Front Right: Playback 0 [0%] [on]
>    Front Center: Playback 0 [0%] [on]
>    Rear Left: Playback 0 [0%] [on]
>    Rear Right: Playback 0 [0%] [on]
>    Woofer: Playback 0 [0%] [on]
>    ?: Playback 0 [0%] [on]
>    ?: Playback 0 [0%] [on]
>    ?: Playback 0 [0%] [on]
>    ...

How do these controls look in /etc/asound.state after running "alsactl
store"?


Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
