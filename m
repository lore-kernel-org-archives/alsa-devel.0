From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Merging alsa-firmware into linux-firmware
Date: Thu, 22 Jul 2010 14:41:20 +0200
Message-ID: <4C483C70.9010808@canonical.com>
References: <4C457C89.5040209@canonical.com> <4C481865.2010907@canonical.com>
	<s5hsk3bzrsf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id DA6E824422
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 14:41:25 +0200 (CEST)
In-Reply-To: <s5hsk3bzrsf.wl%tiwai@suse.de>
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
Cc: chase.douglas@canonical.com, alsa-devel@alsa-project.org, david.woodhouse@intel.com
List-Id: alsa-devel@alsa-project.org

On 2010-07-22 13:20, Takashi Iwai wrote:
> At Thu, 22 Jul 2010 12:07:33 +0200,
> David Henningsson wrote:
>> usx2yloader however seems to put files outside the /lib/firmware path
>> (/usr/share/alsa/...), and I believe it has a userspace firmware loader
>> triggered by an udev event.
> 
> These are basically for 2.2 / 2.4 kernels.  Don't touch them unless you
> are 100% sure you do right :)

Assuming you mean the tascam usx2yloader, a little digging shows that,

1) the usx2y driver never calls request_firmware (unless I really missed
something)

2) there is an Ubuntu specific patch which creates an udev rule for
calling tascam_fw and tascam_fpga (from alsa-tools) when a tascam device
is connected.

Are you saying that the tascam devices (us122, us224, us428) no longer
need that firmware?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
