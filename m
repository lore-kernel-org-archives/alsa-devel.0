From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ALSA - hda: Add support for link audio
 time reporting
Date: Fri, 15 Jul 2016 11:20:25 +0530
Message-ID: <20160715055024.GO9681@localhost>
References: <1468232009-14130-3-git-send-email-vinod.koul@intel.com>
 <201607111916.R5HdrB76%fengguang.wu@intel.com>
 <20160715043721.GL9681@localhost> <s5hk2gncx6u.wl-tiwai@suse.de>
 <20160715051906.GM9681@localhost> <s5heg6vcwf9.wl-tiwai@suse.de>
 <20160715053910.GN9681@localhost> <s5hbn1zcvei.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id AF16E265873
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 07:43:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbn1zcvei.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 15, 2016 at 07:39:17AM +0200, Takashi Iwai wrote:
> > 
> > So dependency is around convert_art_to_tsc() which is x86 API.
> 
> How is defined in the spec?  I wonder it because HD-audio spec itself
> is usually CPU-neutral.

You are right. HDA spec is not x86 specfic. HDA counter report the value
of ART counter for a time snapshot.

The problem is we do not get TSC value from HDA controller :(

So we need to use asm code for conversion..

Thanks
-- 
~Vinod
