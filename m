From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Date: Wed, 5 Jan 2005 13:34:48 -0800
Message-ID: <20050105133448.59345b04.akpm@osdl.org>
References: <20041215065650.GM27225@wotan.suse.de>
	<20041217014345.GA11926@mellanox.co.il>
	<20050103011113.6f6c8f44.akpm@osdl.org>
	<20050105144043.GB19434@mellanox.co.il>
	<s5hd5wjybt8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262603AbVAEVgU@vger.kernel.org>
In-Reply-To: <s5hd5wjybt8.wl@alsa2.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: mst@mellanox.co.il, ak@suse.de, mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> At Wed, 5 Jan 2005 16:40:43 +0200,
>  Michael S. Tsirkin wrote:
>  > 
>  > Hello, Andrew, all!
>  > 
>  > Since in -mm1 we now have a race-free replacement (that being ioctl_compat),
>  > here is a patch to deprecate (un)register_ioctl32_conversion.
> 
>  Good to see that ioctl_native and ioctl_compat ops are already there!
> 
>  Will it be merged to 2.6.11?

It should be, unless there's some problem.  In maybe a week or so.
