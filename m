From: Malte Cornils <malte@cornils.net>
Subject: Re: [1/2] 2.6.22-rc5: known regressions
Date: Tue, 19 Jun 2007 01:26:22 +0200
Message-ID: <200706190126.23091.malte@cornils.net>
References: <467543E1.1060001@googlemail.com> <200706181302.42951.malte@cornils.net> <20070618162915.GA7440@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933791AbXFRX0x@vger.kernel.org>
In-Reply-To: <20070618162915.GA7440@kroah.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Rodrigo Luiz <troops.of.doom@gmail.com>, "Darrick J. Wong" <djwong@us.ibm.com>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-pci@atrey.karlin.mff.cuni.cz, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: alsa-devel@alsa-project.org

Hello,

Am Montag, 18. Juni 2007 18:29 schrieb Greg KH:
> On Mon, Jun 18, 2007 at 01:02:42PM +0200, Malte Cornils wrote:
> > Hello,
> > > Subject    : PCI setup hangs on Asus Notebook (nolapic helps)
> > > References : http://lkml.org/lkml/2007/6/14/161
> > > Submitter  : Malte Cornils <malte@cornils.net>
> > > Status     : unknown
> >
> > The original report was made on 2.6.22-rc3, I just checked and it still
> > happens on 2.6.22-rc5.
>
> Can you use 'git bisect' to track down the patch that causes this to
> fail?

I will do this, however, it will likely take me a day or two to find. I'll 
report back then.

-Malte Cornils
