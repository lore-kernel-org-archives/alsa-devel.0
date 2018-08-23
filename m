From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [ANNOUNCE] 2018 Linux Audio miniconference
Date: Thu, 23 Aug 2018 12:18:06 +0100
Message-ID: <ee7acc7f7754dd76b730874bae413a7f3c9804cc.camel@linux.intel.com>
References: <20180810110656.GE20971@sirena.org.uk>
 <20180816160233.GA5656@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id B03272676D8
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2018 13:18:10 +0200 (CEST)
In-Reply-To: <20180816160233.GA5656@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-08-16 at 17:02 +0100, Mark Brown wrote:
> On Fri, Aug 10, 2018 at 12:06:56PM +0100, Mark Brown wrote:
> 
> 
> > As with previous years let's pull together an agenda through a mailing
> > list discussion - if people could reply to this mail with any topics
> > they'd like to discuss we can take it from there.  Of course if we can
> > sort things out more quickly via the mailing list that's even better!
> 
> Not much discussion yet - one topic I think there's some useful
> discussion to be had about is DSPs, we've got the recent Intel work with
> Sound Open Firmware opening things up there and potentially being able
> to offload work from the userspace sound servers.
> 

I'm also thinking soundwire, AVB (audio over ethernet) and audio virtualisation
as other topics too. 

Fwiw, we should be able to virtualise SOF soon so it would be probably good to
discuss audio virtualisation in general and the pain points for virtualising
audio around latency and reducing buffer copies.

Liam
