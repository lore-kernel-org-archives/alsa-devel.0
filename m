From: "Yang, Libin" <libin.yang@intel.com>
Subject: DP1.2 MST audio support discussion
Date: Tue, 13 Oct 2015 06:25:50 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A078A265497
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 08:25:55 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "tanuk@iki.fi" <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi and all,

We are planning to enable DP1.2 MST (Multi-Stream Transport)
audio.

Based on the previous discussion, we will extend the 
struct hdmi_spec_per_pin to support MST audio device entry. 
So the struct hdmi_spec_per_pin can be a real pin or a device
entry in the pin.  The idea is to add a member dev_idx in the 
struct hdmi_spec_per_pin. Dev_idx, together with pin_nid,
can represent a device entry.

1. Dynamic PCM assignment
We will use dynamic PCM assignment for MST audio. This
means we will create a fixed number of PCMs (the number
is the same convertor number). All the created PCMs will not
be assigned to any pin (device entry). When there is a monitor
connected, an available PCM will be assigned to the pin. And
it will be de-assigned when the monitor is disconnected.
Userspace can fetch the HW param when monitor connection
status is changed.

I'm not sure how to notify the userspace, such as notifying
pulseaudio the PCM is assigned or de-assigned. Any ideas?

2. Compatibility.
We will patch patch_hdmi.c to support the MST audio.
Will we use mst audio driver to support the old mode
or we use a flag, when HW doesn't support MST audio,
we will use the old code? Suppose MST audio driver should
be able support both MST audio and non-MST audio.


Regards,
Libin
