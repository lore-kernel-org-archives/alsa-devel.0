From: Hector Martin <hector@marcansoft.com>
Subject: Re: Request for Device ID addition : 6935G
Date: Sat, 13 Jun 2009 18:11:15 +0200
Message-ID: <4A33CFA3.7080402@marcansoft.com>
References: <4b8c423b0906121924u757d590ay49e09f3fea3c99e@mail.gmail.com>
	<s5hfxe4lf4l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 2295024591
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 18:11:20 +0200 (CEST)
In-Reply-To: <s5hfxe4lf4l.wl%tiwai@suse.de>
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
Cc: Karthik Ramgopal <applefreakpeeps@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hector, does it work on your machine?  If yes, there should be a
> slight difference between 6935G and 8930G...
Yes, the DMIC works fine here (in mono mode).

Karthik: please look in sound/pci/hda/patch_realtek.c and locate the
alc889_acer_aspire_8930g_verbs array. At the end, where it talks about
the "DMIC fix", find the last verb:

{0x20, AC_VERB_SET_PROC_COEF, 0x0003},

And change the value from 0x0003 to 0x0001 and see what that does.

If this works and you get some audio, make a stereo recording. You want
both channels to be of equal volume.

I suspect you have a mono mic on the left channel. I have a stereo
sum/difference mic (WTF) with sum on the right channel, so I tweaked the
setting to replicate the right channel to both. This would kill your
audio if your microphone is just a mono one on the left channel. Setting
0x0001 should get you standard stereo audio as it comes from the mic(s).
I think setting 0x0002 should get you what you want (left channel
replicated to both channels). If not, try setting 0x0000.

Takashi: if I'm right, we'll need two model entries instead of one and
we should probably split off the verb array into three (base, stereo
sum/dif mic fix, mono mic fix).

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
