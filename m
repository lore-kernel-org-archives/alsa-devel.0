From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Re: [Alsa-user] How to select different  S/PDIFoutput
 ports on a SBLive!
Date: Tue, 24 Sep 2002 17:56:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209241752480.503-100000@pnote.perex-int.cz>
References: <s5hhegfo1q0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Gerard Janssen <G.Janssen@ITS.TUDelft.NL>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Sep 2002, Takashi Iwai wrote:

> Hi,
> 
> (I removed alsa-users from Cc)
> 
> At Fri, 20 Sep 2002 10:56:01 +0200,
> Gerard Janssen wrote:
> > 
> > I tried to find the spdif output port addresses by changing the register
> > addresses of EXTOUT_TOSLINK_L/R in emu10k1.h to all 16 possible output
> > address pairs between (00 - 1f). To do this, I removed the extout_mask
> > check in emufx.c in the piece of code given below. I found the addresses of
> > the four spdif output ports of the SBLive! card (I did/could not check this
> > for the Audigity) and they are as follows: spdifo#0 = (0x02,0x03), which is
> > the standard output, spdifo#1 = (0x04,0x05), spdifo#2 = (0x06,0x07) and
> > spdifo#3 = (0x08,0x09).
> > 
> > So in principle it seems to be possible to create 8 digital output channels
> > on the SBLive!, however at the cost of some of its standard
> > functionalities, namely the outputs of the center_lfe, headphone and rear
> > channels to the LiveDrive (I think?). 
> 
> it's interesting.
> are signals sent to all spdif outs without changing any other reigisters?
> 
> > 
> > Now, I would like to implement three additional spdif outputs in the same
> > way as the standard output, so without volume or tone control. I think,
> > this is an interesting extension of the functionality of the SBLive, since
> > by creating 8 independent digital outputs we get a functionality on a cheap
> > soundcard which is now only available at expensive (professional) soundcards.
> > The problem is that I am not a programmer, however, I would like to give it
> > a try where any help from the ALSA community is very much appreciated. I
> > have the following questions:
> > 
> > 1. Is the code related to the standard spdif output in emufx.c, limited to
> > the following code lines or is there other code involved?
> > 	if (emu->fx8010.extout_mask &
> > ((1<<EXTOUT_TOSLINK_L)|(1<<EXTOUT_TOSLINK_R))) {
> > 		/* IEC958 Optical Raw Playback Switch */
> > 
> > 		for (z = 0; z < 2; z++) {
> > 			SWITCH(icode, &ptr, tmp + 0, 8 + z, gpr + z);
> > 			SWITCH_NEG(icode, &ptr, tmp + 1, gpr + z);
> > 			SWITCH(icode, &ptr, tmp + 1, playback + SND_EMU10K1_PLAYBACK_CHANNELS +
> > z, tmp + 1);
> > 			OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_TOSLINK_L + z), GPR(tmp + 0),
> > GPR(tmp + 1), C_00000000);
> > 		}
> > 		snd_emu10k1_init_stereo_onoff_control(controls + i++, "IEC958 Optical Raw
> > Playback Switch", gpr, 0);
> > 		gpr += 2;
> > 	}
> 
> the code above implements a switch for "raw" playback (e.g. ac3).
> at the first step, you can skip this switch and route wet signals like
> others.
> 
> > 
> > 2. To what address does "tmp" refer in the OP instruction above?
> 
> initialized at the beginning of the function.  it's 0x88.
> as imagined from its name, it's a temporary GPR.
> 
> > 3. Do I need to implement additional "Process FX Buses" (now there are 9
> > buses, indicated as GPR(0) - GPR(9), where GPR(8) and GPR(9) have the
> > comment S/PDIF left/right)?
> 
> we might need more two FX buses for all 4 separate outputs (see below
> my comments).
> GPR(8) and (9) are used for raw playback, so additionally we need more
> if 4 raw playbacks are needed, too.
> 
> > 4. I thought that the spdif channel status registers SPCS0-3 (I added an
> > SPCS3 on address 0x57 in emu10k1.h) were initialized in emu10k1_main.c.
> > However, after playing a wave file using aplay via spdif at 44.1 kHz, the
> > sample frequency in SPCS is changed from 48 kHz to 44.1 kHz. Also other
> > changes appear in some SPCS values, which I cannot trace back. Where in the
> > code is the SPCS value changed?
> 
> SPCS is changed in snd_emu10k1_spdif_put() (in emumixer.c).
> the value is changed if you open the pcm with arguments like
> AES0=xxx.
> 
> 
> the necessary changes would be to add controls to change other SPCS
> registers via mixer (and more "raw playback" switches if necessary).
> 
> basically, the routing can be controlled via a mixer control element.
> that is, to which FX bus and how much the signal is sent.
> on the current code, you cannot separate spdif #1 and #2, since both
> use the same center/lfe source.  thus, we can define new FX channels
> for them and mix if neceessary.

We're very tight with GPRs with the current firmware. Implementing next 
features will require the firmware linker / manager in the user space.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
