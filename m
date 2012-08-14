From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH 1/1] ALSA: hda - add a timer to find
 and suspend idle codecs
Date: Tue, 14 Aug 2012 13:42:36 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8170A20@SHSMSX101.ccr.corp.intel.com>
References: <1344967003-5470-1-git-send-email-mengdong.lin@intel.com>
 <502A22DB.5010503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C3152652BF
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 15:12:54 +0200 (CEST)
In-Reply-To: <502A22DB.5010503@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Adding timers means are you adding wakeups to the CPU. That seems
> counterproductive if you're trying to save power...?
> 
> Is there no way to listen to a change event of some sort instead?
> 

The module parameter "power_save" is used to enable/disable the power saving and set a timeout.
But when its value changes, the driver cannot get a notification.

I hope to reserve the sysfs interface, so I choose to poll the value at a relative long interval.

Thanks
Mengdong
