From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: MTP/AV / Sequencer MIDI problem... design issue?
Date: Sat, 11 Jan 2003 20:50:49 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301120151.h0C1p3X8029477@spider.tela.com>
References: <20030111165908.386c27c4.rpav@nwlink.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 11 Jan 2003 16:59:08 PST."
             <20030111165908.386c27c4.rpav@nwlink.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@nwlink.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>That's what drivers are for. ;)  The ALSA sequencer shouldn't have to
>know of course, but the driver should be able to handle it, and the
>architecture should allow a working driver.

i'd agree with that.

>> another example of this that i know a bit more about is on the
>> tropez+. this has two MIDI output ports, and you can switch between
>> them with 2 "unused" MIDI bytes. what should ALSA do if you deliver
>> those bytes in a data stream? how can it know what they will do? why
>> should it pay any attention at all to them?
>
>It should pay attention because it's a universal sound architecture that
>provides software from low-level driver to API.  The low-level driver
>is all that needs to know about this.  

i was asking those questions somewhat rhetorically. the tropez+ driver
*does* watch for those special bytes, and will not deliver them. user
space is not allowed to switch ports using this mechanism - its a
technique restricted to the driver itself. user space gets to open
whichever port(s) it wants to open and writes to them.

i would have thought that the mtpav driver should do the same
thing. if you want to access all 8 ports, you should have 8 access
points (whether this is via the sequencer or the rawmidi interface),
and write to each one of them. the use of the "Dn" byte(s?) to switch
output ports shouldn't be exported to user space. 

--p



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
