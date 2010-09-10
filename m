From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] ALSA: usb-audio: Assume first
 control interface is for audio
Date: Fri, 10 Sep 2010 10:06:39 -0700
Message-ID: <20100910170639.GB6193@kroah.com>
References: <1283418795-3319-1-git-send-email-daniel@caiaq.de>
	<s5hfwxsh3ex.wl%tiwai@suse.de>
	<20100910161544.GS7159@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 37DA124533
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 19:12:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100910161544.GS7159@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Greg KH <gregkh@suse.de>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 06:15:44PM +0200, Daniel Mack wrote:
> On Thu, Sep 02, 2010 at 11:59:18AM +0200, Takashi Iwai wrote:
> > At Thu,  2 Sep 2010 17:13:15 +0800,
> > Daniel Mack wrote:
> > > 
> > > For devices with more than one control interface, let's assume the first
> > > one contains the audio controls. Unfortunately, there is no field in any
> > > of the descriptors to tell us whether a control interface is for audio
> > > or MIDI controls, so a better check is not easy to implement.
> > > 
> > > On a composite device with audio and MIDI functions, for example, the
> > > code currently overwrites chip->ctrl_intf, causing operations on the
> > > control interface to fail if they are issued after the device probe.
> > > 
> > > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > 
> > Applied now.  Thanks.
> 
> This went upstream now, thanks. However, I forgot to mention in my
> commit log that we also need this backported to 2.6.35.
> 
> Greg, can you queue it up manually? Upstream commit is 7b6717e.

Yes, I will do so, thanks for letting me know.

greg k-h
