From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_writei not returning (?!?)
Date: Mon, 05 Apr 2004 17:49:25 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404051748200.25421-100000@studcom.urz.uni-halle.de>
References: <000a01c41b19$deed1bf0$0100a8c0@burpxp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <000a01c41b19$deed1bf0$0100a8c0@burpxp>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tom Browne <tbrowne@tbrowne.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tom Browne wrote:
> Under certain conditions (yet to be established properly - it doesn't
> happen every single time) with this ICE1712 card (DSP24),
> snd_pcm_writei doesn't just block... it never comes back.

What is the state of the PCM device when this happens?
(see /proc/asound/cardX/pcm0p/*)


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
