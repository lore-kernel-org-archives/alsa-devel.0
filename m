From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Fix inconsistent Mic mute LED
Date: Fri, 31 Jan 2014 18:28:35 +0100
Message-ID: <52EBDD43.1020807@canonical.com>
References: <1391101459-2973-1-git-send-email-tiwai@suse.de>	<52EBD4E7.5060408@canonical.com>
 <s5h38k4qe44.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AC82E264F13
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 18:28:34 +0100 (CET)
In-Reply-To: <s5h38k4qe44.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/31/2014 06:02 PM, Takashi Iwai wrote:
> At Fri, 31 Jan 2014 17:52:55 +0100,
> David Henningsson wrote:
>>
>> On 01/30/2014 06:04 PM, Takashi Iwai wrote:
>>> The current code for controlling mic mute LED in patch_sigmatel.c
>>> blindly assumes that there is a single capture switch.  But, there can
>>> be multiple multiple ones, and each of them flips the state, ended up
>>> in an inconsistent state.
>>>
>>> For fixing this problem, this patch adds kcontrol to be passed to the
>>> hook function so that the callee can check which switch is being
>>> accessed.  In stac_capture_led_hook(), the state is checked as a
>>> bitmask, and turns on the LED when all capture switches are off.
>>
>> Is capture switch with non-zero indices turned off by default (and not
>> turned on by e g alsactl init)? Otherwise it sounds like this could be
>> regressing OOTB behaviour, i e, the mic mute LED worked with
>> people/PulseAudio just toggling Capture Switch 0, but now requires
>> manual toggling of the other capture switches...?
> 
> I thought alsactl init doesn't take all captures on but only the
> first capture.
> 
> I don't mind to change the behavior only to check the first capture,
> and ignore the rest.  Although it sounds a bit inconsistent, it might
> be slightly better aligned to the existing behavior.

>From a security perspective the bitmask would be better. I think we just
need to double check that the Capture Switch 1 and 2 are not enabled by
default (in both kernel code and alsactl init).

>> Anyway, the same reasoning would potentially apply to Conexant and
>> Realtek, so perhaps it's time to move some more of mic mute LED handling
>> into hda_generic?
> 
> The hook itself can be used not only for the LED.  So, filtering the
> action in the generic parser side doesn't fit, IMO.

My thought were more on the lines of moving the bitmask check to the
generic parser, and add a new "toggle_mic_mute_led(bool on)" hook. In
order to minimise the duplication of code between
conexant/sigmatel/realtek codecs.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
