From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: rawmidi
Date: Fri, 08 Oct 2004 18:18:10 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0410081749220.12584-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0410081115480.13304@pat.dumaisnet.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0410081115480.13304@pat.dumaisnet.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Dumais <pat@dumaisnet.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Dumais wrote:
> I noticed that some drivers tend to send "batch" note-on commands. I mean:
> instead of sending 90h,01h,7Fh everytime, it sends a first 90,01,7f then
> just 02,7f etc...

This is running status.  It is used with all status bytes, not only
note-on commands.

> This is very annoying because my application expects to receive a
> command byte each time.

Running status is a required feature of the MIDI specification.  Your
application must be able to handle this.

> the emu10k1 driver doesn't do that, but snd-virmidi does.

The MIDI device connected to your card doesn't do that.

> Is there any way that I can configure virmidi so that it sends commands
> the conventional way,

You'd have to insert a call to snd_midi_event_no_status() at the
appropriate place in virmidi.c.

> using the alsa sequencer interface is not an alternative method
> that I want to consider for the scope of my applications

Using the sequencer is recommended if you don't want to deal with the
raw MIDI data.


Regards,
Clemens



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
