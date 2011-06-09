From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Thu, 9 Jun 2011 13:59:24 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04992BFF09@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com> <s5hfwod5nz0.wl%tiwai@suse.de>
	<4DD4E909.80108@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A47BE9@HQMAIL01.nvidia.com>
	<4DD59D7E.7040307@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A47CE7@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 428D22447B
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 22:59:38 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A47CE7@HQMAIL01.nvidia.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Stephen Warren wrote at Thursday, May 19, 2011 4:51 PM:
> David Henningsson wrote at Thursday, May 19, 2011 4:45 PM:
> >...
> > Ok, thanks. Just to clarify my current problem - if I start
> > nvidia-settings, I'll find my current screen through DVI and an extra
> > HDMI screen that is disabled. If I choose to enable this screen (by
> > clicking Apply on the "X Server Display Information" tab), I get a
> > hotplug event through patch_hdmi.c:hdmi_unsol_event, telling me that the
> > monitor is now present. So far, that's what's expected.
> > However, if I then disable that second HDMI screen and click Apply
> > again, I *don't* get an hdmi_unsol_event telling me that the monitor is
> > now not present. This seems inconsistent to me.
> 
> OK, now that's definitely a bug. I'll file one internally.

This should be fixed in the 275.09.04 pre-release driver that we just
released.

-- 
nvpublic
