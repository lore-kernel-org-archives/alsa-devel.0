From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Regression in 3.0-git after commit c82693db52beced0419cecf09a3c81adfe95a544
 - sound does not work
Date: Thu, 04 Aug 2011 14:33:33 -0500
Message-ID: <4E3AF40D.5080508@lwfinger.net>
References: <4E39C074.10007@lwfinger.net>	<s5h7h6trc0x.wl%tiwai@suse.de>	<4E3AC3B1.9030400@lwfinger.net>	<s5hliv9oydh.wl%tiwai@suse.de>	<4E3AE2A5.2010100@lwfinger.net> <s5hipqdoudy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hipqdoudy.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: alsa-devel@alsa-project.org

On 08/04/2011 02:21 PM, Takashi Iwai wrote:
> At Thu, 04 Aug 2011 13:19:17 -0500,
> Larry Finger wrote:
>>
>> On 08/04/2011 12:55 PM, Takashi Iwai wrote:
>>>
>>> Thanks.  Through a quick glance at these information, the problem
>>> looks like that both newly appearing "Headphone" and "Speaker" volumes
>>> are set to zero.  Usually alsactl invoked by udev will set appropriate
>>> values for new elements, but in your case, it didn't work by some
>>> reason.
>>>
>>> Try to adjust them.  (Note that you don't have to rebuild the kernel
>>> just for this test; pass model=auto option to snd-hda-intel module,
>>> then it'll switch to that mode.)
>>
>> By adding that option to /etc/modprobe.d/99-local.conf, and removing my patch, I
>> got new controls with the mixer. After fiddling with them a bit, I got working
>> sound. The issue is fixed.
>
> OK, thanks for a quick check!
>
> BTW, are you using systemd or sysvinit?  The culprit might be the
> missing call  of "alsactl init" at the startup, and it depends on the
> start-up system, of course.

I'm using sysvinit with openSUSE 11.4. The plan is to have systemd working with 
oS 12.1, but that is still a work in progress.

Larry
