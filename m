From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: hda - Apply codec delay to
	wallclock.
Date: Tue, 09 Apr 2013 20:55:59 -0700
Message-ID: <5164E2CF.2050207@linux.intel.com>
References: <1365470430-22292-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2456C265E94
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 05:56:02 +0200 (CEST)
In-Reply-To: <1365470430-22292-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/8/13 6:20 PM, Dylan Reid wrote:
> For playback add the codec-side delay to the timestamp, for capture
> subtract it.  This brings the timestamps in line with the time that
> was recently added to the delay reporting.
>
> Signed-off-by: Dylan Reid <dgreid@chromium.org>
> ---
> Changes since v1:
> Calculate nsec from frames, subtract delay for playback as well as
> capture.

> +	return (nsec > codec_nsecs) ? nsec - codec_nsecs : 0;

Is this correct? I would think for capture you need to add the delay, 
and subtract it for playback?
-Pierre
