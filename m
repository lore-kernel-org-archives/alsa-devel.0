From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH] ASoC: compress: Remove duplicated code
Date: Tue, 8 Aug 2017 00:33:17 +0800
Message-ID: <CAErzpmut8EtMp7RMk1SoHqz=v-DKaHg92g9Y_R6p1s-cO2xaoA@mail.gmail.com>
References: <1502111504-7996-1-git-send-email-pengdonglin137@163.com>
 <CAErzpmsPRYKmu_CMPPXEohjB-dbuqux4v12t5r9-E6dV3sXnMg@mail.gmail.com>
 <20170807150714.e7aecqskfelp7h5z@sirena.org.uk>
 <9bebfae0-5fd2-bb44-18dd-d7c25f59f1b1@linux.intel.com>
 <20170807154253.sfmi6mmt4lj2d44k@sirena.org.uk>
 <1502121554.4828.70.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com
 [209.85.216.174])
 by alsa0.perex.cz (Postfix) with ESMTP id A154E2672A8
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 18:33:19 +0200 (CEST)
Received: by mail-qt0-f174.google.com with SMTP id p3so5734659qtg.2
 for <alsa-devel@alsa-project.org>; Mon, 07 Aug 2017 09:33:19 -0700 (PDT)
In-Reply-To: <1502121554.4828.70.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

ok, I need to think twice.

On Monday, August 7, 2017, Liam Girdwood <liam.r.girdwood@linux.intel.com>
wrote:

> On Mon, 2017-08-07 at 16:42 +0100, Mark Brown wrote:
> > On Mon, Aug 07, 2017 at 10:28:30AM -0500, Pierre-Louis Bossart wrote:
> > > On 8/7/17 10:07 AM, Mark Brown wrote:
> >
> > > > Are you sure that this is the assignment that should be deleted, and
> if
> > > > so why?  Note that it's both conditionally and unconditionally
> assigned
> > > > later on...  Some words in the commit log about why this copy is
> removed
> > > > would be helpful.
> >
> > > Thanks for the report. Yes, the logic escapes me as well, there were
> two
> > > separate changes from Liam and Richard Fitzgerald and I can't figure
> out why
> > > the reassignments of the variable new_name are required.
> >
> > I've got a feeling it was people not working and testing against
> > mainline independently trying to fix similar issues and ending up
> > colliding when things went upstream.
>
> Yeah, probably Richard and I working on something similar in the past.
>
> Liam
>
>
