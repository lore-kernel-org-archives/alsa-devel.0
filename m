From: Patrick Dumais <pat@dumaisnet.ca>
Subject: RE: rawmidi
Date: Fri, 8 Oct 2004 12:20:57 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0410081217430.13397@pat.dumaisnet.ca>
References: <DB99F0250CDF5F438C525F4695C888DC01CC79D5@exchange01-srv.pianodisc.com>
Reply-To: pat@dumaisnet.ca
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <DB99F0250CDF5F438C525F4695C888DC01CC79D5@exchange01-srv.pianodisc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve DeRosier <derosier@pianodisc.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


no that was just an example I did, it sends the stream correctly.

I didnt know that this was the standard. I understand completely why my
app should support running status so i'll implement it. It's not that hard
after all. but about that:

does this "running status" apply only on noteon/off events or on
controls too? should I only be keeping track of 90h commands?

Thanks a lot for your answers

Patrick Dumais
****************************
http://www.dumaisnet.ca:242/

On Fri, 8 Oct 2004, Steve DeRosier wrote:

> Date: Fri, 8 Oct 2004 09:12:25 -0700
> From: Steve DeRosier <derosier@pianodisc.com>
> To: pat@dumaisnet.ca, alsa-devel@lists.sourceforge.net
> Subject: RE: [Alsa-devel] rawmidi
>
> Patrick,
>
> The "batch" mode that you're seeing is called "running status" by the MIDI STANDARD.  It is standard MIDI that any MIDI device or application really needs to support.  It's not just the drivers that are sending it, but almost any device will send data in that format usually.
>
> I know that doesn't answer your specific question on how to adjust ALSA, but the last thing needed is yet another device or application that doesn't fit the MIDI standard yet dares to say it supports MIDI.
>
> Implementation is not hard, you just need to write your MIDI parser so it keeps track of if it's in running status, what the most recent status byte was, and watch for new status bytes.
>
> On the other hand, if your application is sending output to the drivers of only say "0x90 0x01 0x7F" and the driver output is "0x90 0x01 0x7F 0x02 0x7F" then there really is a problem with the drivers and that should be fixed.
>
> - Steve
>
>
> -----Original Message-----
> From: Patrick Dumais [mailto:pat@dumaisnet.ca]
> Sent: Friday, October 08, 2004 8:27 AM
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] rawmidi
>
>
>
> I noticed that some drivers tend to send "batch" note-on commands. I mean:
> instead of sending 90h,01h,7Fh everytime, it sends a first 90,01,7f then
> just 02,7f etc... It sends the noteon command only once and assumes that
> your application will set itself in a "noteon receive" mode. This is very
> annoying because my application expects to receive a command byte each
> time. the emu10k1 driver doesn't do that, but snd-virmidi does.
>
> I'm using virmidi because I want 2 apps to read my sbLive midi port. I
> aconnect this port to 2 virmidi ports then my apps read from those ports.
>
> Is there any way that I can configure virmidi so that it sends commands
> the conventional way, or any other way that I could have 2 applications
> reading on the same midi port? (using the alsa sequencer interface is not
> an alternative method that I want to consider for the scope of my
> applications)
>
> Thanks,
> Patrick Dumais
> ****************************
> http://www.dumaisnet.ca:242/
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
