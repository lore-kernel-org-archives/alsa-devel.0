From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Why do I get broken pipe on write to a pcm in  
 statePREPARED?
Date: Mon, 07 Oct 2002 14:07:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA178F1.769C6FFA@libero.it>
References: <Pine.HPX.4.33n.0209171615490.1084-100000@studcom.urz.uni-halle.de>
		<200209181957.g8IJvS008300@d1o87.telia.com>
		<200210040814.g948E9015465@d1o87.telia.com>
		<s5hy99e4ayc.wl@alsa2.suse.de>
		<3D9DD810.7C3960C4@libero.it> <s5h65we4ksf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Anders Torger <torger@ludd.luth.se>, Jaroslav Kysela <perex@suse.cz>, Tim Goetze <tim@quitte.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> it CAN happen if you have multi-threads.
> the problem is that we have no option to block the poll.

If you have multi-thread you have other alternative to do that.
OTOH application can't detect *why* poll is blocking with the change you
advocate.

> > That apart I'm sure that to make a change in actual behaviour between
> > rcX and 1.0 is a professional suicide. However it's _your_ professional
> > suicide so... ;-)))
> 
> yes, i know it well ;)
> 
> i don't like to change this inevitably, too.
> and as mentioned above, i don't mind to add an option as sw_params,
> etc. for the new behavior.
> 
> but the current behavior is incorrect from the interpretation of
> POSIX.  so this must be a bug.
> if we have to change it, then i would choose the new one, because it's
> more intuitive without exception.

As pointed by Clemens the current is the proper POSIX behaviour.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
