From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Rawmidi mystery
Date: Wed, 5 Feb 2003 09:28:26 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302050920060.14453-100000@studcom.urz.uni-halle.de>
References: <E18gCZI-0002XD-00@smtp.web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18gCZI-0002XD-00@smtp.web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Neumann <beachnase@web.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Frank Neumann wrote:
> I have written a small helper program (for myself so far) that should allow
> me to get a backup of all data from a Korg M3r expander through the ALSA
> rawmidi API. I have written a first version that opens the rawmidi device,
> tells the user to "start the dump on the M3r", and then waits for the
> beginning of the SysEx data and stores that into a file. This one works
> nicely.

Something like
	echo "Please start the dump on the M3r"
	cat /dev/snd/midiC0D0 > some_file
?  :-)

> Then, I modified it just a bit so that it does not passively wait but
> instead actively sends the SysEx sequence for "Get All Program/Combination/
> Drum/Global data" and then records everything that comes back.
>
> Normally, according to the M3r's SysEx implementation in its manual,
> this should give the same output, exactly 23963 bytes.
> However, the second version loses about 130 bytes during the transfer.
> The strange thing is that the beginning of the data (SysEx header:
> F0 42 30 24...) is fine, and starting around byte 700 the data is exactly
> the same as in the correct output, including the EOX (F7) at the very end of
> the output. But somewhere in this first part, data is lost.

This looks like a buffer overrun, but then I don't understand why the
first version of your program would work. Is there anything suspicious in
/proc/asound/card0/midi0?

It may be possible that writing the data to disk between rawmidi_read()
calls takes too much time. I'd like to see the source.


HTH
Clemens



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
