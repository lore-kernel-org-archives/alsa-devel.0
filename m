From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: HD-audio runtime PM
Date: Tue, 26 Nov 2013 06:56:12 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80141992D@SHSMSX101.ccr.corp.intel.com>
References: <s5hli0gmyxt.wl%tiwai@suse.de>
 <CA+v+29hKbtTBLh=qNRBVqd-NUfXRVBBokoypDh_0RMRQ_VjYvw@mail.gmail.com>
 <s5hiovfy9ji.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BE48260864
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 07:56:17 +0100 (CET)
In-Reply-To: <s5hiovfy9ji.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Wang Xingchao <wangxingchao2011@gmail.com>
Cc: "Alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, November 26, 2013 2:14 PM
> To: Wang Xingchao
 
> > I test WAKEEN feature on Haswell machines before, it could really
> > wakeup system from D3.
> 
> But the runtime suspend doesn't power down to D3 by itself.
> Did you test really with D3?

I will double check this on Haswell with sound git tree for-linus branch.
We've tried Android on Haswell-ULT last week, the display HD-A controller can enter D3 and HDMI cable plug-in can wake up the controller and codec. The code base is v3.9 with various driver patches.

For non-Haswell platforms, hardware team suggest that unless all of the codecs on the HD-A link support EPSS and ClkStopOK, runtime PM of the controller should not be enabled on the controller. Otherwise, functionality will be lost and there are likely going to be audio artifacts.

Thanks
Mengdong

> > The controller must be in RESET mode after enter runtime-suspend,
> > otherwise it will not be waken up even if codec send out wake-up
> > event. And STATESTS will be cleared after controller brought out of
> > RESET mode.
> 
> And I noticed that RESET mode makes some machines inconsistent, e.g.
> the mute LED is reset on HP machines without keeping the previous state.
> I need to double-check whether this still happens with the recent fixes.
