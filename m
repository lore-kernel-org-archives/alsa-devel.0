From: Frank Neumann <beachnase@web.de>
Subject: Rawmidi mystery
Date: Wed, 5 Feb 2003 00:34:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18gCZI-0002XD-00@smtp.web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi list,

I have written a small helper program (for myself so far) that should allow
me to get a backup of all data from a Korg M3r expander through the ALSA
rawmidi API. I have written a first version that opens the rawmidi device,
tells the user to "start the dump on the M3r", and then waits for the
beginning of the SysEx data and stores that into a file. This one works
nicely.

Then, I modified it just a bit so that it does not passively wait but
instead actively sends the SysEx sequence for "Get All Program/Combination/
Drum/Global data" and then records everything that comes back.

Normally, according to the M3r's SysEx implementation in its manual,
this should give the same output, exactly 23963 bytes.
However, the second version loses about 130 bytes during the transfer.
The strange thing is that the beginning of the data (SysEx header:
F0 42 30 24...) is fine, and starting around byte 700 the data is exactly
the same as in the correct output, including the EOX (F7) at the very end of
the output. But somewhere in this first part, data is lost.

Even worse: Starting the same program with the same arguments gives
slightly differing number of output bytes each time:

franky@faramir:~/work/lakai/c/alsa/m3r> ./m3r2 a1
rawmidi device opened sucessfully.
 Now sending ALL DATA DUMP REQUEST...
[Waiting for SysEx sequence to start]
[SysEx start code found, writing data]...
[SysEx EOX code found, finishing - 23832 bytes written]
                                   ^^^^^
franky@faramir:~/work/lakai/c/alsa/m3r> ./m3r2 a2
rawmidi device opened sucessfully.
 Now sending ALL DATA DUMP REQUEST...
[Waiting for SysEx sequence to start]
[SysEx start code found, writing data]...
[SysEx EOX code found, finishing - 23833 bytes written]
                                   ^^^^^
franky@faramir:~/work/lakai/c/alsa/m3r> ./m3r2 a3
rawmidi device opened sucessfully.
 Now sending ALL DATA DUMP REQUEST...
[Waiting for SysEx sequence to start]
[SysEx start code found, writing data]...
[SysEx EOX code found, finishing - 23836 bytes written]
                                   ^^^^^

This number was observed to be in a range of +-20 bytes.
Could anyone explain this? Though the MIDI interface on the PC side
is in a cheapo Soundblaster PCI512 card, I don't think it's responsible
for data losses. To me this looks rather like a rawmidi problem. The
program really doesn't do much more but snd_rawmidi_open, snd_rawmidi_write,
snd_rawmidi_read, snd_rawmidi_drain and snd_rawmidi_close.

I tried this with 0.9.0rc6 and 0.9.0rc7, both give the same results.

If anyone needs more input or wants to look at the tiny source, let me
know. All input is appreciated.

Thanks for reading,
Frank


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
