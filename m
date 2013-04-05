From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: hda/ca0132 - Update latency based
 on DSP state.
Date: Fri, 05 Apr 2013 11:28:58 -0500
Message-ID: <515EFBCA.9060101@linux.intel.com>
References: <1365108909-13587-1-git-send-email-dgreid@chromium.org>
 <s5hehep4jt9.wl%tiwai@suse.de> <515EE730.6080705@linux.intel.com>
 <s5h4nfl2ea5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E3A56261728
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 18:29:29 +0200 (CEST)
In-Reply-To: <s5h4nfl2ea5.wl%tiwai@suse.de>
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
Cc: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> I thought that the timestamp and the runtime delay are basically
> independent parameters.  Why must the former be disabled?

In HDA you have DPIB and LPIB. The position in the buffer is reported by 
DPIB and the # of samples rendered is reported by LPIB. The delay is the 
difference between the two when you use the LPIB_DELAY implementation. 
As a result, when you look-up the timestamps and query the delay, what 
you get is the current time as seen by the HDA interface. If you 
increment the runtime delay to add the codec delay, then you must also 
increment by the same amount in azx_get_wallclock_tstamp(). Just 
updating the runtime delay is not enough.
One problem I also have with this approach is that the delay may be 
different if you have multiple streams processed with different 
algorithms, and that isn't exposed here.
-Pierre
