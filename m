From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] firewire mixer interface -- was Re:
 [PATCH 11/11] ALSA: digi00x: apply double-oh-three algorism to multiplex
 PCM samples
Date: Sun, 22 Mar 2015 16:26:23 +1030
Message-ID: <20150322055623.GA31970@marvin.atrad.com.au>
References: <550B51BC.80506@sakamocchi.jp> <550C0CFC.4060404@gareus.org>
 <550C1FC6.4050700@sakamocchi.jp> <s5hmw376bck.wl-tiwai@suse.de>
 <550C25DD.3080507@sakamocchi.jp> <s5hfv8z69jz.wl-tiwai@suse.de>
 <550C3294.7020003@sakamocchi.jp> <s5hsicz1znq.wl-tiwai@suse.de>
 <550D08D9.7070509@gmail.com> <550E2F1C.2020009@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id DF3B22604B3
 for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2015 06:56:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <550E2F1C.2020009@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, ffado-devel@lists.sf.net, Damien Zammit <damien.zammit@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 22, 2015 at 11:55:24AM +0900, Takashi Sakamoto wrote:
> On Mar 21 2015 14:59, Damien Zammit wrote:
> > I think it would be a nice feature if it just worked out of the box like
> > any other alsa mixer control, and I'm sure many other people who are
> > currently using FFADO would agree that having everything to control the
> > sound card in ALSA would be more convenient than what they have now.
> 
> Over generalization.
> 
> Actually ALSA middleware cannot represent control interfaces with the
> same level as FFADO achieves, thus your idea can bring no advantages to
> FFADO users.

I've been following this thread but haven't had a chance to respond until
now.  Speaking generally I think Takashi S's comment is a valid
consideration.  While there are some controls on some Firewire audio devices
which could make use of the alsamixer interface, there are other situations
where the alsamixer program and/or API either could not cope or would be
very cumbersome to use.  For these devices having a dedicated mixer-type
application which communicated directly with the audio interface would make
sense.  Mixer controls function independently of the streaming engine in
almost every case, so there is no technical reason why the kernel would need
to be burdened which what could end up being a very large block of code.

I don't see this as a bad thing though.  Complex audio interfaces already
have dedicated mixer applications in alsa-tools.  I don't think the lack of
certain controls via the generic alsamixer hinders the use of these devices.

Regarding device control, there will always be a need to draw a line in the
sand somewhere.  At some point a certain device control becomes secondary to
audio streaming and more to do with signal routing and conditioning in the
device.  The clock source control which Damien mentioned is a case in point. 
Assuming the presence of a clock signal on the selected clock source,
streaming startup doesn't really need to be concerned with the selection of
the clock source.  However, it is clearly related to streaming so it could
be argued that something like this does deserve to be provided with an alsa
API interface of some description - even if it is only for the convenience
of users.  Contrast this to phantom power switches, which have nothing to do
with audio streaming at all.

> It does mean that alsa clients (such as jackd) don't currently provide a
> way to switch clock sources on startup.

Most sound cards don't have multiple clock sources, which is probably the
reason why there is not a standard way to represent such a control via the
alsa API.  That doesn't mean that one couldn't be defined of course, and
doing so would allow clients like jackd to switch clock sources on startup
(something which would be useful for a number of use cases).  The
complicating factor in this is that while many interfaces could represent
the clock source selection as a simple one-of-many selector, some devices
are in reality more complicated than this.  As a result, any generic clock
source selector - if adopted - would have to allow for this to be done in
other ways if needed.

What all this comes down to is that I don't see a problem with the use of
userspace model-specific mixer applications for interfaces which genuinely
need it.  It seems to have worked out fine for envy24control and hdspmixer
for example.  Whether these talk direct to the device or via some alsa API
is probably a device-by-device decision.

If a control/mixer program was required for a given interface I would expect
it to be ultimately included in alsa-tools.  Having the required tools
within the alsa packages would get as close to the "works out the box"
situation as possible.

Regards
  jonathan
