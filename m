From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] compat ioctl security hook fixup
Date: Fri, 21 Jan 2005 07:11:19 +0100
Message-ID: <20050121061119.GA657@wotan.suse.de>
References: <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de> <20050112225230.GA14590@kroah.com> <20050112151049.7473db7d.akpm@osdl.org> <20050119213818.55b14bb0.akpm@osdl.org> <20050121000935.GA341@mellanox.co.il> <20050120172656.R24171@build.pdx.osdl.net> <20050121041959.GA27155@wotan.suse.de> <20050120215103.S24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262278AbVAUGLd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050120215103.S24171@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@osdl.org>
Cc: Andi Kleen <ak@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, tiwai@suse.de, mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 20, 2005 at 09:51:03PM -0800, Chris Wright wrote:
> > If you add it make at least sure it's not EXPORT_SYMBOL()ed.
> 
> It's certainly not, nor intended to be.  Would a comment to that
> affect alleviate your concern?

Yes please.

-Andi
