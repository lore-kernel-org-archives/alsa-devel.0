From: Haakon Riiser <haakon.riiser@fys.uio.no>
Subject: Re: SysEx overflow when using the MIDI sequencer event
	interface
Date: Sat, 19 Aug 2006 22:01:54 +0200
Message-ID: <20060819200154.GA1054@fox>
References: <20060819102421.GA1991@fox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060819102421.GA1991@fox>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

A little followup to my previous post:  I just placed a printk()
in snd_emu10k1_midi_output_trigger() that prints the number of
bytes just sent to the SB Live's MPU-401.  I also also increased
the dmesg size to 512 KiB to make sure that nothing was lost.

I had expected that by summing the entries in dmesg after having
run 'amidi -s <sysex-file>', I would get the same number as the
number of in bytes of the sysex file, but that didn't happen.

When I try to insert a 18584 byte long sysex file using amidi,
dmesg shows a byte count of approx. 10868 (+/- a few bytes).
My own toy-version of amidi that uses the event interface gets
consistently less than ten(!) bytes in the dmesg log.  If I insert
a delay between each sysex event of about 100 ms, the byte count
increases to almost 300.

That is _far_ too low a number to explain how the MIDI tunes
can sound the same as when I load the sysex data with amidi.
If only 300 sysex bytes were actually sent to the MIDI device,
I would obviously hear the difference between that and amidi's
method that got over 10000 bytes through.

None of this makes any sense to me.  I thought all bytes pushed onto
the MPU-401 were sent through snd_emu10k1_midi_output_trigger(), but
this experiment contradicts that.  I'm having trouble getting the
big picture of how the MIDI parts in ALSA works, so a little help
would be appreciated. :-)

-- 
 Haakon

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
