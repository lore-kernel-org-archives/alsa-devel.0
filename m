From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 0/2] conf/ucm: Remove intel UCM conf files
 from	alsa-lib repo
Date: Mon, 20 Mar 2017 13:50:35 +0000
Message-ID: <1490017835.2549.54.camel@loki>
References: <cover.1487576432.git.fuweix.tang@intel.com>
 <s5hbmsww5ad.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id CC4DE266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 14:50:40 +0100 (CET)
In-Reply-To: <s5hbmsww5ad.wl-tiwai@suse.de>
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
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, fuweix.tang@intel.com
List-Id: alsa-devel@alsa-project.org

Fuwei, I think this is your old patch version as I had similar comments
last week about licence and commit message.

On Mon, 2017-03-20 at 12:34 +0100, Takashi Iwai wrote:
> On Wed, 15 Mar 2017 07:45:38 +0100,
> fuweix.tang@intel.com wrote:
> > 
> > From: Fuwei Tang <fuweix.tang@intel.com>
> > 
> > Remove the intel UCM configs from alsa-lib repo.
> > 
> > Another series will add them to a dedicated UCM conf repo.
> 
> So the intention is to *move* the files to another repo, right?
> Removal is only one of the steps.
> 

Yes, move the Intel files under BSD license as the first step.
Subsequent steps are to then move and hopefully re-license the other UCM
files once author approval had been granted. 

Liam

> > License can be changed to BSD for intel files,
> 
> I couldn't find it in your next patchset.  Where is BSD license
> defined...?
> 
> > and left as "unknown" for other conf files when they are moved from 
> > alsa-lib to the new repo.The alsa-lib LGPL license does not cover runtime configuration files.
> 
> It may cover, but this isn't really intended in our case.  Also we
> have no problem regarding the authorship.
> So my understanding is that it's fine to move to another repo with a
> declaration of a more relaxed license.  But IANAL.
> 
> In anyway, the alsa-project.org site is maintained by Jaroslav, and a
> creation of a new git repo requires his manual action.  I added him to
> Cc now.
> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > Fuwei Tang (2):
> >   conf/ucm: Remove conf files of broxton-rt298 platform
> >   conf/ucm: Remove conf files of skylake-rt286 platfrom
> > 
> >  configure.ac                                  |   2 -
> >  src/conf/ucm/Makefile.am                      |   2 +-
> >  src/conf/ucm/broxton-rt298/Hdmi1              |  22 -----
> >  src/conf/ucm/broxton-rt298/Hdmi2              |  14 ---
> >  src/conf/ucm/broxton-rt298/HiFi               | 129 --------------------------
> >  src/conf/ucm/broxton-rt298/Makefile.am        |   4 -
> >  src/conf/ucm/broxton-rt298/broxton-rt298.conf |  58 ------------
> >  src/conf/ucm/skylake-rt286/Hdmi1              |  20 ----
> >  src/conf/ucm/skylake-rt286/Hdmi2              |  20 ----
> >  src/conf/ucm/skylake-rt286/HiFi               | 129 --------------------------
> >  src/conf/ucm/skylake-rt286/Makefile.am        |   4 -
> >  src/conf/ucm/skylake-rt286/skylake-rt286.conf |  60 ------------
> >  12 files changed, 1 insertion(+), 463 deletions(-)
> >  delete mode 100644 src/conf/ucm/broxton-rt298/Hdmi1
> >  delete mode 100644 src/conf/ucm/broxton-rt298/Hdmi2
> >  delete mode 100644 src/conf/ucm/broxton-rt298/HiFi
> >  delete mode 100644 src/conf/ucm/broxton-rt298/Makefile.am
> >  delete mode 100644 src/conf/ucm/broxton-rt298/broxton-rt298.conf
> >  delete mode 100644 src/conf/ucm/skylake-rt286/Hdmi1
> >  delete mode 100644 src/conf/ucm/skylake-rt286/Hdmi2
> >  delete mode 100644 src/conf/ucm/skylake-rt286/HiFi
> >  delete mode 100644 src/conf/ucm/skylake-rt286/Makefile.am
> >  delete mode 100644 src/conf/ucm/skylake-rt286/skylake-rt286.conf
> > 
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
