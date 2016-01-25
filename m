From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH 1/1] alsabat: rename to avoid naming
 conflict
Date: Mon, 25 Jan 2016 10:47:06 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A83D382951@SHSMSX101.ccr.corp.intel.com>
References: <1452567984-18047-1-git-send-email-han.lu@intel.com>
 <s5hpox6wx4a.wl-tiwai@suse.de>	<1452627823.8097.13.camel@loki>
 <s5hk2n3tap1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 239D4260534
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 11:47:10 +0100 (CET)
In-Reply-To: <s5hk2n3tap1.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "joerg.steffens@bareos.com" <joerg.steffens@bareos.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "clemens@ladisch.de" <clemens@ladisch.de>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, January 21, 2016 7:49 PM
> To: Liam Girdwood
> Cc: Lu, Han; clemens@ladisch.de; joerg.steffens@bareos.com; alsa-
> devel@alsa-project.org; Gautier, Bernard
> Subject: Re: [alsa-devel] [PATCH 1/1] alsabat: rename to avoid naming
> conflict
> 
> On Tue, 12 Jan 2016 20:43:43 +0100,
> Liam Girdwood wrote:
> >
> > On Tue, 2016-01-12 at 18:01 +0100, Takashi Iwai wrote:
> > > On Tue, 12 Jan 2016 04:06:24 +0100,
> > > han.lu@intel.com wrote:
> > > >
> > > > From: "Lu, Han" <han.lu@intel.com>
> > > >
> > > > alsa-utils as well as bareos-bat (as well a some Bacula packages)
> > > > all contain a program called /usr/bin/bat, which causes conflicts
> > > > on various distributions ("basic audio tester" vs "bareos
> > > > administration tool"("bacula administration tool")).
> > > > Rename to avoid conflict.
> > >
> > > We should get consensus at first.
> >
> > +1 for alsabat as it should never collide with anything :)
> 
> OK, is there anyone against renaming to alsabat?
> 
> If no one objects, let's take this.
> 

Sorry, I just tried to change the "bin_PROGRAMS" value from "bat" to
"alsabat" but compile failed. The script generates bin and object files
recursively, need to hack in the process:
    bat.c --> bat.o (or alsabat.o) --> alsabat
Is there a decent method to do so? Or simply to rename the subfolder
and c file too, like my patch v1 did?

BR,
Han

> 
> thanks,
> 
> Takashi
