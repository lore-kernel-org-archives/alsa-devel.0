From: Andreas Bulling <uek32z@phoenix.hadiko.de>
Subject: problems with Terratec Aureon Sky 5.1
Date: Sun, 14 Mar 2004 17:41:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040314164136.GA24447@phoenix.hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi folks,

for months now I have big problems getting surround sound to work with my
Aureon Sky 5.1 and hope someone on this list can and is willing to help me, now.
I would like to put all of the collected information and tips on the alsa wiki afterwards.

That's what I did so far:
I've read all the scanty information concerning the ice1724 chip, the available
alsa documentation, postings of different forums and mailinglists and also
got in contact with Simon Oosthoeck (-> alsaWiki).
I already posted to alsa-user but the two answers didn't help me... :(

The "handmade" solution I've found so far is the following:

~/.asoundrc:
--------------------------------
pcm.!default {
    type plug
    slave ice1724_S32_LE;
}

pcm.surround {
        type route;
        slave.pcm {
                type hw;
                card 0;
                device 0;
        }
        slave.channels 6
        ttable.0.0 1;
        ttable.1.1 1;
        ttable.0.2 1;
        ttable.1.3 1;
        ttable.0.4 1;
        ttable.1.5 1;
}

pcm_slave.ice1724_S32_LE {
        pcm surround;
        format S32_LE;
}
--------------------------------

Sound out of all 6 speakers but as everybody can imagine I'm not
satisfied with this solution because also "real" surround sound
(e.g. from dvd) is mixed up.

What should work out of the box is to use the "surround51" device
(that's what I thought at the beginning without deeper knowledge of alsa
and what I found in xine's config for example) but all I get is the
following error message:

-----
andreas@phoenix andreas $ aplay -Dsurround51 /usr/kde/3.2/share/sounds/pop.wav
Playing WAVE '/usr/kde/3.2/share/sounds/pop.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
aplay: set_params:827: Sample format non available
-----

The common format problem, but why hasn't it already been fixed in
/usr/share/alsa/cards/ICE1724.conf? I looked into the file, changed a little
bit but had no success.
Using -Dplug:surround51 instead works, but still without sound out of the
rear speakers...

Well, perhaps someone already knows a solution to this problems... nevertheless
here are all the other questions I want to find answers and write documentation for.

1) What are the following channels (?) in a{lsa}mixer for: IEC958, IEC958 1, IEC958 Output, Multi Track Peak
   I can select what I like but can't notice any effect. "Which to use for what purpose"?

2) What are the following options for: PCM Out0, H/W In [0|1], IEC958 I (-nput ?)
   What are the differences? "Which to use for what purpose"?

3) What is the "right" way to get surround sound with the ice1724 chip?
   Do exist different or partial solutions to this problem?
   Should (n't) it work right "out of the box" with the standard configs?
   
4) Who is the main and "responsible" ice1724 developer? I would like to contact him
   to fix this, perhaps together, and I think he should know best about questions 1-3),
   at least I hope so ;)

================================

My setup is the following:

- Terratec Aureon Sky 5.1

0000:00:0d.0 Multimedia audio controller: IC Ensemble Inc ICE1724 [Envy24HT] (rev 01)
  Subsystem: TERRATEC Electronic GmbH: Unknown device 1147
  Flags: bus master, medium devsel, latency 32, IRQ 17
  I/O ports at e400
  I/O ports at e000 [size=128]
  Capabilities: <available only to root>

- Philipps A3.600 Surround System
- Gentoo Linux, Kernel 2.6.4-mm1
- Alsa Version 1.0.2c (used the kernel modules, not alsa-driver)
- Alsa [Lib|Utils] Version [1.0.3b|1.0.3]
- Alsa Oss Version 1.0.3a

================================

In suspense expectation,
Andreas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
