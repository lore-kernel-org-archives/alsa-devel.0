From: Malte Cornils <malte@cornils.net>
Subject: Re: [1/2] 2.6.22-rc5: known regressions
Date: Wed, 20 Jun 2007 23:49:59 +0200
Message-ID: <200706202350.00235.malte@cornils.net>
References: <467543E1.1060001@googlemail.com> <20070618162915.GA7440@kroah.com> <200706190126.23091.malte@cornils.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <reiserfs-devel-owner@vger.kernel.org>
In-Reply-To: <200706190126.23091.malte@cornils.net>
Content-Disposition: inline
Sender: reiserfs-devel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Rodrigo Luiz <troops.of.doom@gmail.com>, "Darrick J. Wong" <djwong@us.ibm.com>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-pci@atrey.karlin.mff.cuni.cz, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 19. Juni 2007 01:26 schrieb Malte Cornils:
> Hello,
> Am Montag, 18. Juni 2007 18:29 schrieb Greg KH:
> > > > Subject    : PCI setup hangs on Asus Notebook (nolapic helps)
> > > > References : http://lkml.org/lkml/2007/6/14/161
> > > > Submitter  : Malte Cornils <malte@cornils.net>
> > > > Status     : unknown [...]
> >
> > Can you use 'git bisect' to track down the patch that causes this to
> > fail?
>
> I will do this, however, it will likely take me a day or two to find. I'll
> report back then.

Well, more likely a few more days due to difficult physical access to the 
laptop at the moment; however, it's *not* a regression introduced in 
2.6.22rc, it was introduced at some point of time between 2.6.18 and 
2.6.19-rc1.

That means IMHO it's not sensible holding 2.6.22 final waiting for a fix for 
this issue, but I will try to hurry in locating the exact commit anyway.

Yours,
-Malte Cornils
