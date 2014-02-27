From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [TINYCOMPRESS][PATCH 1/1] compress: no need to set
 metadata before	calling next_track
Date: Thu, 27 Feb 2014 10:07:38 -0600
Message-ID: <530F62CA.6080002@linux.intel.com>
References: <20140226142829.GB2002@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A4961265895
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 17:07:43 +0100 (CET)
In-Reply-To: <20140226142829.GB2002@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, vinod.koul@intel.com
Cc: ckeepax@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, elaurent@google.com
List-Id: alsa-devel@alsa-project.org

On 2/26/14 8:29 AM, Richard Fitzgerald wrote:
> The metadata is mainly for MP3 gapless playback, since
> the MP3 audio stream does not contain enough information
> to enable gapless. Other audio formats do not necessarily
> require any additional metadata so we should allow next_track
> to be called without any metadata.

Metadata is required for both MP3 and AAC gapless playback. Can you 
clarify what 'other formats' you are referring to? And rather than 
removing the check that makes sense for these popular formats, why not 
send metadata to set the # of samples to skip to zero?
Thanks,
-Pierre
