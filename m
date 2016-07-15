From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ALSA - hda: Add support for link audio
 time reporting
Date: Fri, 15 Jul 2016 10:49:06 +0530
Message-ID: <20160715051906.GM9681@localhost>
References: <1468232009-14130-3-git-send-email-vinod.koul@intel.com>
 <201607111916.R5HdrB76%fengguang.wu@intel.com>
 <20160715043721.GL9681@localhost> <s5hk2gncx6u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E80A12659D7
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 07:11:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk2gncx6u.wl-tiwai@suse.de>
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

On Fri, Jul 15, 2016 at 07:00:41AM +0200, Takashi Iwai wrote:
> On Fri, 15 Jul 2016 06:37:21 +0200,
> Vinod Koul wrote:
> > 
> > On Mon, Jul 11, 2016 at 07:43:25PM +0800, kbuild test robot wrote:
> > > Hi,
> > > 
> > > [auto build test ERROR on sound/for-next]
> > > [also build test ERROR on v4.7-rc7 next-20160711]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Vinod-Koul/ALSA-hda-Add-support-for-link-audio-time-reporting/20160711-180949
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
> > > config: arm-multi_v7_defconfig (attached as .config)
> > > compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
> > > reproduce:
> > >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # save the attached .config to linux build tree
> > >         make.cross ARCH=arm 
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> sound/pci/hda/hda_controller.c:30:21: fatal error: asm/tsc.h: No such file or directory
> > >    compilation terminated.
> > 
> > Okay i think I need to move this bit into the intel code.
> > 
> > Takashi, I didnt see any X86 depends on SND_HDA_INTEL. I think we should add
> > this now. Are you okay with that?
> 
> Better to have an explicit ifdef CONFIG_X86 around it.  It's not only
> for x86.

Need it around the whole of the timestamp code as well then..

Yes the HDA controller is not x86 specfic, but the hda-intel should be,
right? This would make me move all this code into hda_intel.c as well..

-- 
~Vinod
