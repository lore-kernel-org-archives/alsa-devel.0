From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 0/3] ucm-conf: Add intel UCM conf files
 to alsa-ucm-conf repo
Date: Wed, 12 Apr 2017 16:26:44 +0100
Message-ID: <1492010804.3482.194.camel@loki>
References: <cover.1490064444.git.fuweix.tang@intel.com>
 <1492008657.3482.184.camel@loki> <s5hziflr7v2.wl-tiwai@suse.de>
 <2b4ff3d8-52f0-ecc1-bd27-70562636fad4@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E9B5266FA9
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 17:26:53 +0200 (CEST)
In-Reply-To: <2b4ff3d8-52f0-ecc1-bd27-70562636fad4@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, mengdong.lin@intel.com, alsa-devel@alsa-project.org, fuweix.tang@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2017-04-12 at 17:10 +0200, Jaroslav Kysela wrote:
> Dne 12.4.2017 v 16:57 Takashi Iwai napsal(a):
> > On Wed, 12 Apr 2017 16:50:57 +0200,
> > Liam Girdwood wrote:
> >>
> >> On Wed, 2017-04-12 at 16:54 +0800, fuweix.tang@intel.com wrote:
> >>> From: Fuwei Tang <fuweix.tang@intel.com>
> >>>
> >>> Add the intel UCM configs to a dedicated UCM conf repo and release them using
> >>> the BSD license.
> >>
> >> We are still missing the LICENSE/COPYING file. We need to add it the top
> >> directory level so it's clear to users. 
> >>
> >>> The other non intel UCM files can be moved over when there is agreement with the
> >>> file authors, but in the mean time they will stay in alsa-lib.
> >>> The configs are moved from alsa-lib repo. The original authorship and commit
> >>> message of all config files will be reserved.
> >>>
> >>
> >> Takashi, how do you want to manage the move ? We could add the files to
> >> the new repo first and then only delete them in alsa-lib after the next
> >> alsa-lib release ? This would give time for distros to pick up the new
> >> conf package. I'm easy on whatever works best here.
> > 
> > We really need a consensus before dealing with such patches.
> > It's just a copy / move of some files to another repo, so a patch is
> > just a waste of bandwidth.
> > 
> > If the only question is about the license, why can't we put another
> > license to UCM profiles in the repo, while keeping LGPL for others as
> > is?  You can declare it in README or maybe better in another text file
> > to explaining about the licenses in the repository.
> > 
> > I'm asking it because, possibly, UCM syntax may be extended in future,
> > and then there is mismatch with UCM profile and parser.  By providing
> > in a single repo, at least, we can avoid the mismatch in the source
> > level.
> > 
> > Other than that, I myself have no objection to factor out to another
> > repo.  But, as previously mentioned, it's rather a request to
> > Jaroslav, who maintains the repositories in alsa-project.org.
> 
> I'm ready to do anything we settle. There's another option - keep ucm
> config files in alsa-lib and publish/mirror them also in the separate
> repository (assuming that there are other frameworks which may use them
> - like on android). And I agree with the point that the UCM files may
> have different licence than other files in alsa-lib, because they are
> not a direct part of the executable binary.
> 

OK, that would be fine with me. Having the mirror would make sense. How
would you propose we work the mirror ?

Fwiw, we are also considering adding a tool that converts UCM to/from
Parameter Framework XML (used on IA Android) and tinyHAL from Cirrus.
This would give us a generic configuration repo that could be deployed
on Android, Chrome and Linux and somewhere that the codec vendors could
send common codec configuration sequences (now that UCM supports C like
include/define concepts).

Thanks

Liam

> 					Jaroslav
> 
