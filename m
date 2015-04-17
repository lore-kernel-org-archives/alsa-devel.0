From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: hda - potential (but unlikely) uninitialized
 variable
Date: Fri, 17 Apr 2015 15:46:00 +0300
Message-ID: <20150417124600.GB16501@mwanda>
References: <20150417123514.GA20476@mwanda>
 <s5h383zx6xu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h383zx6xu.wl-tiwai@suse.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, David Henningsson <david.henningsson@canonical.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2015 at 02:42:05PM +0200, Takashi Iwai wrote:
> At Fri, 17 Apr 2015 15:35:15 +0300,
> Dan Carpenter wrote:
> > 
> > This function is a bit unusual because it accepts negative values as
> > "conn_len".  It's theoretically possible for both "cache_len" and
> > "conn_len" to be -ENOSPC and in that case we would oops trying to run
> > memcmp() on the uninitialized "list" pointer.
> 
> Yes, that's a bug.  But the check should be rather:
> 
> 	if (cache_len >= 0 && (cache_len != conn_len ||
> 		    memcmp(list, conn, conn_len) != 0))
> 
> Could you resend with this fix?

Sure.  Will do.

regards,
dan carpenter

