From: Matthias Diehl <mdiehl.os@gmx.de>
Subject: Testers wanted: New SB X-Fi driver
Date: Tue, 30 Jun 2009 19:55:44 +0200
Message-ID: <1246384544.6380.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 12F652443F
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 19:55:49 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

> At Tue, 30 Jun 2009 16:10:45 +0200,
> Matthias Diehl wrote:
> > 
> > hi,
> > 
> > i guess you dont speak german, do you? well, i'll try it in 
> english ;-)
> > 
> > i tried to install your newest x-fi "hack" in ubuntu 9.04 64bit. 
> it's an x-fi extreme music. i downloaded this snapshot:
>> 
>
ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz
>
> Use alsa-driver-snapshot.tar.gz instead of the unstable one.
>
> > while the installation process there are some warnings. after 
> replacing the demon.conf and reboot there was no sound. 
> > 
> > then i noticed the sentence "Note that the ctxfi driver might 
> conflict with the HD-audio driver" in the description. i think my
> problem is the hdmi soundchip from my graphics adapter (sapphire 
> radeon hd 4870) which was automatically installed at the 
> ubuntu-installation 
> ("hda intel sound").
>
> You are likely looking at irrelevant things.
>
> There are several variants of X-Fi boards. Many of them are equipped
> with emu20k1 or emu20k2 chip. Some of these models can behave as
> HD-audio compatible, too. These are supported by snd-ctxfi driver.
>
> In addition, there is X-Fi models that are without emu20k1/emu20k2
> chips. Some of them (CA0110-IBG) behave only as a HD-audio device,
> and some others are with CA0106 chip. The former is supported by
> snd-hda-intel driver and the latter by snd-ca0106 driver.
>
> So, they cannot be deactivated. The only question is whether you have
> emu20k1/emu20k2 chip on your board. And this can be checked when you
> load snd-ctxfi driver. If the driver is properly loaded and the
> card instance is created (see /proc/asound/cards), then it's good.
> Otherwise, your board is no such one. You need other drivers.
>
> Please ask further questions on alsa-devel ML (you can add me to Cc,
> though) so that other people with your board can advice better.
>
>
> HTH,
>
> Takashi

hi there,

i now tried to install the stable version, but i have still no sound.
here's what lspci | grep audio says:
01:00.1 Audio device: ATI Technologies Inc HD48x0 audio
05:00.0 Multimedia audio controller: Creative Labs SB X-Fi

lsmod | grep snd says:
snd_hda_intel         557492  1 
snd_pcm_oss            52352  0 
snd_mixer_oss          24960  2 snd_pcm_oss
snd_pcm                99336  2 snd_hda_intel,snd_pcm_oss
snd_seq_dummy          11524  0 
snd_seq_oss            41984  0 
snd_seq_midi           15744  0 
snd_rawmidi            33920  1 snd_seq_midi
snd_seq_midi_event     16512  2 snd_seq_oss,snd_seq_midi
snd_seq                66272  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              34064  2 snd_pcm,snd_seq
snd_seq_device         16276  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd                    78792  9 snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore              16800  2 snd
snd_page_alloc         18704  2 snd_hda_intel,snd_pcm

cat /proc/asound/cards says: 
 0 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xf7dfc000 irq 17

i hope, someone can help me ...
greetings from germany,
matthias
