From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH 1/1] ALSA: hda - add a timer to find
 and suspend idle codecs
Date: Tue, 14 Aug 2012 14:35:56 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8170A84@SHSMSX101.ccr.corp.intel.com>
References: <1344967003-5470-1-git-send-email-mengdong.lin@intel.com>
 <s5hfw7pu5ue.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DEF7265EAE
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 16:06:13 +0200 (CEST)
In-Reply-To: <s5hfw7pu5ue.wl%tiwai@suse.de>
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

> Is watching the codec power up/down the only purpose?
> If so, the time for codec power on/off can be already checked in
> /sys/class/sound/hwC*D*/power_{on|off}_acct files.
> These are used by powertop, for example.

Hi Takashi,

My purpose is to enable runtime power management on HD audio. And I hope to base runtime PM on current power saving implementation.

The basic idea is:
For the HD-A controller, runtime PM can be enabled on platforms than can provide acceptable latency on transition from D3 to D0.
When both power saving and runtime PM are enabled by the user, and if all codec are suspended (in D3), the HD-A controller can also enter low-power state by triggering system runtime suspend. And on user operations or HW wakeup event, HD-A controller will be resumed before codecs.

In my test, I found the issue described in my patch. Such idle but unsuspended codecs prevent the controller from entering D3 at runtime. So I need a 
method to detect such idle codecs and suspend them. Even if runtime PM is not enabled, I hope this method can improve current power saving.

Thanks
Mengdong
