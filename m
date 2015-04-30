From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v3 0/5] ALSA: hda - remove unnecessary
 controller dependency on i915 gfx power
Date: Thu, 30 Apr 2015 02:07:40 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B845286@SHSMSX101.ccr.corp.intel.com>
References: <cover.1430300071.git.mengdong.lin@intel.com>
 <s5hd22ngrb7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A00522607F7
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 04:07:53 +0200 (CEST)
In-Reply-To: <s5hd22ngrb7.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, April 29, 2015 6:30 PM

> > Mengdong Lin (5):
> >   ALSA: hda - implement a refcount for i915 power well switch
> >   ALSA: hda - allow a codec to control the link power
> >   ALSA: hda - implement link_power ops for i915 display power control
> >   ALSA: hda - divide controller and codec dependency on i915 gfx power
> >     well
> >   ALSA: hda - remove controller dependency on i915 power well for
> >     Baytrail/Braswell
> 
> Applied all patches to topic/hda branch and merged to for-next.

Thank you, Takashi!

When will these patches be available on topic/hda or for-next branch? I've not found them yet.

And I'll try to move the hda-i915 to the sound/hda, and then apply the new power saving to Slylake after more test.

Regards
Mengdong
