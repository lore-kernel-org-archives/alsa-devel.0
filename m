From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Sat, 21 May 2011 08:25:57 +0200
Message-ID: <4DD75AF5.60209@canonical.com>
References: <4DD27C43.3050509@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A47E59@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 5512B244C2
	for <alsa-devel@alsa-project.org>;
	Sat, 21 May 2011 08:26:01 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A47E59@HQMAIL01.nvidia.com>
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

On 2011-05-20 23:59, Stephen Warren wrote:
> David Henningsson wrote at Tuesday, May 17, 2011 7:47 AM:
>> Just as for headphones and microphone jacks, this patch adds reporting
>> of HDMI jack status through the input layer.
>>
>> I considered making additional SND_JACK_* constants for HDMI and
>> Displayport instead of going with SND_JACK_VIDEOOUT, but it didn't seem
>> worth the additions, and breakage of compiling with old kernels, etc.
>> Let me know if you think otherwise and I'll prepare a second patch for
>> that.
>
> One more thought on this:
>
> Some of our older HW (MCP6x, MCP7x chipsets) doesn't support unsolicited
> responses, nor PD/ELDV/ELD data. If PulseAudio is updated to listen to
> these new jack events on kernels where the input files are present,
> that'll presumably cause it never to allow use of the HDMI sinks on those
> chipsets. I don't know if other vendors have this issue or not.
>
> In that case, can we do one of:
>
> * Not create the jack/input files at all.
>
> * Immediately mark the jack as "present".
>
> I assume the latter would be easier for user-space to deal with; it'd be
> more in line with the kernel abstracting HW differences.
>

Ok, thanks for the input (no pun intended ;-) ). If they support 
presence detect, we could create a polling loop. Otherwise, don't create 
the jack.

Is this autodetectable or do we have to quirk it?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
