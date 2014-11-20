From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: usb: offset in trigger_tstamp?
Date: Thu, 20 Nov 2014 10:56:29 -0600
Message-ID: <546E1D3D.50500@linux.intel.com>
References: <1416476977-20118-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfwGsn6HbJWH8uE48F2VWAYnAkv8=kGPkqCEWKaBM6=GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DFBC2605CB
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 17:56:38 +0100 (CET)
In-Reply-To: <CAAgF-BfwGsn6HbJWH8uE48F2VWAYnAkv8=kGPkqCEWKaBM6=GQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I was trying to find a bug in the timestamping logic I am working on and after some time I realized the USB audio class driver seems to have an issue.
If I instrument the code in sound/usb/pcm.c, I see a offset of up to 6ms between the  snd_usb_substream_playback_trigger and prepare_playback_urb steps

[45053.102625] trigger_start  
[45053.108320] prepare_playback_urb

My understanding is that empty URBs are submitted in the prepare step to avoid underflows, which is fine. The problem with that is that the trigger_tstamp value is captured before audio transfers actually start and there is a constant offset when trying to track audio/system time drifts or do basic a/v sync.

Any suggestions on how to fix this? I can't figure out if this is an off-by-one error or another bug.
Feedback welcome.
-Pierre
