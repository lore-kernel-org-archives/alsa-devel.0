From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question regarding period/buffer and error handling
Date: Fri, 28 May 2004 17:52:23 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405281746010.24462-100000@studcom.urz.uni-halle.de>
References: <40B6970F.90507@atr.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40B6970F.90507@atr.jp>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Cournapeau David <cournape@atr.jp>
Cc: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Cournapeau David wrote:
>     My second problem is related to snd_card_next: If the card value
> returned by snd_card_next is different from -1, does that always mean
> than a alsa audio device is present on the system ?

It means that same kind of device with an ALSA driver is present.
This does not mean that you'll be able to play PCM data to it.  And
there may be software devices available.

> Is it the best method to probe a soundcard with alsa support?

snd_card_next() and snd_ctl_pcm_next_device() will give you a list of
hardware devices only.

Usually, you should use the device named "default" and let the user
allow to specify another device name.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
