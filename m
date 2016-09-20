From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] topology: Add support for included files
Date: Tue, 20 Sep 2016 15:32:13 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F88195AC01@shsmsx102.ccr.corp.intel.com>
References: <cover.1474262798.git.mengdong.lin@linux.intel.com>
 <20160919090906.GF10189@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BA3422666F6
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 17:32:19 +0200 (CEST)
In-Reply-To: <20160919090906.GF10189@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Okay, I will follow the rule.

For this patch, I only want to clarify there is no ABI change and there is nothing else important.

Thanks
Mengdong

-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org] 
Sent: Monday, September 19, 2016 5:09 PM
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org; tiwai@suse.de; liam.r.girdwood@linux.intel.com; Lin, Mengdong <mengdong.lin@intel.com>
Subject: Re: [PATCH] topology: Add support for included files

On Mon, Sep 19, 2016 at 01:34:44PM +0800, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> There is no ABI change in this file, but only an enhancement for 
> topology user space library. It will let a text configuration file 
> include other files, so that some common cofigurations can be shared 
> and we can reduce the total sizes of files.

Please don't send cover letters for single patches, if there is anything that needs saying put it in the changelog of the patch or after the --- if it's administrative stuff.  This reduces mail volume and ensures that any important information is recorded in the changelog rather than being lost. 
