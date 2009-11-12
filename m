From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PC Beep or PC Speaker or just Beep? and HDA Beep
 code...
Date: Thu, 12 Nov 2009 11:42:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911121056030.4806@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0910221740280.5519@eeebox2.perex-int.cz>
	<s5h1vklythl.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031147520.5500@eeebox2.perex-int.cz>
	<s5hiqdrlu8n.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031235130.5500@eeebox2.perex-int.cz>
	<s5heioflt08.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031510170.5500@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E93A103856
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 11:42:25 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.0911031510170.5500@eeebox2.perex-int.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Nov 2009, Jaroslav Kysela wrote:

>>> I don't see a problem. If you find the behaviour too risky, we can limit
>>> the register/unregister calls in time. Like one register call in one
>>> second.
>> 
>> Oh no, that'd be very strange behavior as an mixer element.
>
> I recoded patch to delay the detach only to get consistent and abuse prone 
> behaviour:
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=ba9c08c61338f298df34445715287beeca94b024
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=0633c8e977b7708ea122392d87cc15ca448fc5d5
>
> The HDA beep output is muted immediately, of course.

Any chance to get my HDA beep updates merged to linux-next tree?

[ALSA] hda_intel: Digital PC Beep - change behaviour for input layer
[ALSA] hda_intel: Digital PC Beep - delay input device unregistration
[ALSA] hda: beep - add missing cancel_delayed_work

Reasons for merge:

- it's tested
- it's compatible with all kernels (including ones without
   the future input layer modifications)
- the code is more structured which can help us to rebind
   "on request" input registration to another logic later
- Beep mute switch now disables the tone generator on the off request -
   it might be considered as bug in the previous beep code

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
