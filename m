From: Gerard Janssen <G.Janssen@ITS.TUDelft.NL>
Subject: Re: How to select different  S/PDIFoutput ports
  on a SBLive!
Date: Thu, 26 Sep 2002 10:19:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4B209F548AF@Octopus.et.tudelft.nl>
References: <4229AE35D6A@Octopus.et.tudelft.nl>
 <0H1P000C9NO5XV@mailhost1.tudelft.nl>
 <Pine.LNX.4.33.0209011718250.521-100000@pnote.perex-int.cz>
 <4229AE35D6A@Octopus.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhegfo1q0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

Takashi wrote

>Gerard Janssen wrote:
>> 
>> I tried to find the spdif output port addresses by changing the register
>> addresses of EXTOUT_TOSLINK_L/R in emu10k1.h to all 16 possible output
>> address pairs between (00 - 1f). To do this, I removed the extout_mask
>> check in emufx.c in the piece of code given below. I found the addresses of
>> the four spdif output ports of the SBLive! card (I did/could not check this
>> for the Audigity) and they are as follows: spdifo#0 = (0x02,0x03), which is
>> the standard output, spdifo#1 = (0x04,0x05), spdifo#2 = (0x06,0x07) and
>> spdifo#3 = (0x08,0x09).
>> 
>> So in principle it seems to be possible to create 8 digital output channels
>> on the SBLive!, however at the cost of some of its standard
>> functionalities, namely the outputs of the center_lfe, headphone and rear
>> channels to the LiveDrive (I think?). 
>
>it's interesting.
>are signals sent to all spdif outs without changing any other reigisters?

In this experiment, I just changed the address of EXTOUT_TOSLINK_L/R in
emu10k1.h. When using <aplay -D spdif "test.wav"> the signal is routed to
the respective SPDIF output ports coreesponding to the chosen
EXTOUT_TOSLINK_L/R adresses as mentioned above. 

>> 
>> Now, I would like to implement three additional spdif outputs in the same
>> way as the standard output, so without volume or tone control. I think,
>> this is an interesting extension of the functionality of the SBLive, since
>> by creating 8 independent digital outputs we get a functionality on a cheap
>> soundcard which is now only available at expensive (professional)
soundcards.
>> The problem is that I am not a programmer, however, I would like to give it
>> a try where any help from the ALSA community is very much appreciated. I
>> have the following questions:
>> 
>> 1. Is the code related to the standard spdif output in emufx.c, limited to
>> the following code lines or is there other code involved?
>> 	if (emu->fx8010.extout_mask &
>> ((1<<EXTOUT_TOSLINK_L)|(1<<EXTOUT_TOSLINK_R))) {
>> 		/* IEC958 Optical Raw Playback Switch */
>> 
>> 		for (z = 0; z < 2; z++) {
>> 			SWITCH(icode, &ptr, tmp + 0, 8 + z, gpr + z);
>> 			SWITCH_NEG(icode, &ptr, tmp + 1, gpr + z);
>> 			SWITCH(icode, &ptr, tmp + 1, playback + SND_EMU10K1_PLAYBACK_CHANNELS +
>> z, tmp + 1);
>> 			OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_TOSLINK_L + z), GPR(tmp + 0),
>> GPR(tmp + 1), C_00000000);
>> 		}
>> 		snd_emu10k1_init_stereo_onoff_control(controls + i++, "IEC958 Optical Raw
>> Playback Switch", gpr, 0);
>> 		gpr += 2;
>> 	}
>
>the code above implements a switch for "raw" playback (e.g. ac3).
>at the first step, you can skip this switch and route wet signals like
>others.

OK, in a following experiment I will try to route the "Process FX Buses"
directly to the SPDIF outputs using:
OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_X_L + z), GPR(FX_Bus_Y +z),
C_00000000, C_00000000);
and neglect the current routings.

>> 
>> 3. Do I need to implement additional "Process FX Buses" (now there are 9
>> buses, indicated as GPR(0) - GPR(9), where GPR(8) and GPR(9) have the
>> comment S/PDIF left/right)?
>
>we might need more two FX buses for all 4 separate outputs (see below
>my comments).
>GPR(8) and (9) are used for raw playback, so additionally we need more
>if 4 raw playbacks are needed, too.
>
>the necessary changes would be to add controls to change other SPCS
>registers via mixer (and more "raw playback" switches if necessary).
>
>basically, the routing can be controlled via a mixer control element.
>that is, to which FX bus and how much the signal is sent.
>on the current code, you cannot separate spdif #1 and #2, since both
>use the same center/lfe source.  thus, we can define new FX channels
>for them and mix if neceessary.

I added SPCS3 on address 0x57, and increased the spdif_bits array form 3 to
4 locations in emu10k1.h. Further, SPCS3 was initialized in emu10k1_main.c.
Is this sufficient to make it active and remove the sharing of SPCS2 for
SPDIF2&3? 

>even with the current code, you can change the routing like the
>following:
>
>SPDIF #0
>	normal spdif playback
>	% aplay -Dspdif ...
>
>SPDIF #1
>	(adjust Wave Center Playback Volume
>	        Wave LFE Playback Volume)
>	% aplay -Dcenter_lfe ...
>
>SPDIF #2
>	(toggle Headphone Center Playback Switch,1
>	    and Headphone LFE Playback Switch,1
>	adjust Headphone Playback Volume,1
>	in addition to the volumes for spdif#2)
>	% aplay -Dcenter_lfe ...
>
>SPDIF #3
>	(adjust Wave Surround Playback Volume)
>	% aplay -Drear ...
>
Ok, my preference is to have a direct rout towards the SPDIF outputs
without amplitude or tone control. A switch to choose between either the
original application with the LiveDrive and its routings/controls or four
SPDIF outputs with or without further controls could be a solution.

Thanks,

Gerard





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
