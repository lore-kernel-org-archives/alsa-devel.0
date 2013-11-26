From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH] ALSA: hda - suspend codecs in parallel
Date: Tue, 26 Nov 2013 13:39:03 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80141B040@SHSMSX101.ccr.corp.intel.com>
References: <66cb89707dd2109e0cfa2f80561eb25f7bbd686d.1385350212.git.mengdong.lin@intel.com>
 <s5hbo18bvq3.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F8014197F7@SHSMSX101.ccr.corp.intel.com>
 <s5hhaazy8ji.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C342626030E
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 14:39:07 +0100 (CET)
In-Reply-To: <s5hhaazy8ji.wl%tiwai@suse.de>
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
> Sent: Tuesday, November 26, 2013 2:36 PM
> To: Lin, Mengdong

> > > I thought that the recent workqueue is performed asynchronously as
> > > default (unless an ordered workqueue is used), so it should be
> > > enough to have a single workqueue in the bus, and flush it.
> >
> > If using the single work queue in the bus, I observe that the codecs are
> suspended one after one, not in parallel.
> 
> You need to increase the max active of the queue via
> workqueue_set_max_active().  Otherwise it's default to 1 when you
> created via create_workqueue().  Also, it'd be better with WQ_UNBOUND
> flag in this case, I guess.
> 

Thank you! workqueue_set_max_active() works. I use max codec number 15 as the max_active.
But there is no obvious improvement by using WQ_UNBOUND, so it's not used in the 2nd version patch.

Regards
Mengdong
