From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Fri, 20 May 2011 00:45:18 +0200
Message-ID: <4DD59D7E.7040307@canonical.com>
References: <4DD27C43.3050509@canonical.com> <s5hfwod5nz0.wl%tiwai@suse.de>
	<4DD4E909.80108@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A47BE9@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ECFA243FB
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 00:45:24 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A47BE9@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2011-05-19 18:57, Stephen Warren wrote:
> David Henningsson wrote at Thursday, May 19, 2011 3:55 AM:
>> On 2011-05-17 17:46, Takashi Iwai wrote:
>>> At Tue, 17 May 2011 15:46:43 +0200,
>>> David Henningsson wrote:
>>>>
>>>> Just as for headphones and microphone jacks, this patch adds reporting
>>>> of HDMI jack status through the input layer.
>> ...
>>
>> To be honest; it's partially working, or rather it's working in the
>> sense that it follows the eld proc file. It's also working in hda-emu.
>>
>> I've tried it on one Nvidia (with binary drivers), and one Intel
>> Graphics and well, and both seem to have the same problem essentially:
>> There is no hotplug event coming in (through hdmi_unsol_event) when a
>> monitor is removed. But with this patch in perhaps the graphics driver
>> writers will feel more motivated to fix it? :-)
>>
>> Note that the hotplug event is not coming in when you actually plug the
>> cable but when you detect displays and/or apply the monitor
>> configuration change.
>
> That's certainly the expected behavior of our drivers at present.
>
> The ELD data and PD/ELDV bits are only updated when we perform a modeset
> operation, which only happens in response to an explicit user request,
> either with XRandR or through our nvidia-settings application.
>
> I'm not sure if there's a standard that says what our driver's behavior
> should be or not; I could argue that the current behavior makes sense to
> some degree, so that if the user unplugs their monitor then replugs it,
> we don't end up reprogramming all the display hardware. If we did
> disable the HDMI output path when a monitor was unplugged, given that I
> think the idea is that new paths don't get auto-programmed by the X
> driver when a new device is plugged in, but instead wait until XRandR is
> used to configure them, in which case if we'd just turned off all the
> display outputs, how would the user configure the new one without being
> able to see the desktop?
>
> (While this may or may not be ideal, I'm simply pointing this out to
> indicate this behavior doesn't indicate any issue with David's patch)

Ok, thanks. Just to clarify my current problem - if I start 
nvidia-settings, I'll find my current screen through DVI and an extra 
HDMI screen that is disabled. If I choose to enable this screen (by 
clicking Apply on the "X Server Display Information" tab), I get a 
hotplug event through patch_hdmi.c:hdmi_unsol_event, telling me that the 
monitor is now present. So far, that's what's expected.
However, if I then disable that second HDMI screen and click Apply 
again, I *don't* get an hdmi_unsol_event telling me that the monitor is 
now not present. This seems inconsistent to me.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
