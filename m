From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] compat ioctl security hook fixup
Date: Thu, 20 Jan 2005 21:51:03 -0800
Message-ID: <20050120215103.S24171@build.pdx.osdl.net>
References: <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de> <20050112225230.GA14590@kroah.com> <20050112151049.7473db7d.akpm@osdl.org> <20050119213818.55b14bb0.akpm@osdl.org> <20050121000935.GA341@mellanox.co.il> <20050120172656.R24171@build.pdx.osdl.net> <20050121041959.GA27155@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262272AbVAUF7o@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050121041959.GA27155@wotan.suse.de>; from ak@suse.de on Fri, Jan 21, 2005 at 05:19:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, tiwai@suse.de, mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
List-Id: alsa-devel@alsa-project.org

* Andi Kleen (ak@suse.de) wrote:
> I'm not sure really adding vfs_ioctl is a good idea politically.
> I predict we'll see drivers starting to use it, which will cause quite
> broken design.

Yes, that'd be quite broken.  I didn't have the same expectation.

> If you add it make at least sure it's not EXPORT_SYMBOL()ed.

It's certainly not, nor intended to be.  Would a comment to that
affect alleviate your concern?

thanks,
-chris
