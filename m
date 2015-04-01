From: Be <be.0@gmx.com>
Subject: Re: Rane SL2/3/4 driver?
Date: Tue, 31 Mar 2015 20:42:42 -0500
Message-ID: <551B4D12.8020108@gmx.com>
References: <55112145.8010807@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 49A9E2650E4
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 03:43:23 +0200 (CEST)
Received: from localhost.localdomain ([24.12.142.252]) by mail.gmx.com
 (mrgmx103) with ESMTPSA (Nemesis) id 0M6zvN-1ZQQU12VUb-00wpm2 for
 <alsa-devel@alsa-project.org>; Wed, 01 Apr 2015 03:43:20 +0200
In-Reply-To: <55112145.8010807@gmx.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I recorded USB signals with Wireshark with the Rane SL4 plugged into a
Windows 7 VM. I recorded connecting the device, switching the
passthroughs on/off with the driver's control panel program, flipping
the hardware switches, and playing a track with Mixxx. If anyone is
interested in using this to write a driver, respond off-list and I can
send you the 19 MB archive of the USB signal logs.

On 03/24/2015 03:33 AM, Be wrote:
> Hi, I recently published the first version of Crossfade GNU/Linux, a
> distro for DJing from USB drives on any PC (see
> http://mixxx.org/forums/viewtopic.php?f=1&t=7031 for details). I just
> tried it on my friend's Macbook which he uses with a Rane SL4 USB sound
> card. I realized there is no Linux driver for the current line of sound
> cards sold for digital vinyl emulation with Serato DJ. These are the
> Rane SL2, SL3, and SL4 (http://serato.com/hardware/all/mixers-interfaces
> ; the Denon DS1 was also recently announced but not available yet:
> http://serato.com/latest/blog/17973/announcing-denon-ds1 ). They range
> from 4 in/4 out to 10 in/10 out and all have phono preamps built in.
> There appears to be support for the old and discontinued Rane SL1, which
> used USB 1.1, but the SL2/3/4 use USB 2.0. Has anyone thought about
> writing a driver for these?
