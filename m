From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA - hda: hdmi flag to stop playback
 when monitor is disconnected
Date: Wed, 11 Nov 2015 14:53:05 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19779E9E@SHSMSX103.ccr.corp.intel.com>
References: <1447231149-88326-1-git-send-email-libin.yang@linux.intel.com>
 <s5h4mgs6h9l.wl-tiwai@suse.de>	<s5hfv0ck4ka.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19779E19@SHSMSX103.ccr.corp.intel.com>
 <s5hbnb0k387.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CF4962604A3
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 15:53:08 +0100 (CET)
In-Reply-To: <s5hbnb0k387.wl-tiwai@suse.de>
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
Cc: "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, November 11, 2015 10:42 PM
> To: Yang, Libin
> Cc: libin.yang@linux.intel.com; David Henningsson; alsa-devel@alsa-
> project.org; mengdong.lin@linux.intel.com
> Subject: Re: [PATCH] ALSA - hda: hdmi flag to stop playback when
> monitor is disconnected
> 
> On Wed, 11 Nov 2015 15:23:42 +0100,
> Yang, Libin wrote:
> >
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Wednesday, November 11, 2015 10:13 PM
> > > To: libin.yang@linux.intel.com
> > > Cc: David Henningsson; alsa-devel@alsa-project.org;
> > > mengdong.lin@linux.intel.com; Yang, Libin
> > > Subject: Re: [PATCH] ALSA - hda: hdmi flag to stop playback when
> > > monitor is disconnected
> > >
> > > On Wed, 11 Nov 2015 10:02:14 +0100,
> > > Takashi Iwai wrote:
> > > >
> > > > On Wed, 11 Nov 2015 09:39:09 +0100,
> > > > libin.yang@linux.intel.com wrote:
> > > > >
> > > > > From: Libin Yang <libin.yang@linux.intel.com>
> > > > >
> > > > > Add a flag that user can decide to stop HDMI/DP playback when
> > > > > the corresponding monitor is disconnected and refuse to open
> PCM
> > > > > if there is no monitor connected.
> > > > >
> > > > > Background:
> > > > > When a monitor is disconnected and a new monitor is connected,
> > > > > the parameters of the 2 monitors may be different. Audio driver
> > > > > need handle this situation.
> > > > >
> > > > > Besides, stopping playback when monitor is disconnected will
> > > > > help to save the power.
> > > > >
> > > > > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > > >
> > > > Thanks.  Below are just nitpicking, so let's test this patch at first,
> > > > especially to see whether it has any significant influence on PA, then
> > > > respin with the fixes.
> > > >
> > > > David, care to check in your side, too?
> > >
> > > So I tested this with PA 7.1, and it failed, unfortunately.
> > > In short:
> > > - PA needs the PCM access at probe.  If it gets an error, the device
> > >   will be never enumerated again
> >
> > Thanks for test.
> >
> > If so, should we re-write the hdmi_pcm_open() and
> > generic_hdmi_playback_pcm_prepare() function to make
> > the probe works? Or not support dynamic pcm assignment?
> >
> > > - PA removes the device when it's disconnected.  The PCM stop with
> > >   DISCONNECT state leads to the device disappearance.
> >
> > If we can't use DISCONNECT, what else can we use? Or we can't
> > stop PCM when monitor is disconnected?
> 
> One obvious options is: we don't care about it.  Maybe care it only
> when really needed, e.g. return an error only in prepare and cleanup,
> but not in open.

Get it. I will refine the patch.

So we will not care the disconnect when playback and
not stop the PCM?

If we don't stop pcm, how to handle connect a different monitor?
It seems userspace must handle such scenario.

Regards,
Libin

> 
> 
> Takashi
