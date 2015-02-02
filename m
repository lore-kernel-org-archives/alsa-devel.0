From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 00/10] audio timestamping evolutions
Date: Mon, 02 Feb 2015 10:11:21 -0600
Message-ID: <54CFA1A9.6020107@linux.intel.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>	<s5hsieofud5.wl-tiwai@suse.de>	<54CF9D43.1030901@linux.intel.com>
 <s5hzj8we1r0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E206F26057F
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 17:11:25 +0100 (CET)
In-Reply-To: <s5hzj8we1r0.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> I will resubmit a new patchset for the coding style and true/false
>> fixes. ETA end of week.
>
> Good to hear.  But what about trigger_tstamp_pending_update?  I prefer
> avoiding the change in a common header structure unless really needed.
>
> OTOH, if any other drivers need the same flag and it's referred in the
> PCM core code *later*, it's fine to add it now.  Just make it clear if
> this is the case.

Yes, this was added as a generic placeholder but it's really only used 
by USB for now. I can make the change local to usb and deal with the 
more generic part later when other devices need it.
