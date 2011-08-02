From: Pavel Roskin <proski@gnu.org>
Subject: Re: EeePC 1005PE microphone is "stereo only",
 silent in mono
Date: Tue, 02 Aug 2011 16:15:14 -0400
Message-ID: <4E385AD2.7060904@gnu.org>
References: <20110731233945.1frwedfvso8c8kck-cebfxv@webmail.spamcop.net>
	<s5hwrex5xd4.wl%tiwai@suse.de>
	<20110801131229.d0smwpen9cw0wg8k-cebfxv@webmail.spamcop.net>
	<s5hk4aws0r0.wl%tiwai@suse.de> <4E384D7A.2020206@gnu.org>
	<s5h1ux3sjlp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from c60.cesmail.net (c60.cesmail.net [216.154.195.49])
	by alsa0.perex.cz (Postfix) with ESMTP id E000B1038D9
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 22:15:27 +0200 (CEST)
In-Reply-To: <s5h1ux3sjlp.wl%tiwai@suse.de>
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

On 08/02/2011 03:23 PM, Takashi Iwai wrote:

>> board_config is 4 (ALC269_DMIC).  So the condition needs to be removed
>> for the fixup to be applied.  I guess the fixup for EeePC 1005HA should
>> be called elsewhere.  I'm not using any module parameters.
>
> OK, then just pass model=auto.  It may result in different mixer
> elements, but mostly it should work.  (Actually it's helpful if you
> can test the auto-parser.)

That was it!  sound-2.6/master is working now.  No more noise.  Stereo 
and mono are fine.  No need to bisect anything.

So I just added "options snd_hda_intel model=auto" to /etc/modprobe.d

Obviously, it would be nice not to pass any parameters.  Things should 
just work.

>> I get nothing but noise on the sound-2.6/master branch.  It happens
>> regardless of whether I'm using one or two channels with arecord.
>
> Does it happen no matter whether patched and/or model option value?

The patch has no effect on the noise.  But model=auto makes all the 
difference.  And I wrongly assumed it was a default.

>> I remember a few cases when I was able to record proper sound with 2
>> channels on the sound-2.6/master kernel.  But most of the time, I would
>> get that noise.  It looks like a separate regression.
>>
>> I could try to bisect it.  It's a big investment of time, considering
>> that the system has an Atom CPU, so I'd like to know if there is any
>> interest in that, or there is some patch lying around that would address
>> the noise problem.
>
> Before starting bisecting, please give alsa-info.sh outputs on both
> working and non-working kernels.  Then we can compare the visible
> difference of register values (although coef stuff isn't exposed
> there).

I guess it's not needed anymore.  What's needed it to make "auto" the 
default (or some variation of that).

-- 
Regards,
Pavel Roskin
