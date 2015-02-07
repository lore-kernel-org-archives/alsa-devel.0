From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 3/4] ALSA: line6: Pass driver name to line6_probe()
Date: Sat, 7 Feb 2015 10:18:28 -0600
Message-ID: <CAEUsAPbfznW-bb8qj6S=TFsUATF5YOisgR_KrHXqSfUrB_0hkQ@mail.gmail.com>
References: <1423234272-7348-1-git-send-email-chris@rorvick.com>
	<1423234272-7348-4-git-send-email-chris@rorvick.com>
	<s5hfvajw06t.wl-tiwai@suse.de>
	<s5hy4obuf6t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy4obuf6t.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 6, 2015 at 11:23 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 06 Feb 2015 16:04:42 +0100, Takashi Iwai wrote:
>>
>> At Fri,  6 Feb 2015 08:51:11 -0600, Chris Rorvick wrote:
>> >
>> > Provide a descriptive name for each driver instead of calling all of
>> > them "line6usb".
>>
>> This needs to be done carefully.  This string is referred in alsa-lib
>> to pick up the the configuration file.  So, this change shall break
>> the compatibility.
>>
>> If we ever want to pick up a different alsa-lib configuration
>> depending on each line6 driver type, then yes, we should give the
>> individual driver name.  If we want to keep rather the common
>> configuration file (so far there is none, but if any in furture), then
>> we should keep the common driver name.
>>
>> And, the decision must be done now.  From now on, basically we are not
>> allowed to break the user-space compatibility.  That is, this is the
>> very last chance to do it.
>>
>> If your patch is supposed to do it with these consideration, I'm
>> willing to take.  But, I guess it's not, because you chose the string
>> like "Line 6 POD".  This is usually not ideal as a driver name; think
>> of $DRIVER.conf file that is used for alsa-lib configuration.
>>
>> So, from that POV, "line6usb" is no bad name string.  If we want
>> differentiate per driver, a name like "Line6-Pod" or just "Pod" would
>> be more appropriate.
>
> Just to make sure: I'm not against giving own driver name for each
> line6 driver.  I myself think it'd be rather better than the single
> common name for long term.  But, the name string should be more usable
> as a file name, i.e. without space and just two words or so.

OK, thanks for clarifying.  I did not realize this was used to look
for a config file name.  I will resubmit using the /Line6-\w+/
convention.

Regards,

Chris
