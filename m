From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: add 96Khz support and setting sample rate
 for	direct SPDIF output
Date: Wed, 09 Feb 2005 12:32:27 -0500
Message-ID: <1107970348.7391.8.camel@krustophenia.net>
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

I am just wondering, has anyone tried this yet by connecting the SPDIF
output to something?  I am curious to see if it works.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
