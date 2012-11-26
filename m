From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb - Don't create "Speaker" mixer
 controls on headphones and headsets
Date: Mon, 26 Nov 2012 11:06:41 +0100
Message-ID: <50B33F31.8000603@ladisch.de>
References: <1353674935-4215-1-git-send-email-david.henningsson@canonical.com>
 <s5hip8sitzm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id A93C726172E
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 11:06:45 +0100 (CET)
In-Reply-To: <s5hip8sitzm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> David Henningsson wrote:
>> A lot of headsets/headphones have a "Speaker" mixer control. This confuses
>> PulseAudio to think it is a speaker instead of a headphone/headset.
>> Therfore, we rename it to "Headphone".
>>
>> We determine if something is a headphone similar to how udev determines
>> form factor (see 78-sound-card.rules).
>>
>> BugLink: https://bugs.launchpad.net/bugs/1082357
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>  sound/usb/mixer.c |   30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> I tried to find a better way of doing this using the existing quirk or
>> map infrastructure but it didn't seem to fit, so added a new
>> explicit check.
>
> Hrm, indeed it's pretty hackish although it'd work heuristically.

This is for devices that have explicitly marked their output
terminal as speakers, so I don't see any method to make this less
hackish.


Regards,
Clemens
