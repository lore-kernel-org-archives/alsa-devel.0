From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [RFC][PATCH] ELD routines and proc interface
Date: Thu, 13 Nov 2008 10:36:52 +0800
Message-ID: <1226543817.892186.26155@de>
References: <20081113022153.GB6844@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 15CC524131
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 03:37:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081113022153.GB6844@mail.ustc.edu.cn>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2008 at 10:21:53AM +0800, Wu Fengguang wrote:
> Create hda_eld.c for ELD routines and proc interface.

Here is a simple example of the proc interface, in which the ELD data
structure has not been populated yet:

# cat /proc/asound/card0/eld\#3
monitor name
connection_type         HDMI
eld_version             0:reserved
edid_version            0:no CEA EDID Timing Extension block present
manufacture_id          0x0
product_id              0x0
port_id                 0x0
support_hdcp            0
support_ai              0
audio_sync_delay        0
speakers
sad_count               0
