From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] unregister_ioctl32_conversion and modules. ioctl32 revisited.
Date: Thu, 16 Dec 2004 16:08:11 +0000
Message-ID: <20041216160811.GA9641@infradead.org>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261438AbULPQKT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041217014345.GA11926@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

> +	long (*ioctl_native) (struct inode *, struct file *, unsigned int,
> +			unsigned long);
> +	long (*ioctl_compat) (struct inode *, struct file *, unsigned int,
> +			unsigned long);

Please remove the struct inode * argument, it's easily retrievable
from file->f_dentry->d_inode.  The ioctl prototype is a leftover from
really old days where that wasn't true.
