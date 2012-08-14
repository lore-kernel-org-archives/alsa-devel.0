From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH 1/1] ALSA: hda - add a timer to find
 and suspend idle codecs
Date: Tue, 14 Aug 2012 13:55:55 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8170A31@SHSMSX101.ccr.corp.intel.com>
References: <1344967003-5470-1-git-send-email-mengdong.lin@intel.com>
 <502A23AC.1000405@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id DE44D2652BF
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 15:26:23 +0200 (CEST)
In-Reply-To: <502A23AC.1000405@perex.cz>
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I would prefer to create a sysfs file to track the writes rather than using
> this timer hack.

Hi Jaroslav,

I don't want to change the control interface of power saving, for compatibility consideration.

Is it possible that HD-A still uses this "power_save" parameter, but let kernel
send a notification to the driver module? Need to change the generic implementation
of module parameters?


Thanks
Mengdong
