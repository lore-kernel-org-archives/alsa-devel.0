From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
Subject: Re: Fixes ac3 passthru non-audio bit setting for AC97 codecs
Date: Wed, 15 Oct 2003 10:30:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031015083016.GA2808@magma.epfl.ch>
References: <20031015014604.GA22166@eternity.dominion.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20031015014604.GA22166@eternity.dominion.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Morger <philipp.morger@dominion.ch>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello list ;-)

I just follow this message as requested by Philipp Morger, only one
point: I have also tried the change from Takashi Iwai, and it also
didn't worked for me (but I didn't want to loose too much time, I have
put my SBlive back in the computer...).

> I mailed the following some time ago to the alsa-devel list, but as I'm not a subscribed it had to undergo a moderator's OK... somehow it didn't manage to get into the list and I never received an error-report. Anyway, here is the mail, it contains the info requestet by two list-members
> Please be so kind and relay the mail to the list.
> 
> ----

I own a cs46xx with a Yamaha DSP-A1 receiver... and AC is not working for me, neither from ogle, xine, mplayer or ac3dec... the only thing I might get is a really nasty noise.

James Courtier-Dutton asked for the following information:

lspci -v
03:08.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: Hercules: Unknown device a012
        Flags: bus master, slow devsel, latency 32, IRQ 20
        Memory at d3800000 (32-bit, non-prefetchable) [size=4K]
        Memory at d3000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2
 
03:09.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 04) (prog-if 10 [OHCI])
        Subsystem: Hercules: Unknown device a012
        Flags: bus master, medium devsel, latency 32, IRQ 21
        Memory at d2800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

lspci -vn
03:08.0 Class 0401: 1013:6003 (rev 01)
        Subsystem: 1681:a012
        Flags: bus master, slow devsel, latency 32, IRQ 20
        Memory at d3800000 (32-bit, non-prefetchable) [size=4K]
        Memory at d3000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2
 
03:09.0 Class 0c00: 11c1:5811 (rev 04) (prog-if 10)
        Subsystem: 1681:a012
        Flags: bus master, medium devsel, latency 32, IRQ 21
        Memory at d2800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

please note, the card has 2 firewire ports... if you need the full output, then you just have to say so - I didn't want to clutter this mail with the rather long output.

alsamixer  <- What is the name of the Card: and Chip: ?
Card: Sound Fusion CS46xx          
Chip: Cirrus Logic CS4294 rev 5,Cirrus Logic CS4294 rev 5       

Takashi Iwai submitted a patch for the cs46xx, I tried it, but it didn't change anything

I'm currently not (and haven't been before) subscribed to this list, so please write to me directly if you need any further information or someone willing to test code... as I don't know how rigif the mail protector of this list deamon is, here is my mail address encoded: philipp dot morger at dominion dot ch - for all who know GPG, GPG key id is CBAC065B (avail on the pgp keyservers).

best regards
Philipp

-- 
	Grégoire
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
