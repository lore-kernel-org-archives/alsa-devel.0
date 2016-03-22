From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH 0/6] *** alsabat: clean structure and
 tinyalsa support ***
Date: Tue, 22 Mar 2016 14:31:03 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A83D3ACB34@SHSMSX101.ccr.corp.intel.com>
References: <cover.1458623090.git.han.lu@intel.com>
 <s5hoaa7rmty.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E4C3261536
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 15:31:14 +0100 (CET)
In-Reply-To: <s5hoaa7rmty.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, March 22, 2016 3:31 PM
> To: Lu, Han <han.lu@intel.com>
> Cc: liam.r.girdwood@linux.intel.com; alsa-devel@alsa-project.org
> Subject: Re: [PATCH 0/6] *** alsabat: clean structure and tinyalsa support
> ***
> 
> On Tue, 22 Mar 2016 06:10:23 +0100,
> han.lu@intel.com wrote:
> >
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > 1. Clean structure, use general function to replace local processes.
> 
> Your patches have no description "why" at all, so I don't know why I need to
> merge them, either.  It's one of most important information.
> Please explain why you need the change in each patch description to
> convince readers.

Sorry! I have rewrite all descriptions and cover info. Thanks for comment.

> 
> > 2. Add tinyalsa support, configure will read environment and decide to
> > link to ALSA lib or tinyalsa lib.
> 
> It's not good to choose tinyalsa forcibly whenever it's found.  Then there is
> no way to build alsabat with alsa-lib on a system that have both libraries
> installed.
> 
> Better to add configure option to choose the backend, not only detecting it.
> 

OK. I added configure option "--enable-tinyalsa", and by default tinyalsa is
disabled.
I submitted patch v2 and please help to review.

BR,
Han

> 
> thanks,
> 
> Takashi
> 
> >
> > Lu, Han (6):
> >   alsabat: clean file process on capture thread loop
> >   alsabat: use common wav process function in playback loop
> >   alsabat: clean return value of playback and capture loops
> >   alsabat: use common data generator function
> >   alsabat: move alsa process to alsa.c
> >   alsabat: add tinyalsa support
> >
> >  bat/Makefile.am |  12 +-
> >  bat/alsa.c      | 217 +++++++++++---------------
> >  bat/alsabat.1   |   3 +
> >  bat/bat.c       |  58 +++----
> >  bat/common.c    |  68 +++++++++
> >  bat/common.h    |  17 ++-
> >  bat/signal.c    |  13 +-
> >  bat/tinyalsa.c  | 460
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  bat/tinyalsa.h  |  20 +++
> >  configure.ac    |   4 +
> >  10 files changed, 698 insertions(+), 174 deletions(-)  create mode
> > 100644 bat/tinyalsa.c  create mode 100644 bat/tinyalsa.h
> >
> > --
> > 2.5.0
> >
