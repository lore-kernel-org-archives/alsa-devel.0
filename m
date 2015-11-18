From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH 0/2] hdmi audio dynamically bind PCM to
 pin
Date: Wed, 18 Nov 2015 14:40:55 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1977BD0E@SHSMSX103.ccr.corp.intel.com>
References: <1447836419-34336-1-git-send-email-libin.yang@linux.intel.com>
 <s5hy4dveeks.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 614302657B4
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 15:41:03 +0100 (CET)
In-Reply-To: <s5hy4dveeks.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, November 18, 2015 7:24 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; mengdong.lin@linux.intel.com; Yang,
> Libin
> Subject: Re: [alsa-devel] [RFC PATCH 0/2] hdmi audio dynamically bind
> PCM to pin
> 
> On Wed, 18 Nov 2015 09:46:57 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > The patches are trying to support dynamically binding PCM to pin in
> HDMI audio.
> >
> > The first patch:
> > When PCM is open when there is no pin (port) bound to the PCM,
> > the driver try to open the PCM successfully. It will try to find
> > an available converter to assign to the PCM.
> > In PCM prepare, if there is no pin bound to the PCM, the driver
> > will do the simple configuration and return true.
> > In PCM close, if there is no pin bound to the PCM, the driver will
> > simply close it.
> > All the pin configuration will be setup in the hotplug which is done
> > in patch 2.
> > As the PCM is dynamically bound to the pin, the pcm_lock is necessary
> > for the whole pcm open/prepare/close process.
> 
> Such a detailed explanation should be put into the patch itself, not
> in the cover letter.  The current description is way too sparse.

OK. I see.

Regards,
Libin
> 
> 
> Takashi
> 
> > The second patch:
> > The patch mainly handle the hotplug event.
> > Each time monitor is connected, a proper PCM will be bound to the pin.
> > If the PCM is in use, the pin must be configured.
> > Each time monitor is disconnect, the PCM will be unbound from the pin.
> > The pin will be reset.
> > Libin Yang (2):
> >   ALSA: hda - hdmi playback without monitor in dynamic pcm bind
> mode
> >   ALSA: hda - hdmi dynamically bind PCM to pin when monitor hotplug
> >
> >  sound/pci/hda/hda_codec.h  |   1 +
> >  sound/pci/hda/patch_hdmi.c | 354
> ++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 337 insertions(+), 18 deletions(-)
> >
> > --
> > 1.9.1
> >
