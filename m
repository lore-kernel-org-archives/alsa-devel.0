From: zhejiang <zhe.jiang@intel.com>
Subject: Re: patch for Dell 1210 which using stac9221 codec
Date: Wed, 31 Oct 2007 16:43:20 +0800
Message-ID: <1193820200.3274.9.camel@localhost.localdomain>
References: <1192675756.3701.30.camel@localhost.localdomain>
	<s5hve94zd3a.wl%tiwai@suse.de>
	<1192773763.4306.31.camel@localhost.localdomain>
	<s5hejfrekan.wl%tiwai@suse.de>
	<1192779729.4628.5.camel@localhost.localdomain>
	<s5hk5pjzefs.wl%tiwai@suse.de>
	<1193033299.26715.34.camel@localhost.localdomain>
	<s5hr6jmryaf.wl%tiwai@suse.de>
	<1193298282.3459.18.camel@localhost.localdomain>
	<1193759286.32561.300.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F4252475E
	for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2007 09:43:58 +0100 (CET)
In-Reply-To: <1193759286.32561.300.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> 
> Could you try this patch?  I found an updated pin config on Dell'sweb
> site.  If this works, go ahead and check it in.
> 
> Summary:  Update Dell XPS 1210 Pin Config.
> 
> 
> 
> Signed off by Tobin Davis <tdavis@dsl-only.net>

I don't have the hardware.The bug [0003427] reporter helped me to do
experiment.

The only difference is the usage of the third pin.
That patch uses it as Line-In,but I think it should be Mic-In..

Please see:
http://www.notebookreview.com/assets/12583.jpg


Thanks!
