From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: add 96Khz support and setting sample rate
 for	direct SPDIF output
Date: Tue, 08 Feb 2005 16:31:52 -0500
Message-ID: <1107898312.27048.52.camel@krustophenia.net>
References: <1107724363.4212.74.camel@krustophenia.net>
	 <s5hwttiu98j.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hwttiu98j.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-02-08 at 20:45 +0100, Takashi Iwai wrote:
> At Sun, 06 Feb 2005 16:12:43 -0500,
> Lee Revell wrote:
> > 
> > This patch should add support for 96Khz "direct SPDIF" aka "SPDIF
> > Bypass" (not P16V) playback mode available on the Audigy1 and 2 and
> > newer SBLives (?).  It lets you bypass the 48khz DSP resampling when
> > using the card in digital mode.  It also adds 96khz analog playback
> > support, good for testing but less interesting because it's downsampled
> > to 48khz.  A new mixer control "Audigy SPDIF Output Sample Rate" is
> > created, you can choose 44100, 48000, or 96000.  Standard SPDIF
> > playback, AC3 passthrough (real 96khz playback), and analog playback
> > (96khz is resampled to 48khz in the DSP) all work with a 16 bit,96khz
> > wav file.  Only the last was tested due to lack of any SPDIF hardware.
> 
> What happens if you play in a non-matching sample rate or a strange
> rate like 45000Hz?
> 

Works fine in analog mode.  I just made a 51000Hz wave file and it
played fine, sounds exactly like the 48KHz original.  For SPDIF bypass
mode it would presumably get resampled to 44.1, 48, or 92Khz depending
on the control setting.

> > This was derived mostly from the opensource.creative.com driver.  All
> > that was needed for 96khz playback to work in analog mode was changing
> > the format to 8000_96000 (looks like the creative driver supports 192khz
> > too).
> 
> 192kHz results in pitch_target=0x10000, so needs a correction to
> 0xffff?   Just a guess.  I'll need to take a look at creative driver.
> 

Right, it supports anything < 192000 (from cardwo.c):

int sblive_waveoutQueryFormat(struct sblive_waveout *card_waveout, struct wave_format * wave_fmt, u32 flags)
{
        if (flags & CARDWAVE_QF_CHANNEL) 
          if ((card_waveout->numplaybackinst) > card_waveout->maxnumplayinst)
            return CTSTATUS_INUSE;
         
        if (flags & CARDWAVE_QF_RATE) 
          if (wave_fmt->samplingrate >= 0x2EE00) /* FIXME: 0x2ee00 = 192000! Is this valid??? */
            return CTSTATUS_BADFORMAT_RATE;
         
        if (flags & CARDWAVE_QF_BITS) 
          if (wave_fmt->bitspersample != 8 && wave_fmt->bitspersample != 16)
            return CTSTATUS_BADFORMAT_BITS;
         
        return CTSTATUS_SUCCESS;
}

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
