From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v4 0/5] ALSA: hda - hdmi support dynamic
 pcm assignment
Date: Fri, 18 Dec 2015 02:53:32 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D197B2CAF@SHSMSX103.ccr.corp.intel.com>
References: <1450244565-77041-1-git-send-email-libin.yang@linux.intel.com>
 <s5hbn9qhm2v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FAD626155D
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 03:55:24 +0100 (CET)
In-Reply-To: <s5hbn9qhm2v.wl-tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, December 16, 2015 3:47 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [alsa-devel] [PATCH v4 0/5] ALSA: hda - hdmi support
> dynamic pcm assignment
> 
> On Wed, 16 Dec 2015 06:42:40 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > The patches are trying to support dynamically binding PCM to pin
> > in HDMI/DP audio.
> >
> > The pin will not bind to any PCM if there is not monitor connected.
> > When there is a monitor connected to the port (pin), driver will
> > try to find a proper PCM to assign to the port and setup the pin
> > if necessary.
> >
> > Libin Yang (5):
> >   ALSA: hda - hdmi begin to support dynamic PCM assignment
> >   ALSA: hda - hdmi playback without monitor in dynamic pcm bind
> mode
> >   ALSA: hda - hdmi operate spdif based on pcm
> >   ALSA: hda - hdmi dynamically bind PCM to pin when monitor hotplug
> >   ALSA: hda - hdmi setup pin when monitor hotplug in pcm dynamic
> >     assignment mode
> 
> I updated topic/hda-mst branch with these patches.  But the patch 4
> needs more fixes, as suggested in another mail.
> 
> Overall, I'd like to know whether MST audio really works in the
> current state, or not.  Do you have *any* git branch where MST audio
> is supposed to work at all?

I have uploaded the patches to: https://github.com/libinyang/linux.git
Branch is mst_virtual_pin_github. 

There is still an issue when doing the mst audio playback:
The later converter selection for pin will overwrite the previous setting.
This is the driver bug, I'm debugging it. 

Regards,
Libin

> 
> 
> thanks,
> 
> Takashi
