From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Add DeviceID for Haswell HDA
Date: Mon, 16 Jul 2012 10:20:37 +0200
Message-ID: <5003CED5.8080606@canonical.com>
References: <1339554232-3410-1-git-send-email-xingchao.wang@intel.com>
	<s5hr4tjwvxz.wl%tiwai@suse.de> <50005F66.3050401@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 6B5DD24BCB
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2012 10:20:41 +0200 (CEST)
In-Reply-To: <50005F66.3050401@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/13/2012 07:48 PM, Jaroslav Kysela wrote:
> !!Advanced information - PCI Vendor/Device/Subsystem ID's
> !!-------------------------------------------------------
>
> 00:03.0 0403: 8086:0c0c (rev 01)
> 	Subsystem: 8086:2010
> --
> 00:1b.0 0403: 8086:8c20 (rev 01)
> 	Subsystem: 8086:7270
>
>
> Perhaps, we may add also some code to penalize the HDMI only HDA bridges
> and allocate these cards on indexes 1+ by default (implement
> AZX_DCAPS_INDEX1) . Comments? I'll prepare a patch upon an agreement.

While this wouldn't hurt, I don't see much gain from it either. Are 
there really that many applications that hard-code "plughw:0", or what 
is the main reason that you want to switch the order of these two?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
