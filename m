From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [PATCH] USB MIDI bugs
Date: 11 Nov 2002 17:24:32 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1037064272.7799.157.camel@cmn37.Stanford.EDU>
References: <Pine.HPX.4.33n.0211110905510.16551-100000@studcom.urz.uni-halle.de>
	<1037062022.7805.129.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1037062022.7805.129.camel@cmn37.Stanford.EDU>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

> > This fixes sequencer input from USB MIDI. Both usbmidi.c and seq_midi.c
> > thought they could use substream->runtime->private_data for themselves.
> 
> Thanks! sequencer input is now working on Muse (both 0.5 and 0.6
> versions)! Regretfully output seems to not work now :-(
> 
> If I turn on debugging in Muse I can see the input events (note on and
> note off) being accepted and then the attempt to send them to the output
> that fails with this error:
> 
> MidiAlsaDevice::putEvent(): midi write error, returns -19 expected 28:
> No such device
> 
> This is the printout of the received event:
> MidiInput: port:0 chan:0 type:0x90 a=58 b=56
> 
> and the output event that precedes the error message:
> MidiOut: MidiAlsa: port:0 chan:0 type:0x90 a=58 b=56
> 
> There are no error printed when Muse subscribes to the input and output
> ports. I'll see if I can repeat the error with some other software
> package. 

Pmidi 1.5.4 manages to send to both outputs through alsa. 

But the exact same Muse was working before (I mean before the big
changes that have happened in usb and midi). Has anything changed in the
API? I would imagine that it should keep working with the new version. 

-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
