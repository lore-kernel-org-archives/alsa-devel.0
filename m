From: "John S. Denker" <jsd@monmouth.com>
Subject: Re: sb16 gets wedged when doing overlapped i/o (full
 duplex)
Date: Thu, 05 Dec 2002 13:33:35 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEF9BFF.2050200@monmouth.com>
References: <Pine.LNX.4.05.10212051455590.3576-100000@pulsar.kss-loka.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.05.10212051455590.3576-100000@pulsar.kss-loka.si>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Uros Bizjak <uros@kss-loka.si>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Uros Bizjak wrote:

>   From the error message you posted about this bug, it looks that driver
> is trying to call prepare() operator on a substream that is still
> in SNDRV_PCM_STATE_RUNNING state. Perhaps Jaroslav could tell us if this
> can happen if hardware pointers are not updated anymore (because sb16 DMA
> engine gets stucked somehow). Do you get an XRUN message in
> /var/log/messages?

Excellent question!

1) No xrun messages in /var/log/messages, but....

2) My program intentionally causes an overrun on input once
every 0.5 seconds.  It catches this condition, and recovers
by calling snd_pcm_prepare().  It does not print a message
about this (unless super-specially requested).

I realize that other programs may cause far fewer overruns,
which may (or may not :-) explain why others don't suffer
quite so badly from this bug.  Even so, it remains a bug.
An overrun shouldn't take down the whole system.

3) As previously indicated, if I load the system, I can cause
a few audible underruns on output.  But doing this has no
discernible effect on the incidence of the bug in question.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
