From: Dominik 'Aeneas' Schnitzer <dominik@schnitzer.at>
Subject: Re: [PATCH] EMU10K1.conf
Date: Wed, 07 Jan 2004 18:50:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1073497842.27478.37.camel@blackhole>
References: <1072485112.2477.35.camel@blackhole>
	<s5h7k062vag.wl@alsa2.suse.de> <1073388215.7832.32.camel@blackhole>
	<s5h1xqb1ydf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xqb1ydf.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mit, 2004-01-07 at 18:07, Takashi Iwai wrote: 
> the switch of "SB Live Analog/Digital" can be removed if it works for
> you.  it was set to make sure the center "analog" jack works.
> (in the recent models, the digital out is shared with the center/lfe
> jack.)
> with my emu10k1 board, i don't get any valid signals over
> center/digital jack unless AC3 is played.  it might depend on the
> receiver.  perhaps creative has its own protocol?
> 
> but, anyway, "Wave Surround" and "Wave Center" don't make sense at
> all.  they are volumes of duplicated signals.  the volumes of
> surround/center/lfe channels are different mixer elements.

Hi,

I just rechecked everyting. You're right, it's just the "SB Live Analog/Digital"
switch/lock to "0" in EMU10K1.conf which needs to be removed, to make things work.
(I'm using a Creative Cambridge SoundWorks DTT3500 receiver, my sblive/emu10k1 card
has revision 07 (lspci))

As you pointed out, using the surround/center/lfe/wave volume controls everything can be
controlled. The WAVE* volume controls-stuff isn't neccessary.

So basically it boils down to...

--snip--
--- EMU10K1.conf.orig   2003-12-25 23:57:56.000000000 +0100
+++ EMU10K1.conf        2004-01-07 18:36:05.000000000 +0100
@@ -89,12 +89,6 @@
                                value true
                        }
                        {
-                               name "SB Live Analog/Digital Output
Jack"
-                               preserve true
-                               lock true
-                               value 0
-                       }
-                       {
                                name "EMU10K1 PCM Send Volume"
                                index { @func private_pcm_subdevice }
                                lock true
--snip--

...this change in EMU10K1.conf, to make surround51 work. Sorry for the
confusion, I hope this clarified things :-)

thanks && best wishes,
dominik.
-- 
Dominik 'Aeneas' Schnitzer <dominik@schnitzer.at>
http://www.schnitzer.at/dominik/ - Update 03/08/31: Birthday Party

PGP Fingerprint: E839 B9EA F518 899D AA35  BB67 0DBF 7AB2 5FE6 525A
PGP Public Key: http://www.schnitzer.at/dominik/public.key


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
