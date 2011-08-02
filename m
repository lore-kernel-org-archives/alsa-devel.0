From: Pavel Roskin <proski@gnu.org>
Subject: Re: EeePC 1005PE microphone is "stereo only",
 silent in mono
Date: Tue, 02 Aug 2011 15:18:18 -0400
Message-ID: <4E384D7A.2020206@gnu.org>
References: <20110731233945.1frwedfvso8c8kck-cebfxv@webmail.spamcop.net>
	<s5hwrex5xd4.wl%tiwai@suse.de>
	<20110801131229.d0smwpen9cw0wg8k-cebfxv@webmail.spamcop.net>
	<s5hk4aws0r0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from c60.cesmail.net (c60.cesmail.net [216.154.195.49])
	by alsa0.perex.cz (Postfix) with ESMTP id E1C501038E5
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 21:18:22 +0200 (CEST)
In-Reply-To: <s5hk4aws0r0.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kailang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 08/02/2011 03:58 AM, Takashi Iwai wrote:

> Kailang at Realtek suggested that the verb above is only for ALC269vb,
> but he found out another workaround (coef idx 7 bit 7).
>
> Could you try the patch below?

It works!  However, I needed an extra change for the new code to be 
executed.  Also, I needed to backport the patch to Linux 3.0 (it's 
wireless-testing.git, but for the sound code, it's essentially Linux 3.0).

This condition is not true on my system:

if (board_config == ALC_MODEL_AUTO) {
          alc_pick_fixup(codec, NULL, alc269_fixup_tbl, alc269_fixups);
          alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
}

board_config is 4 (ALC269_DMIC).  So the condition needs to be removed 
for the fixup to be applied.  I guess the fixup for EeePC 1005HA should 
be called elsewhere.  I'm not using any module parameters.

I get nothing but noise on the sound-2.6/master branch.  It happens 
regardless of whether I'm using one or two channels with arecord.

I remember a few cases when I was able to record proper sound with 2 
channels on the sound-2.6/master kernel.  But most of the time, I would 
get that noise.  It looks like a separate regression.

I could try to bisect it.  It's a big investment of time, considering 
that the system has an Atom CPU, so I'd like to know if there is any 
interest in that, or there is some patch lying around that would address 
the noise problem.

So I backported the code to wireless-testing, where I would never get 
the noise.  Now I can record in mono through pulse audio.  The sound is 
nice and clean.  Everything is fine!

-- 
Regards,
Pavel Roskin
