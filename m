From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH] RME HDSPM MADI lock fix
Date: Tue, 07 Jun 2011 11:30:28 +0200
Message-ID: <4DEDEFB4.5020603@drcomp.erfurt.thur.de>
References: <4DEB5325.9070903@stackingdwarves.net>	<s5hk4cz1gae.wl%tiwai@suse.de>	<4DEDE273.9060200@stackingdwarves.net>
	<s5hhb8256su.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 47ADD2440B
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 11:30:39 +0200 (CEST)
In-Reply-To: <s5hhb8256su.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, =?UTF-8?B?SsO2cm4gTmV0dGluZ3NtZWllcg==?= <nettings@stackingdwarves.net>
List-Id: alsa-devel@alsa-project.org

On 06/07/2011 11:28 AM, Takashi Iwai wrote:

>>> Well, it's a wrong lock for snd_hdspm_midi_input_available().
>>> So you'll need to lock twice, either once unlock and lock another or
>>> nested.  Re-locking would be less messy in this case, I suppose.
>> ok, here's a revised patch. has been running for 20 or so hours without 
>> problems, although the load was light most of the time.
>>
>> please consider for inclusion.
> 
> Looks good.  But please give a proper changelog and your sign-off
> for inclusion.

I've handled this. I take care of everything, commit (with changelog and
sign-off) to my git repo and will send the final patch series to the
list once it's ready.


Cheers
