From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: rawmidi
Date: Sat, 09 Oct 2004 11:41:08 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0410091135030.18648-100000@studcom.urz.uni-halle.de>
References: <DB99F0250CDF5F438C525F4695C888DC01CC79D6@exchange01-srv.pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <DB99F0250CDF5F438C525F4695C888DC01CC79D6@exchange01-srv.pianodisc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve DeRosier <derosier@pianodisc.com>
Cc: pat@dumaisnet.ca, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Steve DeRosier wrote:
> Many (most) of the status bytes can be used in running status.
> The exceptions that I know about are the 0xF* messages.  I'd say
> the critical ones would be 0x80, 0x90, and 0xB0 (pedal controler
> messages are in here).  Probably the 0xA0 and 0xC0 too, but I'm
> not as sure about those and I don't happen to have a copy of the
> MIDI spec at my home office to refer to, maybe someone who's got
> access to one can check for you.

All channel message status bytes (0x80...0xEF) can use running status.
System common messages (0xF0...0xF7) cancel any running status.
Realtime messages (0xF8...0xFF) don't affect running status and can be
inserted anywhere, even in the midst of other commands.

<http://www.borg.com/~jglatt/tech/midispec.htm>


HTH
Clemens



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
