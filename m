From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] USB MIDI bugs
Date: Tue, 12 Nov 2002 10:55:51 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211121048340.5862-100000@studcom.urz.uni-halle.de>
References: <1037064272.7799.157.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1037064272.7799.157.camel@cmn37.Stanford.EDU>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Fernando Pablo Lopez-Lezcano wrote:
> > Thanks! sequencer input is now working on Muse (both 0.5 and 0.6
> > versions)! Regretfully output seems to not work now :-(
> >
> > If I turn on debugging in Muse I can see the input events (note on and
> > note off) being accepted and then the attempt to send them to the output
> > that fails with this error:
> >
> > MidiAlsaDevice::putEvent(): midi write error, returns -19 expected 28:
> > No such device
>
> Pmidi 1.5.4 manages to send to both outputs through alsa.

Both Muse and pmidi use the sequencer API, so, in theory, both should
work.

> But the exact same Muse was working before (I mean before the big
> changes that have happened in usb and midi). Has anything changed in the
> API?

No, not in the API.

And the error (19 = ENODEV) is rather strange. This isn't returned by the
sequencer API AFAIK (not even if the destination device doesn't exist), so
I'd guess that the sequencer handle got closed somehow.


Regards,
Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
