From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH 1/1] alsabat: rename to avoid naming
 conflict
Date: Wed, 13 Jan 2016 01:29:52 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A83D37A1FD@SHSMSX101.ccr.corp.intel.com>
References: <1452567984-18047-1-git-send-email-han.lu@intel.com>
 <s5hpox6wx4a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 897D126048C
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 02:30:15 +0100 (CET)
In-Reply-To: <s5hpox6wx4a.wl-tiwai@suse.de>
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
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Gautier, Bernard" <bernard.gautier@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "clemens@ladisch.de" <clemens@ladisch.de>, "joerg.steffens@bareos.com" <joerg.steffens@bareos.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, January 13, 2016 1:01 AM
> To: Lu, Han
> Cc: liam.r.girdwood@linux.intel.com; Gautier, Bernard;
> joerg.steffens@bareos.com; clemens@ladisch.de; alsa-devel@alsa-
> project.org
> Subject: Re: [alsa-devel] [PATCH 1/1] alsabat: rename to avoid naming
> conflict
> 
> On Tue, 12 Jan 2016 04:06:24 +0100,
> han.lu@intel.com wrote:
> >
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > alsa-utils as well as bareos-bat (as well a some Bacula packages) all
> > contain a program called /usr/bin/bat, which causes conflicts on
> > various distributions ("basic audio tester" vs "bareos administration
> > tool"("bacula administration tool")).
> > Rename to avoid conflict.
> 
> We should get consensus at first.

Sorry, I was just intend to send a patch for review.

> 
> Also, we don't need to rename the directory or the source files in the tree.
> What we need to rename is only the target binary.
> 

OK, that would be easier to make change. Thanks.

BR,
Han Lu

> 
> thanks,
> 
> Takashi
