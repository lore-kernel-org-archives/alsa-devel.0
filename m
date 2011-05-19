From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Thu, 19 May 2011 09:57:51 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A47BE9@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com> <s5hfwod5nz0.wl%tiwai@suse.de>
	<4DD4E909.80108@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D4AF10386A
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 18:58:00 +0200 (CEST)
In-Reply-To: <4DD4E909.80108@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote at Thursday, May 19, 2011 3:55 AM:
> On 2011-05-17 17:46, Takashi Iwai wrote:
> > At Tue, 17 May 2011 15:46:43 +0200,
> > David Henningsson wrote:
> >>
> >> Just as for headphones and microphone jacks, this patch adds reporting
> >> of HDMI jack status through the input layer.
>...
> 
> To be honest; it's partially working, or rather it's working in the
> sense that it follows the eld proc file. It's also working in hda-emu.
> 
> I've tried it on one Nvidia (with binary drivers), and one Intel
> Graphics and well, and both seem to have the same problem essentially:
> There is no hotplug event coming in (through hdmi_unsol_event) when a
> monitor is removed. But with this patch in perhaps the graphics driver
> writers will feel more motivated to fix it? :-)
> 
> Note that the hotplug event is not coming in when you actually plug the
> cable but when you detect displays and/or apply the monitor
> configuration change.

That's certainly the expected behavior of our drivers at present.

The ELD data and PD/ELDV bits are only updated when we perform a modeset
operation, which only happens in response to an explicit user request,
either with XRandR or through our nvidia-settings application.

I'm not sure if there's a standard that says what our driver's behavior
should be or not; I could argue that the current behavior makes sense to
some degree, so that if the user unplugs their monitor then replugs it,
we don't end up reprogramming all the display hardware. If we did
disable the HDMI output path when a monitor was unplugged, given that I
think the idea is that new paths don't get auto-programmed by the X
driver when a new device is plugged in, but instead wait until XRandR is
used to configure them, in which case if we'd just turned off all the
display outputs, how would the user configure the new one without being
able to see the desktop?

(While this may or may not be ideal, I'm simply pointing this out to
indicate this behavior doesn't indicate any issue with David's patch)

-- 
nvpublic
