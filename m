From: David Stuart <dave@sipquest.com>
Subject: Re: Quick question
Date: 03 Jun 2003 09:53:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054648393.20856.29.camel@dave.sipquest.com>
References: <1054584080.17509.30.camel@dave.sipquest.com>
	<1054645547.20856.8.camel@dave.sipquest.com>
	<1054646707.539.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1054646707.539.20.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "David E. Storey" <dave@tamos.net>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Ah! I do exist! :)

Perhaps a better description of what I'm trying to do is in order. I
don't know if anyone here is familiar with JMF (java media framework),
but I would like to create an ALSA capture plugin on Linux very similar
to the "direct sound" one that's available on the Windows platform.

When I said that I would like to capture and then playback on TWO
devices, in reality they will probably be always the SAME device (in
full duplex mode). Hopefully that makes the problem easier. This small
test program was my way of getting started.

I realize that JACK is probably the wave of the future in this respect,
but I was thinking of using ALSA because:

1) It's relatively easy to install (from rpms anyway)
2) One does not have to tinker too much with a default RedHat (our
"tested" distro) installation to use ALSA.
3) It has good full-duplex support, as opposed to the default OSS setup.
4) JACK is the future, but not yet the present (seems to me)

Although I admittedly haven't tried JACK yet, I was suspecting that
using ALSA directly would require our customers to do less customization
of their default RedHat installation than installing ALSA + JACK. I need
to keep the procedure simple because we will have to support them.


On Tue, 2003-06-03 at 09:25, David E. Storey wrote:
> Having said that, your question involved using TWO devices, which I
> believe jack doesn't really support unless you're "bonding" them a la
> your .asoundrc file. (and even then, you'd really want to syncronize
> their clocks which most, if not all, consumer products don't support.)
> Assuming you don't care about clock synchronization, you could follow
> the examples at <http://www.suse.de/~mana/alsa090_howto.html>. Just open
> up one device for capture and the other for playback. When you receive
> data from one, pass it to the other.

Hmm .. I did find this HOWTO once before (and a few others), and tried
to follow them, but I must be doing something wrong because I can't get
more than a few pops out of my playback device. I was hoping that
someone could either tell me what I was doing wrong in my program, or
provide a small working example that I could use to learn from..


-- 
David Stuart, SIPQuest
phone: 254-8886 x234 web: http://www.sipquest.com/



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
