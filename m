From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Tue, 17 May 2011 09:00:51 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04986AAA0D@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 5021D2459A
	for <alsa-devel@alsa-project.org>;
	Tue, 17 May 2011 18:00:57 +0200 (CEST)
In-Reply-To: <4DD27C43.3050509@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote at Tuesday, May 17, 2011 7:47 AM:
> Just as for headphones and microphone jacks, this patch adds reporting
> of HDMI jack status through the input layer.

Interesting. I was asked to look into this, but you beat me to it; thanks!

A couple questions though:

a) Is it possible to report more information alongside the plug events,
such as ELD/EDID content? Or, is the idea that the kernel sends a plug
event, and then user-space retrieves that information via some other
API? I don't think there's an API to retrieve ELD information at present
though right? Although certainly it'd make sense for that to be a 
completely separate patch.

b) We might discuss how to tie ALSA jacks/ports/PCMs to X displays in
some way, so that we can represent to the user which specific active
monitor is the one that supports audio (e.g. in a 2-head setup with both
monitors connected over HDMI, yet only 1 monitor supports audio).

I note that the ELD data contains a port_id field, which might be usable
for this purpose. Could this contain an xrandr value, or an NV-CTRL
(NVIDIA's proprietary control protocol) display ID, or something similar?

-- 
nvpublic
