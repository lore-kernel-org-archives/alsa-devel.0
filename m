From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1 multichannel support
Date: Wed, 26 Jan 2005 13:05:19 -0500
Message-ID: <1106762719.2935.77.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <s5hpt01tler.wl@alsa2.suse.de> <1106343921.3232.50.camel@krustophenia.net>
	 <41F2F481.2000304@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41F2F481.2000304@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-01-23 at 00:49 +0000, James Courtier-Dutton wrote:
> I am currently doing work on the P16V chip that is on the Audigy 2 sound 
> cards. It will be able to capture and playback 4 stereo channels at the 
> same time, at anything from 44.1 khz up to 192khz. It can also pass 
> samples to and from the EMU10K2 DSP, but it transfers them in blocks of 
> 8 mono channels. e.g. DSP fxchannel 0-7 or 8-15 or 16-23 etc.
> So, I think it would be better if the multichannel patch you are doing 
> uses those groupings of channels for multichannel play/capture.

OK.  I have read your patch, it's really a marvel of reverse
engineering.  So far I have not tackled the problem of how to present
the multichannel capture controls to the user in a reasonable way.  For
now my patch hardcodes the EFX voices mask control to capture 16 of the
upper outputs (FXBUS2 and A_FXBUS2).  These correspond to the high 16
bits of FXWC on SBLive and the low 16 bits of A_FXWC2 on Audigy.  I also
plan to support channel counts other than 16 for playback.

Meanwhile I have updated the definitions of the I/O GPRs to reflect the
current knowledge of the hardware.  This makes implementing FXBUS and
P16V capture easier.  Actually you could test the P16V -> DSP signal
path now, just change A_FXBUS to A_P16VIN in this line from my patch:

/* EFX capture - capture the first 16 FX buses */
for (z = 0; z < 16; z++) {
        A_OP(icode, &ptr, iACC3, A_FXBUS2(z), A_C_00000000, A_C_00000000, A_FXBUS(z));
}

and you should be able to capture the 48Khz-resampled P16V streams with hw:0,2.

Hmm, that gives me an idea, there are 16 more A_FXBUS2 recording inputs,
we could just connect the P16V outputs like so:

/* P16V capture - capture the 16 P16V inputs */
for (z = 16; z < 32; z++) {
        A_OP(icode, &ptr, iACC3, A_FXBUS2(z), A_C_00000000, A_C_00000000, A_P16VIN(z - 16));
}

Then you could have a mixer control that sets the low 16 bits of A_FXWC2
to capture the first 16 FX buses***, or the high 16 bits to capture the
P16V inputs, or both.  While we are at it we should let them set the low
16 bits of A_FXWC1 to capture the physical outs or the high 16 to
capture ???.  On SBLive they can set the low 16 FXWC bits to capture
their physical outs or the high 16 to capture the FX buses***. 

It gets slightly more complicated if you want to let them capture groups
of 8 because you have to decide which 8.  Also the groups of 16 channels
seem to form logical units.  Anyway capturing P16V via the DSP is handy
for testing but it's really not going to be a common use of the device.
People who want to use the DSP will run at 48Khz and people who want
44.1, 96 or 192khz will just use the P16V.  The only application I can
remotely think of is a video game with 24/96 content that wants to use
the DSP for 3D audio/EAX type stuff, which isn't even implemented on
Linux.

http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v006.patch

Audigy:

#define A_FXBUS(x)      (0x00 + (x))    /* x = 0x00 - 0x3f FX buses */
#define A_EXTIN(x)      (0x40 + (x))    /* x = 0x00 - 0x0f physical ins */
#define A_P16VIN(x)     (0x50 + (x))    /* x = 0x00 - 0x0f p16v ins (A2 only) "EMU32 inputs" */
#define A_EXTOUT(x)     (0x60 + (x))    /* x = 0x00 - 0x1f physical outs -> A_FXWC1 0x79-7f unknown   */
#define A_FXBUS2(x)     (0x80 + (x))    /* x = 0x00 - 0x1f extra outs used for EFX capture -> A_FXWC2 */
#define A_EMU32OUTH(x)  (0xa0 + (x))    /* x = 0x00 - 0x0f "EMU32_OUT_10 - _1F" - ??? */
#define A_EMU32OUTL(x)  (0xb0 + (x))    /* x = 0x00 - 0x0f "EMU32_OUT_1 - _F" - ??? */
#define A_GPR(x)        (A_FXGPREGBASE + (x))

SBLive:

/* GPRs */
#define FXBUS(x)        (0x00 + (x))    /* x = 0x00 - 0x0f */
#define EXTIN(x)        (0x10 + (x))    /* x = 0x00 - 0x0f */
#define EXTOUT(x)       (0x20 + (x))    /* x = 0x00 - 0x0f physical outs -> FXWC low 16 bits */
#define FXBUS2(x)       (0x30 + (x))    /* x = 0x00 - 0x0f copies of fx buses for capture -> FXWC high 16 bits */
                                        /* NB: 0x31 and 0x32 are shared with Center/LFE on SB live 5.1 */


Lee



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
