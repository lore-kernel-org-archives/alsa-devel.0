From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Creative Lab's Extigy
Date: Fri, 13 Sep 2002 10:38:25 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209131007120.11125-100000@studcom.urz.uni-halle.de>
References: <20020912172659.GA20084@undertone.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20020912172659.GA20084@undertone.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php=alsa-devel>
To: mark@undertone.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

mark@undertone.org wrote:
> While I appreciate the tremendous work done with the USB audio
> support, I'm just not getting access to the featureset I want on my
> extigy (external USB audigy card from cl).

What features are missing?

> I admit I do not have much experience writing device drivers. However,
> I'd like to believe myself to be technically competant enough with the
> linux kernel to begin doing so. What I'm looking for here are a few
> pointers and tips for where to start, what code to stare at for a
> while, etc. The ALSA documentation is pretty good as is, but I think
> I'd need a little more than that as far as driver development goes.

The current state of ALSA driver development documentation is "Use the
source, Luke!"  Especially, there's alsa-kernel/drivers/dummy.c as an
example driver.

I'd suggest to read about generic Linux driver development. There's much
useful information in the Documentation/ directory of the kernel, and
there's <http://www.oreilly.com/catalog/linuxdrive2/chapter/book/>.

For a USB audio driver, you have to read (and understand :) the relevant
parts from the USB specification <http://www.usb.org/developers/docs.html>
and from the Audio Class specifications
<http://www.usb.org/developers/devclass_docs.html>. If your brain is still
working after that :-) , read the files in alsa-kernel/usb/.

> Is it fiesable? Would a driver need to be written from scratch? Could
> I just hook some extentions into the present usb-audio driver?

If the missing features are something already implemented in the ALSA
driver but not describes by the USB descriptors, it would be possible to
extend the quirk mechanism of the driver (currently, it's used for some
USB MIDI devices). <http://www.cs.umass.edu/~cochran/> mentions the MIDI
and IR parts of the Extigy have this problem.

> Does Creative Labs even release enough info/specs to write a decent
> driver?

I didn't find any on their opensource website. I'd guess you'd have to
sign an NDA.


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
