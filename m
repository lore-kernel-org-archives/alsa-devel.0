From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] USB-sound: prevent kernel panic on
	disconnect
Date: Thu, 17 Feb 2011 14:52:08 +0100
Message-ID: <4D5D2808.7060206@ladisch.de>
References: <Pine.LNX.4.44L0.1102111737280.13739-100000@netrider.rowland.org>
	<4D58EDA9.2020805@ladisch.de> <s5hoc6ejz2j.wl%tiwai@suse.de>
	<20110216235422.GB6375@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D9BFD103919
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 14:51:22 +0100 (CET)
In-Reply-To: <20110216235422.GB6375@xanatos>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org, bossart.nospam@gmail.com, Alan Stern <stern@rowland.harvard.edu>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Sarah Sharp wrote:
> On Mon, Feb 14, 2011 at 06:39:00PM +0100, Takashi Iwai wrote:
> > Clemens Ladisch wrote:
> > > There seems to be a race between snd_usb_pcm_close() and
> > > snd_usb_stream_disconnect().  I think a mutex taken by both functions
> > > should fix this; and all functions that check 'shutdown' probably need
> > > serializing.
> > 
> > Or, rather make sure that snd_usb_release_substreams() is finished
> > before PCM close; actually it should be called in hw_free callback,
> > but currently it's skipped by the shutdown flag check.  I guess this
> > check isn't right.
> > 
> > The serialization of shutdown check is a good point, but this won't
> > hit actual bugs, I suppose.
> 
> Ok.  I don't have the audio expertise to make a patch; can you or
> Clemens make one for Pierre to try out?

I'll try to make a patch until tomorrow.


Regards,
Clemens
