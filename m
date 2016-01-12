From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/1] alsabat: rename to avoid naming
 conflict
Date: Tue, 12 Jan 2016 19:43:43 +0000
Message-ID: <1452627823.8097.13.camel@loki>
References: <1452567984-18047-1-git-send-email-han.lu@intel.com>
 <s5hpox6wx4a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 73863260508
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 20:43:48 +0100 (CET)
In-Reply-To: <s5hpox6wx4a.wl-tiwai@suse.de>
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
Cc: han.lu@intel.com, clemens@ladisch.de, joerg.steffens@bareos.com, alsa-devel@alsa-project.org, bernard.gautier@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-01-12 at 18:01 +0100, Takashi Iwai wrote:
> On Tue, 12 Jan 2016 04:06:24 +0100,
> han.lu@intel.com wrote:
> > 
> > From: "Lu, Han" <han.lu@intel.com>
> > 
> > alsa-utils as well as bareos-bat (as well a some Bacula packages)
> > all contain a program called /usr/bin/bat, which causes conflicts on
> > various distributions ("basic audio tester" vs "bareos administration
> > tool"("bacula administration tool")).
> > Rename to avoid conflict.
> 
> We should get consensus at first.

+1 for alsabat as it should never collide with anything :)

> 
> Also, we don't need to rename the directory or the source files in the
> tree.  What we need to rename is only the target binary.
> 
> 
> thanks,
> 
> Takashi
