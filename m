From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 4/4] ASoC: Intel: rename
 SND_SST_MFLD_PLATFORM to SND_SST_MID_PLATFORM
Date: Tue, 3 Jan 2017 09:08:16 +0530
Message-ID: <20170103033815.GA3573@localhost>
References: <20170102152017.13938-1-andriy.shevchenko@linux.intel.com>
 <20170102152017.13938-5-andriy.shevchenko@linux.intel.com>
 <c5228e73-d5cf-e4cd-b78b-24334e1fb5f3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 786FD266C9A
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 04:38:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <c5228e73-d5cf-e4cd-b78b-24334e1fb5f3@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 02, 2017 at 10:05:40AM -0600, Pierre-Louis Bossart wrote:
> 
> 
> On 01/02/2017 09:20 AM, Andy Shevchenko wrote:
> >Rename SND_SST_MFLD_PLATFORM to SND_SST_MID_PLATFORM to make it clear that is
> >not only about Medfield platform.
> Does this change make sense? Medfield was a completely different
> platform and lumping everything under the same Kconfig option
> doesn't seem right to me... Plus we've stopped using 'mid' for
> years, no one would know what it stands for. The only clear
> architecture feature is the presence of the switch matrix that
> uniquely identifies all platforms based on Baytrail, Cherrytrail,
> Merrifield and Anniedale. Medfield/Clovertrail did not expose a
> switch matrix.

Mea culpa..

So we started this with medfield and the driver construction is pretty much
the same untill skylake. So clubbing under mfld bucket made sense to me.

MID is not flavour of the season now.

If anyone comes with a better name, am for that :)

-- 
~Vinod
