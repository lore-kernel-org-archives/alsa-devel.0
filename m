From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: Problem with mplayer and OSS on at91sam9g20(kernel
 2.6.30)
Date: Mon, 28 Sep 2009 09:56:31 +0200
Message-ID: <4AC06C2F.6070409@atmel.com>
References: <4ABB67CA.6000003@atmel.com> <20090924145755.GB5105@sirena.org.uk>
	<4ABC6B34.7080200@ladisch.de>
	(sfid-20090925_080742_312890_600E81AE)
	<A6B4CA7C-DA92-47A7-B5C0-2668E8CA7FF2@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id B94E5243CB
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 09:56:52 +0200 (CEST)
In-Reply-To: <A6B4CA7C-DA92-47A7-B5C0-2668E8CA7FF2@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi,
 >> > > Mark Brown wrote:
 >>> > >> I'd expect it's getting upset because it's being called with an
 >>> > >> invalid rate (OSS emulation calls hw_params with partially
 >>> > >> initialised
 >>> > >> parameters)
 >> > >
 >> > > But even the uninitialized parameters conform to the constraints 
that
 >> > > were set by the driver, so they should never be invalid.
 > >
 > > ASoC drivers, particularly ones doing manual clocking like this one,
 > > don't always express their full constraints to the application (in
 > > some cases it'd be far too hard).
 > >
 >> > > Sedji, try running mplayer with -v, this should give more log 
messages
 >> > > with the parameters that mplayer is trying to set.

Here is the mplayer -v output:

[..]
==========================================================================
Forced audio codec: mad
Opening audio decoder: [libmad] libmad mpeg audio decoder
dec_audio: Allocating 4096 bytes for input buffer.
dec_audio: Allocating 9216 + 65536 = 74752 bytes for output buffer.
AUDIO: 44100 Hz, 2 ch, s16le, 96.0 kbit/6.80% (ratio: 12000->176400)
Selected audio codec: [mad] afm: libmad (libMAD MPEG layer 1-2-3)
==========================================================================
Building audio filter chain for 44100Hz/2ch/s16le -> 0Hz/0ch/??...
[libaf] Adding filter dummy
[dummy] Was reinitialized: 44100Hz/2ch/s16le
[dummy] Was reinitialized: 44100Hz/2ch/s16le
ao2: 44100 Hz  2 chans  s16le
audio_setup: using '/dev/dsp' dsp device
audio_setup: using '/dev/mixer' mixer device
audio_setup: using 'pcm' mixer device
audio_setup: sample format: s16le (requested: s16le)
audio_setup: using 2 channels (requested: 2)
audio_setup: using 44100 Hz samplerate (requested: 44100)
[AO OSS] audio_setup: driver doesn't support SNDCTL_DSP_GETOSPACE  :-(
audio_setup: 512 bytes/frag (config.h)
AO: [oss] 44100Hz 2ch s16le (2 bytes per sample)
AO: Description: OSS/ioctl audio output
AO: Author: A'rpi
Building audio filter chain for 44100Hz/2ch/s16le -> 44100Hz/2ch/s16le...
[dummy] Was reinitialized: 44100Hz/2ch/s16le
[dummy] Was reinitialized: 44100Hz/2ch/s16le
Video: no video
Freeing 0 unused video chunks.
Starting playback...
A:  -1.5 (unknown) of 1506.0 (25:06.0) ??,?%

[.. no sound and many "asoc: machine hw_params failed" on the console ..]

MPlayer interrupted by signal 2 in module: play_audio
Uninit audio filters...
[libaf] Removing filter dummy
Uninit audio: libmad


Thanks for your help,

Best regards,
Sedji
