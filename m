From: "Ivica Bukvic" <ico@fuse.net>
Subject: Re: More Midisport 2x2 troubles (help from the Alsa developers is greatly appreciated!)
Date: Thu, 3 Apr 2003 21:04:47 -0500
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <000001c2fa4e$91c5af00$ac1f830a@ICO>
References: <000001c2fa40$6cdeb1e0$ac1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <000001c2fa40$6cdeb1e0$ac1f830a@ICO>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: linux-audio-user@music.columbia.edu, 'Clemens Ladisch' <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Actually please disregard the part about not receiving input using
rawmidi. Forgot to include -v option for verbose.

Yet, I still cannot get the second port of the Midisport 2x2 to become
available no matter what. /proc/asound/cards lists only one midisport
2x2 device (which is ok, I guess, since even Fernando's webpage mentions
that this is the case with the latest CVS stuff), but even in the
/proc/asound/card2 (which is indexed as such) it only lists one midi
port. Same is the case with the /dev/snd/midi* stuff.

I would at this point like to know if this is a bug (so that I can stop
wasting time on it) and if so, will it be addressed any time soon, and
furthermore what will be the future approach to this issue, will the
notion of assigning one /dev/midi device for each port prevail, or will
we have to access other ports on the same device through alsa's
hw:0,<subdevice> kind of approach, or perhaps something completely
different. 

This is rather important to me since now I am in process of implementing
multiple midi i/o port monitoring capability in my app and am currently
stuck waiting for this issue to be resolved, so before I can proceed I
would like to know what will be the best way of implementing that. This
will ensure that I do not end up having to revise a large body of my
code.

Apologies for the cross-posts, just trying to get to the bottom of this
issue that seemed fixed as of the ver.0.9.1 and now is back with a
vengeance. :-(

Again, any help on this matter is greatly appreciated! Sincerely,

Ico


> -----Original Message-----
> From: linux-audio-user-admin@music.columbia.edu
[mailto:linux-audio-user-
> admin@music.columbia.edu] On Behalf Of Ivica Bukvic
> Sent: Thursday, April 03, 2003 7:24 PM
> To: 'Clemens Ladisch'; linux-audio-user@music.columbia.edu
> Cc: alsa-devel@lists.sourceforge.net; alsa-user@lists.sourceforge.net
> Subject: [linux-audio-user] Re: More Midisport 2x2 troubles (help from
the
> Alsa developers is greatly appreciated!)
> 
> 
> Hmm, I've tried running the alsa-lib/test/ramidi test and tried using
it
> as:
> 
> rawmidi -i hw:2,0
> 
> This starts it up but I don't get any events in. Can anyone tell me
why?
> 
> Any other setting (i.e. hw:2,1) reports an error that such a device
was
> not found.
> 
> Interesting thing is that when I do ./rawmidi -o hw:2,0 I get the
> note-on/off signal on the midisport, which means that the send part of
> it works ok.
> 
> However, when I do -i nothing comes into the cpu.
> Same is with the ./rawmidi -I /dev/midi2 (there are no errors, but no
> input either).
> 
> cat /dev/midi2 works just fine.
> 
> My /dev/snd/ only has 1 midi device (midiC2D0), so it does seem like
> it's a problem with Alsa.
> 
> Running latency in the same dir freezes the machine with a loud sound
> going on.
> 
> I am using MDK 9.1 on Inspiron 8200. Any help is greatly appreciated!
> 
> Any other suggestions?
> 
> Ico
> 




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
