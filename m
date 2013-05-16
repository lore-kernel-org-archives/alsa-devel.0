From: David Henningsson <david.henningsson@canonical.com>
Subject: Haswell: Ensuring HDA codec pins refer to physical
	outputs
Date: Thu, 16 May 2013 09:00:06 +0200
Message-ID: <519483F6.9060308@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A59662619E6
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 09:00:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Jesse Barnes <jesse.barnes@intel.com>, "Zanoni, Paulo R" <paulo.r.zanoni@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I want to take this problem up again, because it's important we get this 
right.

The HDA driver assumes that a codec pin widget node always refers to the 
same physical output. With Haswell, it seems like this is not guaranteed 
to be true. I would like to see this fixed on the graphics side. If not, 
I don't know how to work around it on the audio side.

The problems that occur on the audio side are:

  1) Some BIOSes set default pin config. E g, if the machine has a 
single HDMI out, it can set two of the codec pins to "not connected" and 
let the third remain "jack". As a result, the HDA driver will ignore the 
two codec pins and only enable the third. As such, HDMI audio will not 
work correctly, unless it's the third codec pin that is connected to the 
physical output.

  2) Saving and restoring mutes, volumes etc is done on a per-pin basis. 
E g, imagine that a user has a dual monitor setup and always wants audio 
output from the left side monitor, and keep the right side monitor 
silent. If it is not reliable which codec pin refers to which physical 
output, one day suddenly the sound might come out on the right side 
monitor instead.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
