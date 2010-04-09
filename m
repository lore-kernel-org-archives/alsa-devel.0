From: Tvrtko Ursulin <tvrtko@ursulin.net>
Subject: Re: Ooops when working with USB MIDI (2.6.33.1)
Date: Fri, 9 Apr 2010 18:36:50 +0100
Message-ID: <201004091836.51023.tvrtko@ursulin.net>
References: <201004051433.47171.tvrtko@ursulin.net> <201004090751.35398.tvrtko@ursulin.net> <s5hfx35ccde.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hfx35ccde.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Friday 09 Apr 2010 08:29:33 Takashi Iwai wrote:
> At Fri, 9 Apr 2010 07:51:35 +0100,
> 
> Tvrtko Ursulin wrote:
> > On Thursday 08 Apr 2010 13:22:36 Takashi Iwai wrote:
> > > > Takashi, do you remember what the original problem was?
> > >
> > > Well, I have only a vague memory -- it's a similar scenario that some
> > > app still accessing after disconnection.  The URB can't be handled
> > > after the disconnection is finished.
> > >
> > > I think the patch below might fix in this case.  You can try it
> > > instead of reverting the commit above.

A very quick test and it looks good  - did not crash in the disconnect and 
then exit TuxGuitar scenario. Thank you!

Tvrtko
