From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] hda_intel: ratelimit "spurious
	response" message
Date: Tue, 19 Nov 2013 00:40:07 -0800
Message-ID: <1384850407.17783.17.camel@joe-AO722>
References: <1383854115.9263.21.camel@joe-AO722>
 <s5h61s4dkqs.wl%tiwai@suse.de> <1383856098.9263.28.camel@joe-AO722>
 <s5hwqkjrwg0.wl%tiwai@suse.de> <1383972094.2860.2.camel@joe-AO722>
 <s5heh6i99kd.wl%tiwai@suse.de> <1384451554.15774.18.camel@joe-AO722>
 <s5ha9h6qhjb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0040.hostedemail.com
 [216.40.44.40]) by alsa0.perex.cz (Postfix) with ESMTP id 38BFA2610B1
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 09:40:11 +0100 (CET)
In-Reply-To: <s5ha9h6qhjb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-11-15 at 07:56 +0100, Takashi Iwai wrote:
> At Thu, 14 Nov 2013 09:52:34 -0800,
> Joe Perches wrote:
> > 
> > > Hrm, the codec proc for the analog audio isn't seen here.
> > > Maybe the codec communication was already screwed up at this point.
> > > 
> > > Can you have a good output by any chance (showing the right contents
> > > of /proc/asound/card1/codec#*)?
> > 
> > Using the linux version I've normally used:
> > 
> > $ cat /proc/version
> > Linux version 3.11.0-031100rc2-generic (apw@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201307211535 SMP Sun Jul 21 19:45:33 UTC 201
> > 
> > $ cat /proc/asound/card1/codec#0 
> > Codec: Realtek ALC271X
> 
> So this codec was detected properly.  Judging from your patch
> description, the verb triggering the stall (0x170500) was about the
> power up to D0 for AFG node.  Did the sound work even after the flood
> of the messages?
> 
> The problem might be also not a stall but a bogus CORB/RIRB pointer.
> Try the first patch, and give the first "spurious response" message.
> Now it shows rp and wp values, and we might see a pattern in them to
> trigger the spurious message (e.g. wp is always same value).
> 
> Also, to be sure, try the second patch, too.  It disables the access
> to some vendor-specific verbs.

Hi again.

I'm not ignoring you.
I've rebuilt the kernel with these patches and
I'm waiting for the messages to show up again.

The only times I've seen them have been after
hibernating and resuming.

I've done several hibernate/restart cycles but
haven't had the messages emitted in the logs yet.

cheers, Joe
