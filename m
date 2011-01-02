From: Pavel Machek <pavel@ucw.cz>
Subject: Re: CONFIG_SND_HDA_INTEL regression on 2.6.37-rc3 - no
	audio
Date: Sun, 2 Jan 2011 10:11:04 +0100
Message-ID: <20110102091104.GY32469@atrey.karlin.mff.cuni.cz>
References: <AANLkTi=ywUP8QUDGqotutccf9E2a1b5U2bKNZDWa3PG3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (ksp.mff.cuni.cz [195.113.26.206])
	by alsa0.perex.cz (Postfix) with ESMTP id AAA962457D
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2011 10:11:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ywUP8QUDGqotutccf9E2a1b5U2bKNZDWa3PG3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Luis R. Rodriguez" <mcgrof@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

> I just booted 2.6.37-rc3 and noticed my sound with
> CONFIG_SND_HDA_INTEL stopped working, I get no audio at all. Is this a
> known regression? I can bisect if not.
> 
> $ lsmod| grep snd
> snd_hda_codec_analog    79955  1
> snd_hda_intel          25446  3
> snd_hda_codec         101539  2 snd_hda_codec_analog,snd_hda_intel
> snd_hwdep               6546  1 snd_hda_codec
> snd_pcm                88139  3 snd_hda_intel,snd_hda_codec
> snd_seq_midi            5900  0
> snd_rawmidi            21916  1 snd_seq_midi
> snd_seq_midi_event      7291  1 snd_seq_midi
> snd_seq                56979  2 snd_seq_midi,snd_seq_midi_event
> snd_timer              23148  2 snd_pcm,snd_seq
> snd_seq_device          6912  3 snd_seq_midi,snd_rawmidi,snd_seq
> snd                    63192  15
> snd_hda_codec_analog,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,thinkpad_acpi,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
> soundcore               1240  1 snd
> snd_page_alloc          8716  2 snd_hda_intel,snd_pcm

I see something similar... but oss emulation still works as expected
for me. Can you try it that way? (/dev/dsp).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
