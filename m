From: "Ihar Hrachyshka" <ihar.hrachyshka@gmail.com>
Subject: Re: How to choose output channels for AD1386A sound?
Date: Mon, 21 Apr 2008 10:45:51 +0300
Message-ID: <fce2a370804210045o5a60fbc5qc20565758868642e@mail.gmail.com>
References: <fce2a370804170327j7c6bebb1j3f96d213d6aa677a@mail.gmail.com>
	<s5hmynsd77z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id BBBAC1037F9
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 09:45:52 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 5so1008821ywr.2
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 00:45:51 -0700 (PDT)
In-Reply-To: <s5hmynsd77z.wl%tiwai@suse.de>
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 17, 2008 at 2:57 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 17 Apr 2008 10:27:59 +0000,
>
> Ihar Hrachyshka wrote:
>  >
>  > Hello!
>  > I build my BF533-EZKIT-based board (Blackfin processor development
>  > board) sound system on AD1386A sound. I use blackfin.uclinux.org
>  > distribution for it. One of my board's function is to play three
>  > different stereo sound streams simultaneously on it. What I done is
>  > choosing for AD1386 '3 stereos' option. After loading the kernel, my
>  > software is able to open pcm 3 times and plays sound properly, with no
>  > glitches or smth. The only missed functionality is that I can't
>  > specify the needed subdevice I want to play a stream on. I should have
>  > the possibility to play, f.e., mplayer stream on the 3rd stereo output
>  > while the 1st and the 2nd are not used. How can I do it?
>
>  You can pass three numbers to PCM arguments: card, device and
>  subdevice.  For example, the below will choose card = 0, device = 2,
>  subdevice = 1, i.e. the secondary substream:
>         % aplay -Dplughw:0,2,1
That's what I've done:

# arecord -c 2 -f dat -d 30 a.wav
# aplay -Dplughw:0,0,0 a.wav
ALSA sound/blackfin/ad1836.c:924: snd_ad1836_playback_open
Playing WAVE 'aAwLvS A  isnodu1n di/ biltaecEkdfai,nR/ta d8108 3z6 .tcr:o1

   046: snd_ad1836_hw_free
ALSA lib ../../../alsa-lib-1.0.12-svn-rev6478/src/pcm/pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange)
find an usable access for 'plughw:0,0,0'
aplay: set_params:904: Sample format non available

# arecord -c 2 -f S32_LE -d 30 a.wav
# aplay -Dplughw:0,0,0 a.wav
ALSA sound/blackfin/ad1836.c:924: snd_ad1836_playback_open
Playing WAVEA'L.SaA' :sSoguen d2/bbtlLatclk fniinn/ aade18803 6z. ct:r1o0

  46: snd_ad1836_hw_free
ALSA lib ../../../alsa-lib-1.0.12-svn-rev6478/src/pcm/pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange)
to find an usable access for 'plughw:0,0,0'
aplay: ../../aplay/aplay.c: 919: set_params: Assertion `err >= 0' failed.
Aborted by signal Aborted...

Though ALSA shows that I have 3 subdevices it doesn't work with
plughw:0,0,0..2. What else can I do to iinvestigate the problem?
>
>
>  > Also that would be great if I can optionally play the same stream on
>  > all the outputs.
>
>  You'll need to define a PCM with multi plugin.
>
>
>  Takashi
>
