From: Robert Hancock <hancockrwd@gmail.com>
Subject: VIA VT1828S hda_intel errors
Date: Thu, 29 Oct 2009 19:05:15 -0600
Message-ID: <4AEA3BCB.5040202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f190.google.com (mail-yw0-f190.google.com
	[209.85.211.190])
	by alsa0.perex.cz (Postfix) with ESMTP id C4179243D2
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 02:05:18 +0100 (CET)
Received: by ywh28 with SMTP id 28so2294006ywh.16
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 18:05:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, LydiaWang@viatech.com.cn, Logan Li <loganli@viatech.com.cn>, Harald Welte <HaraldWelte@viatech.com>
List-Id: alsa-devel@alsa-project.org

I've been using the VT1828S codec support from ALSA git for the last few 
weeks. It seems to work fine, but there are some problems showing up in 
dmesg:

Oct 25 20:46:14 newcastle kernel: ALSA sound/pci/hda/hda_intel.c:683: No 
response from codec, disabling MSI: last cmd=0x02af0900
Oct 25 20:46:15 newcastle kernel: ALSA sound/pci/hda/hda_intel.c:698: 
azx_get_response timeout, switching to polling mode: last cmd=0x02af0900

It seems like the cmd isn't always the same, previously it was 
0x024f0c00. Is there something bad about this command that could be 
causing the response timeout? Also, disabling MSI for one occurrence of 
this seems a bit paranoid..

Also saw one of these:

Oct 26 21:13:20 newcastle kernel: hda-intel: IRQ timing workaround is 
activated for card #0. Suggest a bigger bdl_pos_adj.

and PulseAudio also complained:

Oct 26 00:27:50 newcastle pulseaudio[16530]: alsa-sink.c: ALSA woke us 
up to write new data to the device, but there was actually nothing to write!
Oct 26 00:27:50 newcastle pulseaudio[16530]: alsa-sink.c: Most likely 
this is a bug in the ALSA driver 'snd_hda_intel'. Please report this 
issue to the ALSA developers.
Oct 26 00:27:50 newcastle pulseaudio[16530]: alsa-sink.c: We were woken 
up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 
or another value < min_avail.
