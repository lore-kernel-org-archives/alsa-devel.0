From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - codec add DP MST support
	for	connection list
Date: Thu, 17 Mar 2016 06:52:21 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1904682D2E@SHSMSX103.ccr.corp.intel.com>
References: <1458092851-121925-1-git-send-email-libin.yang@linux.intel.com>
 <s5h1t7ax4ce.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19046824FE@SHSMSX103.ccr.corp.intel.com>
 <s5hy49ivotb.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D190468286E@SHSMSX103.ccr.corp.intel.com>
 <s5hfuvqcygd.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19046828A6@SHSMSX103.ccr.corp.intel.com>
 <s5h7fh2cx9w.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19046828C9@SHSMSX103.ccr.corp.intel.com>
 <s5h1t7acwqo.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D1904682AC2@SHSMSX103.ccr.corp.intel.com>
 <s5hshzpvbtq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4618F261564
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 07:52:26 +0100 (CET)
In-Reply-To: <s5hshzpvbtq.wl-tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, March 17, 2016 2:49 PM
> To: Yang, Libin
> Cc: libin.yang@linux.intel.com; alsa-devel@alsa-project.org; Lin,
> Mengdong
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - codec add DP MST support
> for connection list
> 
> On Thu, 17 Mar 2016 02:28:16 +0100,
> Yang, Libin wrote:
> >
> > > Yep.  But, Libin, could you rather focus on the regression Ville
> > > reported shortly ago?
> >
> > Do you mean the issue: New snd-hda warning spew?
> 
> Yes.  Also we have the bugzilla:
>   https://bugs.freedesktop.org/show_bug.cgi?id=94566
> 
> Feel free to join there.  I couldn't reproduce the SKL pm refcount bug
> in my side, so it'd be helpful if you can get more information or
> reproducer.

OK. I will try to reproduce it firstly.

Regards,
Libin

> 
> 
> thanks,
> 
> Takashi
