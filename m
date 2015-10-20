From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: BAT: why MAX_NUMBER_OF_CHANNELS and CHANNEL_MAX
	separate?
Date: Tue, 20 Oct 2015 16:41:13 +0100
Message-ID: <1445355673.7033.51.camel@loki>
References: <CAG5mAdz0XcEwqJtCKps+=WBtu5A6SnkCkL889RpXHWhLvF4OjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 08D2F266594
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 17:41:19 +0200 (CEST)
In-Reply-To: <CAG5mAdz0XcEwqJtCKps+=WBtu5A6SnkCkL889RpXHWhLvF4OjA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-10-20 at 08:36 -0700, Caleb Crome wrote:
> Hi,
>    I'm starting to bring up BAT on my board to see if it's going to work for me.
> 
> I'm starting from https://github.com/hanlui/bat, is that the correct
> place to start from?

I think that's Han's old git repo. He has a dev branch here :-

https://github.com/01org/bat

and bat support is now also in alsa-utils git too.

> 
> I'm bringing up a 16 channel board, so need BAT to support more
> channels (currently it supports only 2).
> 
> bat/include/common.h has the following defines:
> 
> #define MAX_NUMBER_OF_CHANNELS          2
> #define CHANNEL_MAX                     2
> #define CHANNEL_MIN                     1
> 
> Is there any reason we need both MAX_NUMBER_OF_CHANNELS and
> CHANNEL_MAX?  They sure seem like they can be merged to me.
> 

Yeah, this looks like it's duplicated to me. Han ?

> Once I get the program up and running, I'll add the ramp test, and
> start thinking about the other tests we talked about.
> 

Ok, thanks !

Liam

> Thanks,
>  -Caleb
