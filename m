From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH lib 0/5] alsa-lib topology trivial fixes
Date: Wed, 09 Sep 2015 11:33:04 +0100
Message-ID: <1441794784.2439.47.camel@loki>
References: <1441743701-28165-1-git-send-email-tiwai@suse.de>
 <1441793337.2439.42.camel@loki> <s5hzj0vdhdz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FC24260418
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 12:33:08 +0200 (CEST)
In-Reply-To: <s5hzj0vdhdz.wl-tiwai@suse.de>
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
Cc: Mengdong Lin <mengdong.lin@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-09-09 at 12:19 +0200, Takashi Iwai wrote:
> On Wed, 09 Sep 2015 12:08:57 +0200,
> Liam Girdwood wrote:
> > 
> > On Tue, 2015-09-08 at 22:21 +0200, Takashi Iwai wrote:
> > > Hi,
> > > 
> > > here is a series of trivial fixes that have been spotted by gcc
> > > warnings.
> > > 
> > 
> > Thanks, Takashi. Dont know why we missed these.
> 
> I seem to have forgotten to push to git tree.  Now there.

Oh, I didn't see any warnings before you pushed

make[2]: Entering directory '/home/lrg/source/alsa-lib/src/topology'
  CC       parser.lo
  CC       builder.lo
  CC       ctl.lo
  CC       dapm.lo
  CC       pcm.lo
  CC       data.lo
  CC       text.lo
  CC       channel.lo
  CC       ops.lo
  CC       elem.lo
  CCLD     libtopology.la
make[2]: Leaving directory '/home/lrg/source/alsa-lib/src/topology'

Could be our configure settings for some gcc flags are different ?

Liam
