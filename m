From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Why do I get broken pipe on write to a pcm in
 statePREPARED?
Date: Fri, 04 Oct 2002 20:04:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9DD810.7C3960C4@libero.it>
References: <Pine.HPX.4.33n.0209171615490.1084-100000@studcom.urz.uni-halle.de>
		<200209181957.g8IJvS008300@d1o87.telia.com>
		<200210040814.g948E9015465@d1o87.telia.com> <s5hy99e4ayc.wl@alsa2.suse.de>
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
> At Fri, 4 Oct 2002 10:14:09 +0200,
> Anders Torger wrote:
> >
> > Uhhh... I guess ignoring me works just as well :-)
> 
> not ignored but pending :)
> 
> Abramo, do you still have objection to change the default behavior?
> 
> i don't mind that even the new behavior is optional e.g. via
> snd_pcm_sw_params.  but i believe the current behavior is not expected
> as a normal one, so it's enough reason to change it.
> 
> also, if someone (Tim?) already has a patch, please send it here.
> it seems my last patch doesn't work properly...

For what it worths my objections are still there.

I'm strongly convinced that to have poll waiting for something that
cannot happens is a big mistake (also as an optional behaviour).

That apart I'm sure that to make a change in actual behaviour between
rcX and 1.0 is a professional suicide. However it's _your_ professional
suicide so... ;-)))

To resume, if you ask me, the answer is no.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
