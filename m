From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: reading constant length of data from sound card
 using readi api of alsa
Date: Fri, 6 May 2005 09:30:08 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505060856140.14330-100000@studcom.urz.uni-halle.de>
References: <20050505133456.73351.qmail@web8309.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050505133456.73351.qmail@web8309.mail.in.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Koushik jaikishan <jaykishankrk@yahoo.co.in>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Koushik jaikishan wrote:
> i am not able to read constant amount of data from the
> sound card i dont know why, it always gives me - 11 as
> the returned value for reading 960 bytes of data.

-11 is -EAGAIN.  You would be able to read some data if you waited
some time.

Either disable the non-blocking mode with snd_pcm_nonblock, or wait
with snd_pcm_wait, or, if you have other devices to wait for, use the
snd_pcm_poll_* functions with poll().


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
