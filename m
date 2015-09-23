From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] sound: oss: ad1848: Fix returned errno code in
 ad1848_init()
Date: Wed, 23 Sep 2015 11:56:58 +0530
Message-ID: <20150923062658.GE4010@sudip-pc>
References: <1442936257-8988-1-git-send-email-luisbg@osg.samsung.com>
 <20150922164642.GA14353@sudip-pc>
 <5601A7D1.3010008@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5601A7D1.3010008@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luisbg@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 22, 2015 at 08:11:13PM +0100, Luis de Bethencourt wrote:
> On 22/09/15 17:46, Sudip Mukherjee wrote:
> > On Tue, Sep 22, 2015 at 04:37:37PM +0100, Luis de Bethencourt wrote:
> 
<snip>
> Hi Sudip,
> 
> True! I missed that.
> 
> This change will mean the block for 'if (hw_config->slots[0] != -1)' will
> run and it shouldn't.
> 
> In ad1848.c:1998 sound_install_audiodrv() can return -ENOMEM as well, but this
> is turned into -1 also. All errno codes are ignored in sound/oss/pss.c, not
> worth it.
> 
> I'm withdrawing my patch. Sorry for this.
> 
> Is there any other way to silence the smatch warning?
Yes, ad1848_init() is only called from 3 places and everytime the return
is stored in hw_config->slots[0]. So change in all these 3 places and
then slots[0] is being checked in sound_unload_audiodev() and also in
sound/oss/pss.c, so you need to modify those checks also.
But these are all just from a quick grep, if you really want to change
then you need to see the driver carefully for other places that i might
have missed.

regards
sudip
