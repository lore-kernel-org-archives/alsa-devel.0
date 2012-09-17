From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Dynamic HDMI PCM creation
Date: Mon, 17 Sep 2012 15:28:52 +0200
Message-ID: <50572594.3090900@canonical.com>
References: <s5htxv6rq0e.wl%tiwai@suse.de> <5056F83B.7080602@canonical.com>
 <s5h7grtx78l.wl%tiwai@suse.de> <5057039C.50906@perex.cz>
 <s5hwqzsx476.wl%tiwai@suse.de> <50571596.8000207@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D2BE2616A8
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 15:28:53 +0200 (CEST)
In-Reply-To: <50571596.8000207@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

[added pulseaudio-discuss to cc]

On 09/17/2012 02:20 PM, Jaroslav Kysela wrote:
> Date 17.9.2012 13:46, Takashi Iwai wrote:
>>> I would prefer to have just a notification, if the cable is
>>> connected and the PCM layer is ready (ELD stuff). Also, if some physical
>>> connectors are not used on some hardware, they should/may be blacklisted
>>> so the driver won't create PCM devices for them.

It might be that we could send a snd_ctl_notify on the ELD kcontrol. 
Would that make sense?

>> Using kcontrol notifier is the current solution indeed.  But the whole
>> coding is missing in PA side, so far.  OTOH, PA has already the
>> handling of dynamic PCM device creation/deletion (e.g. for
>> USB-audio).  So, it can be more natural to provide the dynamic PCM
>> from the kernel for HDMI, too.  The patch was posted to evaluate
>> that.
>
> I think that USB-Audio is a different thing. Our driver creates new card
> for a newly plugged USB hardware and it seems that PA supports only
> dynamic card handling, not dynamic device handling.

This is correct. PA supports dynamic cards, not dynamic devices on a 
card. Cards are much simpler because they are always independent of each 
other.

Another question PA needs to deal with is, when this new HDMI PCM device 
is plugged in, what other streams can coexist with this new HDMI stream? 
What if we have an analog + HDMI combined card, but the controller only 
supports one stream to either of them? In that case, we can not even 
probe the HDMI device without disturbing the stream potentially being 
played back through analog.

Brainstorming idea for PA developers: However, if combined analog + HDMI 
combined cards *always* can play back HDMI and analog independent of 
each other, we could actually try to map them as two different cards in 
PulseAudio. Then that HDMI card could disappear as the HDMI cable is 
unplugged.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
