From: "Nick French" <nick@greensignal.com>
Subject: problem with via8233
Date: Wed, 3 Jul 2002 01:21:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <017301c22227$a2cd07d0$360110ac@dillon>
References: <m31yav1b40.fsf@ccs.covici.com> <s5hk7om563k.wl@alsa2.suse.de><15642.10186.820516.331246@ccs.covici.com> <s5h66046gnp.wl@alsa2.suse.de><15643.7633.177373.448813@ccs.covici.com> <s5h3cv86brk.wl@alsa2.suse.de><15643.16455.420976.668125@ccs.covici.com> <s5hhejoobzr.wl@alsa2.suse.de> <m37kkiyleb.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, John Covici <covici@ccs.covici.com>
List-Id: alsa-devel@alsa-project.org

Hi all

I seem to have a problem with the via8233 driver. I seem to get
breaks/crackle/pop every now and then only very small but annoying. I did
not
seem to get this with .5. Have tried to look at the code but nothing has
come to light I notice that the .9 version uses a different channel now due
to the 8233A support (I have one of these chips as well in another
Motherboard). Is there anything I can try to see if I can compile with the
old channel support to see if it is this. Can I change
VIA_REG_MULTIPLAY_STATUS to VIA_REG_PLAYBACK_STATUS and recompile. Any
ideas? It seems to be worse with apps that play multiple wav files over and
over again.

Cheers

Nick





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
