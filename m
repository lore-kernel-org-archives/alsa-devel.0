From: Ken Bass <kbass@kenbass.com>
Subject: Sound programming confusion
Date: 25 Feb 2004 14:16:54 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077736614.19756.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I'm trying to accomplish a programming task and am pretty confused about
the capabilities of the sound drivers and how I would accomplish this in
an application. I've been through the HOWTO and tutorial as well as
attempted to read the PCM interface parts of the also-lib docs. But I've
got more questions than answers. The SB-Live-mixer.txt was not helpful.

I've got an SB Live! 5.1 (EMU10K1) device that is my target using analog
outputs.

High Level:

1) I've got 3 separate PCM 'mono' streams of data that I want to send to
3 different outputs.

  a) How many PCM inputs do these cards/drivers support? Under OSS,
there were 2, /dev/dsp and /dev/dsp1. Ideally I would like each input
stream to have a seperate sample rate. In practice, 2 of them will be
25kHz, and one will be 22050Hz.
  
2) I want to reconfigure the 'routing' on the fly. How do I do this?
I've seen documentation (which wasn't clear) about .asoundrc files and
such, but I need to change this programmaticaly.
  Input 1- 25 kHz PCM stream 
  Input 2- 25 kHz PCM stream
  Input 3- 22050Hz PCM stream
  Output 1 - Front L
  Output 2 - Front R
  Output 3 - Rear L
  
  I want to route (on the fly) any of those inputs to any of those
outputs (being careful to erase all routes and recreate them each time I
reconfigure).

3) I'm totally confused about the capabilities of this card. Is this
described at a high level somewhere or can someone explain this?

4) I'm not clear how to control these routes, what 'hw' device names to
use, etc. I've seen references to ld10k1, 

5) In the SB-Live-mixer.txt, section 3, PCM stream related controls --
I'm lost. What is a PCM Send Routing, what are A, B, C, D destinations,
why is there a distinction between mono and left/right, and how are
these controlled?

6) I see references to 'surround40' or 'surround51'. I'm not sure if
that is what I want because they cannot be changed on the fly.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
