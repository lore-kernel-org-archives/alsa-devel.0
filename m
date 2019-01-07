From: Russell Parker <russell.parker7@gmail.com>
Subject: Re: [PATCH ucm/conf: 0/5] Factor out rt5645 + rt5650
 shared UCM sequences
Date: Mon, 7 Jan 2019 07:42:14 -0800
Message-ID: <20190107154214.GA27439@celes>
References: <20190106034715.21045-1-russell.parker7@gmail.com>
 <ffbdb8ad-9a65-2bbc-4152-7633693b3cde@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id A87C2266885
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 16:43:35 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id u6so315989plm.8
 for <alsa-devel@alsa-project.org>; Mon, 07 Jan 2019 07:43:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ffbdb8ad-9a65-2bbc-4152-7633693b3cde@perex.cz>
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
Cc: louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 07, 2019 at 11:32:48AM +0100, Jaroslav Kysela wrote:
> Dne 6.1.2019 v 04:47 russell.parker7@gmail.com napsal(a):
> > Hi,
> > 
> > When I submitted a patch to create a UCM config for chtrt5650 it was
> > suggested that I also factor out command sequences that it shares with
> > chtrt5645. The following patchset introduces a new component directory
> > codecs/rt5645-common/ and refactors UCM profiles in:
> > 
> > - chtrt5645
> > - chtrt5645-mono-speaker-analog-mic
> > - chtrt5650
> > - ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN
> > - LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216
> > 
> > I compiled and tested playback with the rt5650 configs but I don't
> > have the devices to test the other configurations. Suggestions and feedback
> > are welcome, I'm not very familiar with UCM configuration so there may
> > definitely be better approaches for some of these changes.
> 
> Thanks. I applied your changes to the alsa-lib's repo with only one
> minor modification - I changed rt5645-common directory name to rt5645. I
> don't see the reason to explicitly say that it's common code. All
> configs in the codecs/ tree are common, don't they?

I went with rt5645-common/ because it's common across multiple codecs --
the rt5650 chips are a lower-cost version of the rt5645 so I reused
components from the shared folder for the chtrt5650 conf too. Apparently,
the alc3278 may be similar to the rt5650 as Bossart mentioned in the
earlier thread "Add UCM config for chtrt5650", so if UCM support is
added the same sequences could be potentially used for that too.

Anyway, that was the naming motivation, but I'm not too picky.

Thanks!

- Russell

> 
> 					Jaroslav
> 
> -- 
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
