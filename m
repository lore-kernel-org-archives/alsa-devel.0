From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] crec: Add option to specify codec ID
Date: Fri, 18 Nov 2016 08:39:38 -0600
Message-ID: <fe7dcb27-fda9-47bc-7766-2896e1954218@linux.intel.com>
References: <1479296649-18278-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20161116130508.GZ3000@localhost>
 <1479301675.18450.18.camel@rf-debian.wolfsonmicro.main>
 <20161116134835.GW1575@localhost.localdomain>
 <1479308001.18450.25.camel@rf-debian.wolfsonmicro.main>
 <20161118035333.GG2698@localhost>
 <1479463868.18450.29.camel@rf-debian.wolfsonmicro.main>
 <20161118102903.GS2698@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 80722266DBC
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 15:39:32 +0100 (CET)
In-Reply-To: <20161118102903.GS2698@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> If you're debugging you may not care about the file format, you're
>> actually interested in the raw data you get from the codec so dumping
>> the output to a raw file would be useful even if you can't load that
>> file into a music player.
>
> While I agree with you on this, am worried that adding codecs may make
> people think that we can record mp3 file for exmaple, which is not the case.
>
> I think we can add pcm and bespoke as formats supported and allow any format to
> be dumped to stdio. That way it is pretty clear to people ...

Crec as is it is pretty useless with PCM only...If we added the profile 
selection and things like bitrate information it'd be straightforward to 
support elementary bitstreams like MP3 or AAC ADTS, you just dump the 
data to a file. Things that require a header or MP4 integration would 
require additional libraries, this is no longer 'tiny'.
