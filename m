From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ALSA - hda: Add support for link audio
 time reporting
Date: Fri, 15 Jul 2016 11:09:10 +0530
Message-ID: <20160715053910.GN9681@localhost>
References: <1468232009-14130-3-git-send-email-vinod.koul@intel.com>
 <201607111916.R5HdrB76%fengguang.wu@intel.com>
 <20160715043721.GL9681@localhost> <s5hk2gncx6u.wl-tiwai@suse.de>
 <20160715051906.GM9681@localhost> <s5heg6vcwf9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AF9C265873
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 07:31:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5heg6vcwf9.wl-tiwai@suse.de>
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

On Fri, Jul 15, 2016 at 07:17:14AM +0200, Takashi Iwai wrote:
> On Fri, 15 Jul 2016 07:19:06 +0200,
> Vinod Koul wrote:
> > > > > >> sound/pci/hda/hda_controller.c:30:21: fatal error: asm/tsc.h: No such file or directory
> > > > >    compilation terminated.
> > > > 
> > > > Okay i think I need to move this bit into the intel code.
> > > > 
> > > > Takashi, I didnt see any X86 depends on SND_HDA_INTEL. I think we should add
> > > > this now. Are you okay with that?
> > > 
> > > Better to have an explicit ifdef CONFIG_X86 around it.  It's not only
> > > for x86.
> > 
> > Need it around the whole of the timestamp code as well then..
> 
> Yes.  But why TSC is mandatory?  There is no explanation in your
> patch.

HW reports ART values and we need to convert these to TSC.

The callflow is that the azx_get_crosststamp is called which invokes
get_device_system_crosststamp() and calls azx_get_sync_time callback.

So dependency is around convert_art_to_tsc() which is x86 API.

Thanks
-- 
~Vinod
