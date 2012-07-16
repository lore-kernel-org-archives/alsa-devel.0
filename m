From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda - Add DeviceID for Haswell HDA
Date: Mon, 16 Jul 2012 10:53:15 +0200
Message-ID: <5003D67B.8080002@perex.cz>
References: <1339554232-3410-1-git-send-email-xingchao.wang@intel.com>
	<s5hr4tjwvxz.wl%tiwai@suse.de> <50005F66.3050401@perex.cz>
	<s5h1ukchze6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id DE0A724BEF
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2012 10:52:12 +0200 (CEST)
In-Reply-To: <s5h1ukchze6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Date 16.7.2012 10:40, Takashi Iwai wrote:
> At Fri, 13 Jul 2012 19:48:22 +0200,
> Jaroslav Kysela wrote:
>>
>>
>> 00:03.0 0403: 8086:0c0c (rev 01)
>> 	Subsystem: 8086:2010
>> --
>> 00:1b.0 0403: 8086:8c20 (rev 01)
>> 	Subsystem: 8086:7270
>>
>>
>> Perhaps, we may add also some code to penalize the HDMI only HDA bridges
>> and allocate these cards on indexes 1+ by default (implement
>> AZX_DCAPS_INDEX1) . Comments? I'll prepare a patch upon an agreement.
> 
> Having index=0 for analog would be nice in general, but I'm afraid
> that it isn't always safe in the case of HD-audio (depending on the
> implementation, though, of course): 
> 
> - BIOS may disable the analog PCI part, e.g. if a device has only
>   HDMI/DP, or vice versa.
> 
> - There are already devices showing the same problem, e.g. AMD
>   on-board with AMD D-GPU, and users may have already added index
>   option for such.
> 
> IMO, we should provide a mechanism to advertise the preferred
> configuration from the driver side without fiddling the index.
> For example, exposing an info bit that this is digital-I/O only card,
> and let alsa-lib choose another one as default (unless explicitly
> specified).

It's not a bad idea, but it would be good to have also "standard"
plughw:0 and hw:0 devices available in the system.

Do you think that the PCI ID / PCI subsystem ID check is not sufficient
to determine the hw type before the codec probe?

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
