From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda - Add DeviceID for Haswell HDA
Date: Mon, 16 Jul 2012 10:49:08 +0200
Message-ID: <5003D584.5080804@perex.cz>
References: <1339554232-3410-1-git-send-email-xingchao.wang@intel.com>
	<s5hr4tjwvxz.wl%tiwai@suse.de> <50005F66.3050401@perex.cz>
	<5003CED5.8080606@canonical.com> <s5hzk70gkr3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 5429824BE6
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2012 10:48:06 +0200 (CEST)
In-Reply-To: <s5hzk70gkr3.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Date 16.7.2012 10:42, Takashi Iwai wrote:
> At Mon, 16 Jul 2012 10:20:37 +0200,
> David Henningsson wrote:
>>
>> On 07/13/2012 07:48 PM, Jaroslav Kysela wrote:
>>> !!Advanced information - PCI Vendor/Device/Subsystem ID's
>>> !!-------------------------------------------------------
>>>
>>> 00:03.0 0403: 8086:0c0c (rev 01)
>>> 	Subsystem: 8086:2010
>>> --
>>> 00:1b.0 0403: 8086:8c20 (rev 01)
>>> 	Subsystem: 8086:7270
>>>
>>>
>>> Perhaps, we may add also some code to penalize the HDMI only HDA bridges
>>> and allocate these cards on indexes 1+ by default (implement
>>> AZX_DCAPS_INDEX1) . Comments? I'll prepare a patch upon an agreement.
>>
>> While this wouldn't hurt, I don't see much gain from it either. Are 
>> there really that many applications that hard-code "plughw:0", or what 
>> is the main reason that you want to switch the order of these two?
> 
> I guess it's about the system without PA or such.
> alsa-lib takes the index 0 for the system-default card unless
> specified by user.  And user wants the analog I/O normally as the
> primary I/O.

Exactly.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
