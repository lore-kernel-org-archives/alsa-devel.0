From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
Date: Tue, 25 Jun 2013 06:34:49 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC4890118343CA@SHSMSX104.ccr.corp.intel.com>
References: <1372074324-13563-1-git-send-email-xingchao.wang@linux.intel.com>
 <s5hobavvj4n.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC489011833BCC@SHSMSX104.ccr.corp.intel.com>
 <s5h61x3vfke.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48901183434E@SHSMSX104.ccr.corp.intel.com>
 <s5h8v1y2076.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 04AEA26549D
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 08:34:53 +0200 (CEST)
In-Reply-To: <s5h8v1y2076.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <xingchao.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, June 25, 2013 2:07 PM
> To: Wang, Xingchao
> Cc: alsa-devel@alsa-project.org; Wang Xingchao
> Subject: Re: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
> 
> At Tue, 25 Jun 2013 04:54:05 +0000,
> Wang, Xingchao wrote:
> >
> > Hi Takashi,
> >
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Monday, June 24, 2013 8:50 PM
> > > To: Wang, Xingchao
> > > Cc: alsa-devel@alsa-project.org; Wang Xingchao
> > > Subject: Re: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
> > >
> > > At Mon, 24 Jun 2013 12:19:42 +0000,
> > > Wang, Xingchao wrote:
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > Sent: Monday, June 24, 2013 7:33 PM
> > > > > To: Wang Xingchao
> > > > > Cc: alsa-devel@alsa-project.org; Wang, Xingchao
> > > > > Subject: Re: [PATCH 1/2] ALSA: hdmi - poll eld at resume time
> > > > >
> > > > > At Mon, 24 Jun 2013 07:45:23 -0400, Wang Xingchao wrote:
> > > > > >
> > > > > > Hdmi driver may not receive intrinsic event from gfx side when
> > > > > > it's in runtime suspend mode. There's no ELD info when exit
> > > > > > from runtime suspend. This patch avoid missing ELD info.
> > > > >
> > > > > hda_call_codec_resume() sets the jack detection all dirty, thus
> > > > > each jack detection callback should be called at resume.  Didn't
> > > > > it work as
> > > expected?
> > > >
> > > > I would double check that. In my test, it doesnot work as expected.
> > >
> > > OK, I found the problem.  patch_hdmi.c enables the jack detection
> > > stuff without the callback, so the resume code triggers the check of
> > > jack detection but only updates the kcontrols.
> >
> > You patch did not resolve the issue.
> > I added some debug log, the callback wasnot called at all.
> 
> Even if you unplugged while runtime suspend?

Yes, the controller/codec suspended in runtime already.

> 
> The callback is called only when the plug status (i.e. the jack detection state)
> change is detected at the resume time -- i.e. the state the driver holds differs
> from the state at the resume.
> 

Do you assume jackpoll_interval be non-zero? If so the hda_jackpoll_work will continue to run periodically.
IMO the callback just need be called only once at resume time.

Thanks
--xingchao
