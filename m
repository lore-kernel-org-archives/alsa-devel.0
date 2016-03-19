From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: snd_hda_core oops with Linux v4.5-6229-gf7813ad5cbfd
Date: Sat, 19 Mar 2016 16:14:44 -0400
Message-ID: <CA+5PVA5CL8j+n9ihs0DA0umj1ahc=vdgcZSsrMtjjjtyuJF+LA@mail.gmail.com>
References: <CA+5PVA4BZzYQ3JNUdhbUK3CO9n_VmZhBT5GV+EYTPGmLwyasOw@mail.gmail.com>
	<s5hshzntpon.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hshzntpon.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2016 at 5:57 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 18 Mar 2016 21:59:51 +0100,
> Josh Boyer wrote:
>>
>> Hi,
>>
>> I have a celeron based NUC that is giving me the following backtraces
>> after Linus merged the sound tree today.  This is with the top of the
>> tree at f7813ad5cbfd as mentioned in the subject.
>>
>> The machine has an HDMI port, but it is not connected to any thing.
>
> It should have been fixed now on my sound.git tree.  Try to pull
> for-linus branch.  I'll send another pull request in early next week.

Yes, the top three commits cleared it up.  Thanks!

josh
