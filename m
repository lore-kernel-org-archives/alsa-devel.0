From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Compressed Audio Playback/Capture through ALSA
	framework
Date: Fri, 18 Mar 2011 10:22:21 +0800
Message-ID: <AANLkTinSujxxxWEqFe-xZR==R7=hadbv+sKebzE_YmJz@mail.gmail.com>
References: <4D7FB076.30300@codeaurora.org>
	<20110316103814.GA8369@sirena.org.uk>
	<1300273162.9428.10.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A6A41037F5
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 03:22:23 +0100 (CET)
Received: by fxm6 with SMTP id 6so3161720fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 19:22:22 -0700 (PDT)
In-Reply-To: <1300273162.9428.10.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/3/16 Koul, Vinod <vinod.koul@intel.com>

> On Wed, 2011-03-16 at 16:08 +0530, Mark Brown wrote:
> > On Tue, Mar 15, 2011 at 11:31:18AM -0700, Patrick Lai wrote:
> >
> > > Is there a precedent for playback/capture compressed audio stream
> > > through ALSA playback/capture interface if underlying hardware supports
> > > decoder + sink & encoder + source capabilities?
> >
> > I'm not sure if ALSA is the best API to use for this - the ALSA APIs are
> > strongly oriented around data where the size is consistent in time while
> > most compressed audio formats don't do that.  There's also existing APIs
> > in userspace like gstreamer and the various OpenMAXish things to slot in
> > with, everything below those is usually black boxed per implementation.
> I would agree with Mark, our best approach would be to do a clean design
> of a new API set which takes care of both CBR, VBR and be generic enough
> for any format.
>

For software decode, the application can start , pause and stop at any PCM
frames

Does the hardware decoder has any limitation on the compressed stream ?
