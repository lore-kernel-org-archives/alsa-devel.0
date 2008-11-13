From: Andrei Tanas <andrei@tanas.ca>
Subject: Re:
 =?utf-8?q?Asus_P5QL-EM_motherboard_=28ALC1200_codec?=
 =?utf-8?q?=29_-=09no=09sound_through_S/PDIF?=
Date: Thu, 13 Nov 2008 13:23:11 -0500
Message-ID: <dac2d6bdab05085f114d23dd5c8bfe63@localhost>
References: <668af2a1e877d41c059f6c84fa462476@localhost>
	<1226564212.605116.29828@de> <s5htzacqbg8.wl%tiwai@suse.de>
	<45906fd26f62412a3c5030b12fead9dd@localhost>
	<s5habc3hcyy.wl%tiwai@suse.de>
	<cd166d9b036685894baef8cc5eb86b8d@localhost>
	<s5hzlk3fwc7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id D8FA710381C
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 19:23:13 +0100 (CET)
In-Reply-To: <s5hzlk3fwc7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <wfg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Nov 2008 17:02:16 +0100, Takashi Iwai <tiwai@suse.de> wrote:
>> My /dev/snd only has these:
>> controlC0  pcmC0D0c  pcmC0D0p  pcmC0D1c  pcmC0D1p  pcmC0D2c  timer
>> Should there be hw* nodes?
> 
> Build with CONFIG_SND_HDA_HWDEP=y.

Ok, I can see them now.
So, as far as I understand I should be able to use hda-verb to manually
control the codec. Can you suggest what I should read to understand how to
do this, what commands are available etc. (I have ALC883 datasheet).
