From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/2] RFC: support for audio wall clock
Date: Fri, 20 Jul 2012 14:47:24 -0500
Message-ID: <5009B5CC.7070106@linux.intel.com>
References: <1340917955-31422-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hpq7tuh9u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E16C726535F
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 21:47:24 +0200 (CEST)
In-Reply-To: <s5hpq7tuh9u.wl%tiwai@suse.de>
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

On 7/18/2012 12:10 PM, Takashi Iwai wrote:
> Sorry for the late reply. I've looked over the things around my 
> vacation... This version looks better, so if other people have no 
> objection, I can merge it. The extension of mmap_status seems still 
> fitting with 64bit char size, so it should be OK. But, one thing -- 
> can't we reuse the normal tstamp field for the audio wallclock? That 
> is, add a new tstamp mode, and then put wallclock tstamp there instead 
> of the normal system tstamp. Just an idea. thanks, Takashi

Thanks for reviewing the updated patches. No, the audio wall clock needs 
to come in addition to the regular system tstamp. This is needed for 
applications such as PulseAudio who try to estimate the drift between 
system time and audio time. If you remove the system time information, 
they can't program a timer any longer.
Better wait a bit to merge, I need to work on all the TODOs, complete 
some additional validation for corner cases and get your feedback live 
at LPC.
-Pierre
