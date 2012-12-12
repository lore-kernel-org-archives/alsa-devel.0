From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA - Replace msleep() with
 usleep_range() to save module loading time
Date: Wed, 12 Dec 2012 02:27:37 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8291D38@SHSMSX101.ccr.corp.intel.com>
References: <1355120432-9840-1-git-send-email-wangxingchao2011@gmail.com>
 <s5h624a9v81.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DD8E261697
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 03:27:42 +0100 (CET)
In-Reply-To: <s5h624a9v81.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, December 10, 2012 4:18 PM


> Actually 1m is chosen as the smallest positive number for msleep, and it
> doesn't mean that we need to wait for 1ms at least.  It could be shorter
> than that if you care about the speed.
> 
> So, I'd  suggest to change the value to a smaller one, and change the
> timeout check instead of counting the loop but a more objective way, e.g.
> checking jiffies, in order to get further reduction.
> 

Hi Takashi,

The 2nd version of patch was sent according to your suggestion. Would you please have a check?
The title is "[PATCH v2 1/1] ALSA: hda - use usleep_range in link reset and change timeout check".

The new patch
- reduced the time for each usleep to 500us 
- set a 100ms timeout for both entering and exiting link reset. 
- still leave a big margin for the codec PLL to settle and codec initialization for safety consideration.


Thanks
Mengdong
