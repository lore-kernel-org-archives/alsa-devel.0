From: Daniel Jacobowitz <drow@false.org>
Subject: Re: [RFC] [Patch 1/2] Add virtual master control
Date: Fri, 2 May 2008 14:01:54 -0400
Message-ID: <20080502180154.GA13965@caradoc.them.org>
References: <s5hprx12x6x.wl%tiwai@suse.de> <s5hlk7p2wvm.wl%tiwai@suse.de>
	<20080130151909.GA11068@caradoc.them.org>
	<s5hprvj2v1w.wl%tiwai@suse.de>
	<20080321190855.GA24510@caradoc.them.org>
	<s5hiqzf15x8.wl%tiwai@suse.de>
	<20080322153046.GA4439@caradoc.them.org>
	<s5hzlsqzpnq.wl%tiwai@suse.de>
	<20080322191551.GA16147@caradoc.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nan.false.org (NaN.false.org [208.75.86.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 02B012438F
	for <alsa-devel@alsa-project.org>;
	Fri,  2 May 2008 20:01:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080322191551.GA16147@caradoc.them.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 22, 2008 at 03:15:51PM -0400, Daniel Jacobowitz wrote:
> On Sat, Mar 22, 2008 at 05:31:21PM +0100, Takashi Iwai wrote:
> > Thanks.  This kind of change is basically good to apply, I think, but
> > a couple of things related are in my mind:
> > 
> > - other AC97 codecs need similar hacks, so it could be done
> >   cleaner (in a more generic way) than in each patch_*()?
> > - headphone and line-out have the similar issue - it's handled as a
> >   bind-control right now, though
> > - what about if the device actually uses only two channels although
> >   codec supports more than two?  Then the additional master control
> >   makes little sense.  But, we have no way to know it from the codec
> >   itself.  Another quirk table?  That's to be avoided...
> > 
> > Since this is a non-urgent fix and I'll be on vacation for three weeks
> > from tomorrow, I'd like to keep this pending unless other developers
> > want to put this in.  Is it OK?
> 
> Fine with me.  I don't think I can make broader changes than this
> kind, because I don't know much about AC97; maybe there can be a flag
> on recognized codecs saying which channels the front volume really
> controls?
> 
> I noticed that the PCM mixer also only affected my front speakers.

Hi Takashi,

Have you had another chance to look at this?

-- 
Daniel Jacobowitz
CodeSourcery
