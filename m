From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: jack crackles using ice1712 or es1968 recently intoduced? was: usx2y jack driver
Date: Sun, 26 Sep 2004 17:24:53 +0200
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <200409261724.53800.annabellesgarden@yahoo.de>
References: <200409222228.38243.annabellesgarden@yahoo.de> <200409251911.44533.annabellesgarden@yahoo.de> <20040926091255.GA3526@linux>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040926091255.GA3526@linux>
Content-Disposition: inline
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Fons Adriaensen <fons.adriaensen@skynet.be>
Cc: alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

<alsa and jack readers may skip the first lines>
Am Sonntag 26 September 2004 11:12 schrieben Sie:
> > P.S.: Will you make aeolus stops data persistent somewhen?
>
> I'm not sure what exactly you mean by 'stops data' --- the
> definition of the stops themselves or the stop combinations
> you use to play.
>
I mean the data calculated at aeolus startup or on retune.

> Both can be saved iff the stops directory and everything
> inside it is writeable for the user. If you are using a
> packaged distribution (e.g. CCRMA), the stops dir will be
> in a system-wide place and then you can't save anything.
> Just put it in your home dir and use the -S option or
> put
>
> Aeolus.stops: /home/<your_login>/stops-0.0.9
does it have to be that name stops-0.0.9?
>
> in your ~/.aeolusrc.
>
> The stop combination memories and midi routing are then
> saved when you click 'Save' in the main window.
>
> (All this assuming you are using aeolus-0.2.1)

My setup looks alike, but aeolus still takes its minute to boot,
which it shurely deserves ;-)

Just rechecked aeolus - jack - snd_es1968 at 128frames/2periods:
Crackles en masse :-/
I thought I have used it not too long ok without Crackles.
Everything OK with playback only:
/usr/bin/jackd -R -dalsa -Phw:0 -p128 -n2

The same with zynaddsubfx: Crackles with input & output.
output only ok.

using this (standard snd-usb-usx2y, 2ins 2outs, 4periods)
/usr/bin/jackd -R --unmlock -dalsa -dhw:1 -i2 -n4 -p64 -r48000
is still ok.
Are there some subtle changes in alsa/jack relating ice1712 and es1968 
recently introduced?
like in alsa pcm device syncing code, which jackd uses to simultaneously 
start/stop capture and playback?

Best,
Karsten



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
