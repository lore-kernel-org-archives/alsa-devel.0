From: Gerard Janssen <G.Janssen@ITS.TUDelft.NL>
Subject: Re: Re: [Alsa-user] How to select different
  S/PDIFoutput ports on a SBLive!
Date: Fri, 20 Sep 2002 10:56:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4229AE35D6A@Octopus.et.tudelft.nl>
References: <0H1P000C9NO5XV@mailhost1.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209011718250.521-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

>> The SBLive! card can support four SPDIF output channels, indicated as
>> SPDIF#0 - 3, which are located on the 12 pins or the 40 pins external
>> connector (depending on the type of card).
>> When I play a file to "spdif" or "iec958:AES0=0x42,AES1 = 0x82,AES2 =
>> 0x02,AES3 = 0x02", the signal is send to the SPDIF#1 output. When I use
>> "front" or "center_lfe", I can get music out of SPDIF#0-3 depending on the
>> ALSA-mixer settings, however, the way the settings have to be chosen is not
>> straight forward (trial and error). So apparently all SPDIF outputs are
>> "available".
>> 
>> I would like to select/address all four SPDIF outputs of the SBLive! card.
>> Now I have the following questions:
>> 
>> 1. How can the SPDIF output port be changed when using the "spdif" or
>> "iec958" in the alsa player. I tried to change the channel value of AES2,
>> but this had no effect at all.
>
>It's not possible. Actually, DSP code supports optical and coaxial digital 
>outs for LiveDrive, but I haven't information about physical connections 
>for them by hand.
>
>> 2. I tried to find the location where the SPDIF output port is set in the
>> alsa code for the emu10k1. I also searched the emufx-code, since the spdif
>> outputs come directly from the fx8010 processor, but I did not find it.
>> Where is the SPDIF output port set? How can it be changed?
>
>Look for EXTIN_TOSLINK_L and EXTIN_COAX_SPDIF_L in emufx.c
>
>> B.t.w. I did find only three SPDIF channel status registers (SPCS0-2). Why
>> are there only three SPCS's in stead of four?
>
>I think that the emu10k1 chip shomehow merges signals from two S/PDIF 
>inputs into one.

I tried to find the spdif output port addresses by changing the register
addresses of EXTOUT_TOSLINK_L/R in emu10k1.h to all 16 possible output
address pairs between (00 - 1f). To do this, I removed the extout_mask
check in emufx.c in the piece of code given below. I found the addresses of
the four spdif output ports of the SBLive! card (I did/could not check this
for the Audigity) and they are as follows: spdifo#0 = (0x02,0x03), which is
the standard output, spdifo#1 = (0x04,0x05), spdifo#2 = (0x06,0x07) and
spdifo#3 = (0x08,0x09).

So in principle it seems to be possible to create 8 digital output channels
on the SBLive!, however at the cost of some of its standard
functionalities, namely the outputs of the center_lfe, headphone and rear
channels to the LiveDrive (I think?). 

Now, I would like to implement three additional spdif outputs in the same
way as the standard output, so without volume or tone control. I think,
this is an interesting extension of the functionality of the SBLive, since
by creating 8 independent digital outputs we get a functionality on a cheap
soundcard which is now only available at expensive (professional) soundcards.
The problem is that I am not a programmer, however, I would like to give it
a try where any help from the ALSA community is very much appreciated. I
have the following questions:

1. Is the code related to the standard spdif output in emufx.c, limited to
the following code lines or is there other code involved?
	if (emu->fx8010.extout_mask &
((1<<EXTOUT_TOSLINK_L)|(1<<EXTOUT_TOSLINK_R))) {
		/* IEC958 Optical Raw Playback Switch */

		for (z = 0; z < 2; z++) {
			SWITCH(icode, &ptr, tmp + 0, 8 + z, gpr + z);
			SWITCH_NEG(icode, &ptr, tmp + 1, gpr + z);
			SWITCH(icode, &ptr, tmp + 1, playback + SND_EMU10K1_PLAYBACK_CHANNELS +
z, tmp + 1);
			OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_TOSLINK_L + z), GPR(tmp + 0),
GPR(tmp + 1), C_00000000);
		}
		snd_emu10k1_init_stereo_onoff_control(controls + i++, "IEC958 Optical Raw
Playback Switch", gpr, 0);
		gpr += 2;
	}

2. To what address does "tmp" refer in the OP instruction above?

3. Do I need to implement additional "Process FX Buses" (now there are 9
buses, indicated as GPR(0) - GPR(9), where GPR(8) and GPR(9) have the
comment S/PDIF left/right)?

4. I thought that the spdif channel status registers SPCS0-3 (I added an
SPCS3 on address 0x57 in emu10k1.h) were initialized in emu10k1_main.c.
However, after playing a wave file using aplay via spdif at 44.1 kHz, the
sample frequency in SPCS is changed from 48 kHz to 44.1 kHz. Also other
changes appear in some SPCS values, which I cannot trace back. Where in the
code is the SPCS value changed?

Regards,

Gerard Janssen


********************************************************************** 
Dr.ir. Gerard J.M. Janssen
Delft University of Technology 
Faculty of Information Technology and Systems (ITS) 
Telecommunications and Traffic Control Systems Group
P.O. Box 5031, 2600 GA Delft, The Netherlands 
Phone +31-15-2786736, Fax +31-15-2781774 
E-mail G.Janssen@ITS.TUDelft.NL 
**********************************************************************




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
