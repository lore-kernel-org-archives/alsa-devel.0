From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: atom: Add sysfs entry in
 order to store FW version
Date: Wed, 9 Nov 2016 15:51:31 +0530
Message-ID: <20161109102131.GQ3000@localhost>
References: <20161104080411.12410-1-sebastien.guiriec@intel.com>
 <20161104080411.12410-3-sebastien.guiriec@intel.com>
 <20161107210241.GP3000@localhost>
 <51eb5a2d-94e0-56d8-817f-eedf632935eb@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 51B9B266569
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 11:12:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <51eb5a2d-94e0-56d8-817f-eedf632935eb@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 08, 2016 at 09:29:15AM +0100, Sebastien Guiriec wrote:
> >we should do this only after FW load, can you add that bit please. ALso
> >check we dont leak kernel memory when this is not set
> >
> 
> Ok in case of v00.00.00.00 I will return "FW not yet Loaded".
> Is it ok for you?

Yes sounds good to me :)

-- 
~Vinod
