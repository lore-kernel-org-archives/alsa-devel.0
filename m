From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] [SB Audigy4] capturing problems
Date: Sun, 11 Dec 2005 00:09:18 -0500
Message-ID: <1134277759.6019.4.camel@mindpipe>
References: <200512101453.50834.trapni@gentoo.org>
	 <200512102054.56708.trapni@gentoo.org>
	 <1134247250.18432.112.camel@mindpipe>
	 <200512110557.23619.trapni@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200512110557.23619.trapni@gentoo.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christian Parpart <trapni@gentoo.org>
Cc: alsa-user@lists.sourceforge.net, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-12-11 at 05:57 +0100, Christian Parpart wrote:
> On Saturday 10 December 2005 21:40, Lee Revell wrote:
> [...]
> > OK.  Just for the sake of future driver improvements, do you know what
> > capabilities is the Audigy4 supposed to have that the Audigy2 does not?
> 
> technical specification (shamelessly stolen from retail box :D):
> * 64 audio channel playback with independent sample rates
> * 24bit digital-to-analog conversion during playback with 
>   sampling rates of 8, 11.025, 16, 22.05, 24, 32, 44.1, 48 and 
>   96kHz in 7.1 mode and up to 192kHz in stereo mode
> * 24bit analog-to-digital conversion during recording in 8, 16, 
>   or 24bit at sampling rates of 8, 11.025, 16, 22.05, 24, 32, 
>   44.1, 48 and 96kHz
> * supports sony/philips digital interface (spdif) format of 
>   up to 24bit/96kHz quality
> * low latency multitrack recording with ASIO 2.0 support
> 
> Now this:
> 
> battousai linux # cat /proc/asound/pcm
> 00-00: emu10k1 : ADC Capture/Standard PCM Playback : playback 32 : capture 1
> 00-01: emu10k1 mic : Mic Capture : capture 1
> 00-02: emu10k1 efx : Multichannel Capture/PT Playback : playback 8 : capture 1
> 00-03: emu10k1 : Multichannel Playback : playback 1
> 00-04: p16v : p16v : playback 1 : capture 1
> 
> ^^ the above shows me a playback of 32 and capture of 1.
> is this correct, I'm asking because the spec tells something about 64 audio 
> channel playback (unfortunately doesn't mention the capture side :(

Hmm, yes, that might be the difference.  It sounds exactly like the
Audigy2 but with 64 substreams rather than 32.  And 64 substreams would
fit nicely into the current driver without requiring a new register
addressing scheme (see emu10k1.h, PTR_CHANNEL_MASK is 0x3f).

I'll send an experimental patch.

Lee

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
