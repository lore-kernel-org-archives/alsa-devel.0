From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Bizarre ATI SB450 behavior
Date: Fri, 07 Sep 2007 06:48:22 -0700
Message-ID: <1189172902.871.48.camel@razman.gruemaster.com>
References: <Pine.LNX.4.62.0709062122080.12004@refresco.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C96F10389A
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Sep 2007 15:48:24 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.62.0709062122080.12004@refresco.dreamhost.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Hughes <rjhughes@iheartryan.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please download alsa-1.0.15rc1 from http://alsa-project.org or a daily
snapshot from ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/ and
try it.  If you are still having issues, please run
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh and post the
link that it creates.

Thanks,

Tobin

On Thu, 2007-09-06 at 21:43 -0700, Ryan Hughes wrote:

> Hi.  I've got a little situation over here.
> 
> Every time I poll any software, it totally believes that the sound-card is 
> installed and configured correctly and working.  Nobody complains.  But 
> when I try to play sound, none comes out.  People usually suggest the 
> alsamixer, to make sure none of my channels are muted.  Truly, none of 
> them are muted.
> 
> Here's the vital stats:
> 
> 
> lspci | grep -i audio
> 00:14.2 Audio device: ATI Technologies Inc SB450 HDA Audio (rev 01)
> 
> 
> aplay -l
> card 0: SB [HDA ATI SB], device 0: STAC92xx Analog [STAC92xx Analog]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> 
> 
> lsmod | grep snd
> snd_hda_intel         262424  1
> snd_pcm_oss            44672  0
> snd_mixer_oss          17792  1 snd_pcm_oss
> snd_pcm                80900  2 snd_hda_intel,snd_pcm_oss
> snd_seq_dummy           4996  0
> snd_seq_oss            35072  0
> snd_seq_midi            9728  0
> snd_rawmidi            25984  1 snd_seq_midi
> snd_seq_midi_event      8576  2 snd_seq_oss,snd_seq_midi
> snd_seq                54000  6 
> snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
> snd_timer              24196  2 snd_pcm,snd_seq
> snd_seq_device          9612  5 
> snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
> snd                    56324  12 
> snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_dummy,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
> soundcore               8672  1 snd
> snd_page_alloc         11272  2 snd_hda_intel,snd_pcm
> 
> 
> Interesting pieces of dmesg
> [   22.061858] ALSA 
> /usr/src/alsa-driver-1.0.14/pci/hda/../../alsa-kernel/pci/hd
> a/patch_si3054.c:244: si3054: cannot initialize. EXT MID = 0000
> [   48.948578] hda-intel: Invalid position buffer, using LPIB read method 
> instea
> d.
> 
> 
> Am I missing any useful info?
> Kernel is 2.6.20-16
> 
> Alsa is a hand-compiled 1.0.14.
> 
> Thanks.
> --Ryan
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
