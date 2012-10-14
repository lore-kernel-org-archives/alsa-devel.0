From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: sound/pci/hda/hda_codec.c:1435:46: error:
 'AC_VERB_GET_CON' undeclared
Date: Sun, 14 Oct 2012 10:39:53 +0800
Message-ID: <20121014023953.GA8713@localhost>
References: <20121012170109.GD20312@localhost> <s5h7gquixlv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B5751261793
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2012 04:39:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7gquixlv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 13, 2012 at 10:29:16AM +0200, Takashi Iwai wrote:
> At Sat, 13 Oct 2012 01:01:09 +0800,
> Fengguang Wu wrote:
> > 
> > Hi Takashi,
> > 
> > FYI, kernel build failed on
> > 
> > commit: 645cf3b5656e47fa9a46e2fbc8d212ab572ab05b  Merge branch 'topic/3.8'
> > config: x86_64-allyesdebian (attached as .config)
> > 
> > 
> > All error/warnings:
> > 
> > sound/pci/hda/hda_codec.c: In function 'update_pcm_stream_id':
> > sound/pci/hda/hda_codec.c:1435:46: error: 'AC_VERB_GET_CON' undeclared (first use in this function)
> > sound/pci/hda/hda_codec.c:1435:46: note: each undeclared identifier is reported only once for each function it appears in
> 
> Thanks, this must be already fixed.  It was a temporary merge error.
> (One shouldn't work during updating the system....)

OK. Takashi, Mark, the build system can now avoid testing selected
trees during the merge window. Shall I add your trees to the list?

Thanks,
Fengguang
