From: David Miller <davem@davemloft.net>
Subject: Re: [patch] dbri: move dereference after check for NULL
Date: Tue, 06 Dec 2016 12:19:35 -0500 (EST)
Message-ID: <20161206.121935.749414738010277977.davem@davemloft.net>
References: <20161201054830.GA20077@mwanda>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20161201054830.GA20077@mwanda>
Sender: sparclinux-owner@vger.kernel.org
To: dan.carpenter@oracle.com
Cc: tushar.n.dave@oracle.com, tiwai@suse.com, perex@perex.cz, thomas.tai@oracle.com, alsa-devel@alsa-project.org, sparclinux@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 1 Dec 2016 08:48:30 +0300

> We accidentally introduced a dereference before the NULL check in
> xmit_descs() as part of silencing a GCC warning.
> 
> Fixes: 16f46050e709 ("dbri: Fix compiler warning")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks Dan.
