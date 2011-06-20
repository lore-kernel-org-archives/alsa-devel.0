From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Jack event API - decision needed
Date: Mon, 20 Jun 2011 20:24:14 +0200
Message-ID: <4DFF904E.3090802@canonical.com>
References: <csg7ltyo2ntnnwkjy445wvqj.1308577935731@email.android.com>	<BANLkTin7K_qO3ejJhOswjSjrLVh0cN2_Wg@mail.gmail.com>
	<s5hoc1s4iu3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 502D624572
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 20:24:20 +0200 (CEST)
In-Reply-To: <s5hoc1s4iu3.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 2011-06-20 17:35, Takashi Iwai wrote:
> At Mon, 20 Jun 2011 16:19:51 +0200,
> Kay Sievers wrote:
>>
>> On Mon, Jun 20, 2011 at 15:56, Mark Brown
>> <broonie@opensource.wolfsonmicro.com>  wrote:
>>> Sorry about the top posting, but as I wasn't involved in any of the discussions and am on a mobile device right now and your mail isn't directly legible it would be enormously helpful if you could summarize the issues you're trying to address, your proposed solution and the problems Kay had.
>>
>> Domain-specific events should not be 'faked' as 'input' devices. No
>> non-input subsystem should do that if it can be avoided. That 'input'
>> supports nice and easy events to userspace should not be a reason to
>> misuse it for pretty much unrelated things.
>>
>> There are patches to have the ALSA control device emit these ALSA
>> related events natively. That's would be just better, simpler and more
>> correct than any additionally created input device.
>>
>> If Takashi can make that possible in a reasonable time frame, we
>> should not even start handling the (currently not handled) input
>> devices in upstream projects like udev and PulseAudio, and focus right
>> away on the native ALSA control events.
>>
>> If we can't have the native ALSA events anytime soon for some reason,
>> we might need to merge the input device support, but I would like to
>> avoid that.
>
> Well, the implementation would be relatively easy.  There was already
> a patch, so not too hard to revisit.
>
> But, there are still some open questions.  For example, what
> information is mandatory and what information is preferred about the
> pin.  HD-audio provides the location, type, color, etc.  We can encode
> these into a single name string, but is it a preferred way?

I was thinking the same thing. We don't want another parser as we now 
have for the volume control names in Pulseaudio. [1] Better encode the 
information in binary.

> Alternatively, the control element can provide the HD-audio pin config
> via an extra TLV data, so that apps can refer to it if needed in
> addition to the name string.
>
> Also, we may consider some way to expose the corelation of the jack
> control element and other mixer elements.  Though, this sounds
> optional to me for the time being.

I think this correlation is what I'm missing the most, I think. We need 
e g, a way to figure out that if you plugged something into HDMI port nr 
2, we should output through PCM device 2 on that card. Exposing what 
mixers affect this port is highly desirable as well to get more accurate 
than the current name-based algorithm Pulseaudio currently uses.

For the jack itself, the most important info would be
1) Type (Headphone / Line-out / etc)
2) Channel allocation (Front / Side / LFE / etc)
3) Location (Rear / Docking station / and can also be Front, just to add 
to the confusion)

> These questions are basically requirements from the apps; so I'd like
> to know the exact demands before going to implementation.

Hopefully this mail gives a little more insight from the Pulseaudio 
viewport at least.

Should we design something new, I think we should start with a pin/port 
concept rather than a jack concept. "Internal speaker" would then be a 
port that does not have a jack, whereas "Headphone" would be a port that 
has a jack.

(Btw, I don't know much about DAPM and how well that scales to cope with 
these requirements, it looks very ASoC to me, but perhaps it's just the 
SND_SOC_DAPM_* naming that fools me. But can DAPM e g send events to 
userspace?)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] It becomes even worse when some things such as "I control headphones 
and line-out but not internal speaker" cannot be expressed with a name, 
at least there is no current standard for doing so. :-(
