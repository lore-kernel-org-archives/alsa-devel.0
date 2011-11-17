From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: [PATCH 2/2] Improve hw_params documentation
Date: Thu, 17 Nov 2011 08:02:43 -0600
Message-ID: <20111117140243.GK30602@foghorn.codeweavers.com>
References: <20111116195607.GI30602@foghorn.codeweavers.com>
	<4EC42907.80104@ladisch.de>
	<20111116213135.GJ30602@foghorn.codeweavers.com>
	<4EC43465.5060901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 61D2E103A7C
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 15:02:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EC43465.5060901@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Andrew Eikum <aeikum@codeweavers.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2011 at 11:08:37PM +0100, Clemens Ladisch wrote:
> On 11/16/2011 10:31 PM, Andrew Eikum wrote:
> > On Wed, Nov 16, 2011 at 10:20:07PM +0100, Clemens Ladisch wrote:
> >> Andrew Eikum wrote:
> >>> +++ b/include/pcm.h
> >>> @@ -44,8 +44,20 @@ extern "C" {
> >>>
> >>>  /** PCM generic info container */
> >>>  typedef struct _snd_pcm_info snd_pcm_info_t;
> >>> -/** PCM hardware configuration space container */
> >>> +
> >>> +/** PCM hardware configuration space container
> >>> + *
> >>> + *  snd_pcm_hw_params_t is an opaque structure which contains a set of possible
> >>> + *  PCM hardware configurations. For example, a given instance might include a
> >>> + *  range of buffer sizes, a range of period sizes, and a set of several sample
> >>> + *  formats. Some subset of all possible combinations these sets may be valid,
> >>> + *  but not necessarily any combination will be valid.
> >>> + *
> >>> + *  No validation is done by the various snd_pcm_hw_params_set* functions.
> >>
> >> These functions do validate the value that the application is trying to set
> >> and adjust all other dependent limits.
> >
> > I didn't find that to be the case in my testing, at least between
> > periods, period_size, and buffer_size. I've attached a test program
> > here.
> 
> I can reproduce this.
> 
> Try running the program with LIBASOUND_DEBUG=1; it appears that there is
> a bug in the rate plugin.  (Normal programs actually set their rate ...)

This doesn't change the output in any way. I checked the Arch Linux
alsa-lib build script[1] and it doesn't seem to disable debugging in
any obvious way. Do I have to explicitly enable debugging output and
rebuild?

$ LIBASOUND_DEBUG=1 ./alsa_period_count 
min_buffer_frames: 80
set max buffer size: 80
snd_pcm_hw_params: -12
$ 

[1] http://projects.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/alsa-lib

Andrew
