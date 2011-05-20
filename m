From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Fri, 20 May 2011 14:59:03 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A47E59@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 84FAC10380A
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 23:59:17 +0200 (CEST)
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
> 
> I considered making additional SND_JACK_* constants for HDMI and
> Displayport instead of going with SND_JACK_VIDEOOUT, but it didn't seem
> worth the additions, and breakage of compiling with old kernels, etc.
> Let me know if you think otherwise and I'll prepare a second patch for
> that.

One more thought on this:

Some of our older HW (MCP6x, MCP7x chipsets) doesn't support unsolicited
responses, nor PD/ELDV/ELD data. If PulseAudio is updated to listen to
these new jack events on kernels where the input files are present,
that'll presumably cause it never to allow use of the HDMI sinks on those
chipsets. I don't know if other vendors have this issue or not.

In that case, can we do one of:

* Not create the jack/input files at all.

* Immediately mark the jack as "present".

I assume the latter would be easier for user-space to deal with; it'd be
more in line with the kernel abstracting HW differences.

-- 
nvpublic
