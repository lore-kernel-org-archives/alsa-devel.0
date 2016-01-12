From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v2 0/3] ALSA: hda - hdmi jack support for
 dynamic pcm assignment
Date: Tue, 12 Jan 2016 07:10:41 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190464EAC5@SHSMSX103.ccr.corp.intel.com>
References: <1452568407-20771-1-git-send-email-libin.yang@linux.intel.com>
 <s5hvb6znwrw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DFC3A2652EE
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 08:10:46 +0100 (CET)
In-Reply-To: <s5hvb6znwrw.wl-tiwai@suse.de>
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
> Sent: Tuesday, January 12, 2016 2:21 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [alsa-devel] [PATCH v2 0/3] ALSA: hda - hdmi jack support
> for dynamic pcm assignment
> 
> On Tue, 12 Jan 2016 04:13:24 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > The patchset adds hdmi jack support for dynamic pcm assignment
> >
> > Libin Yang (3):
> >   ALSA: Add documentation about HD-audio DP MST
> >   ALSA: hda - add hdmi_pcm to manage hdmi pcm related features
> >   ALSA: hda - hdmi jack created based on pcm
> 
> I merged these three patches to topic/hda-mst branch now.
> But, since the MST audio support itself is still incomplete in i915
> side, I postpone this merge to for-next for 4.5 kernel, at least.
> Let's get it working for 4.6.

Get it. Thanks. And I will initialize a discussion with gfx team
about how to support DP MST audio later.

Regards,
Libin
> 
> 
> thanks,
> 
> Takashi
