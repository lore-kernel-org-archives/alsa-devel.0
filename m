From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: Re: Mixer sanity
Date: Thu, 10 Jun 2004 22:10:15 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <S28713AbUFJTKP/20040610191016Z+5619@nic.funet.fi>
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

>From: Owen Fraser-Green <owen@discobabe.net>
>
>After some tinkering around with ALSA's mixer with a couple of different
>cards it's become apparent to me that there's not too much
>standardization when it comes to track naming. 

I suggest this project is started by drawing exact signal routing
graphs for each card. The graphs would be good for applications
developers who don't have each of the cards. For example, Yamaha
mixer console brochures includes complete routing graphs, you
may guess why.

Personally I would like to see EMU10K1 routing graph because
it would help in understanding the code in emu10k1.c. I would
like to understand it better.

>Just to alter the level for regular stereo playback, therefore,
>I have to first lower the L level for HW1 and then alter the R
>level for HW2 (with HW1's R and HW2's L muted). This is
>weird!

Alsalib could have two access points to the hardware: the current
system and a new one which emulates better controls for the cards
such as above. The emulation code simply reads the better controls
and calculates the values for the poor control. Emulator changes the
routing graph, so, it must be documented as well.

>Now, I know an envy24mixer exists to make life easier for me but surely
[ ... ]
>other solution, therefore, is for me to provide a map for every sound
>card which ALSA supports.

Well, what I proposed is a map in the form of Alsalib library functions.
It is better be in Alsalib.

Are the mixer controls equivalently realtime as they are in
mixer consoles? Do people use the mixers for mixing music
and have realtime control over the mixer controls? E.g., does
Ardour automate the hardware mixer controls or does Ardour provide
software faders?

Perhaps we could have a simple mapping language which Alsalib would
interpret for calculating the mapping. The mapping scripts would be
read from files. Users could easily write their own mappings, and
map files could be submitted to Alsalib. The scripts would be
read and "compiled" to memory as interpreted code; something like
Renderman shader language scripts are "compiled" prior they get used.

But it would be easier to start coding the mappings directly to
Alsalib.

Regards,
Juhana


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
