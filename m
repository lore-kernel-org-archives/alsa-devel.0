From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: pcm: fix error handling when
 try_module_get() fails.
Date: Wed, 10 Apr 2019 07:30:14 -0700
Message-ID: <79e2b317de7a64a0f7da6d0a9c9e37096fa2ebca.camel@linux.intel.com>
References: <20190408193025.22639-1-ranjani.sridharan@linux.intel.com>
 <20190410095010.GD6106@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB27AF80765
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 16:30:20 +0200 (CEST)
In-Reply-To: <20190410095010.GD6106@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-04-10 at 10:50 +0100, Mark Brown wrote:
> On Mon, Apr 08, 2019 at 12:30:25PM -0700, Ranjani Sridharan wrote:
> > Handle error before returning when try_module_get() fails
> > to prevent inconsistent mutex lock/unlock.
> > 
> > Fixes: 52034add7 (ASoC: pcm: update module refcount if
> > 		  module_get_upon_open is set)
> > 
> > Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
> > >
> 
> You keep on adding blank lines after your Fixes: lines for some
> reason,
> this is unusual and will probably confuse some tooling.
Sorry about that. Will send v2 without the line.
Thanks,
Ranjani
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
