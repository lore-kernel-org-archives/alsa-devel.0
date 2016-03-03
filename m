From: Giacomo Comes <comes@naic.edu>
Subject: Re: Compute Stick baytrail audio problem
Date: Thu, 3 Mar 2016 00:09:52 -0400
Message-ID: <20160303040952.GA23703@monopoli.naic.edu>
References: <20160219203900.GA5202@monopoli.naic.edu>
 <56C8826A.3030303@linux.intel.com> <56CBCB86.8040601@gmail.com>
 <20160223143443.GA22458@monopoli.naic.edu>
 <56D72205.7020007@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.naic.edu (mailserver.naic.edu [192.65.176.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CF1D26066B
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 05:09:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56D72205.7020007@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Giacomo Comes <comes@naic.edu>, alsa-devel@alsa-project.org, Toyo Abe <toyo.abe@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 02, 2016 at 11:25:25AM -0600, Pierre-Louis Bossart wrote:
> 
> >>After some investigation, I found some problems on the driver and fixed a few of
> >>them. I pushed the fix to my github. I hope it might help you.
> >>   https://raw.githubusercontent.com/toyoabe/baytrailaudio/fix-underrun/hdmi_audio_20150319.patch
> >>
> >>Best Regards,
> >>-toyo
> >
> >Hi,
> >that was it!. I added your changes and now the audio works. I'm happy.
> >I got finally every subsystem of the Compute Stick working.
> 
> If anyone is interested, I ported the code to v4.4, it seems to work
> on the Baytrail Compute stick w/ Ubuntu.
> 
> https://github.com/plbossart/sound/commits/baytrail-stick-rebase-4.4
> 
> Testers welcome, next steps are to add the CherryTrail parts, rebase
> to the drm-nightly-build branch and start talking upstream changes.

I tested your rebased code and it works for me. Actually I haven't
used a 4.4 kernel but a 4.1 (openSUSE 42.1). I made a diff between 
kernel 4.4 and your branch and then applied that diff (with very minor changes)
to the 4.1 openSUSE kernel. No sound issue so far.

Giacomo
