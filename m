From: Nick Arnold <nick.arnold@nautronix.com.au>
Subject: HDSP 9652: Input channel corruption
Date: Thu, 9 Oct 2003 11:22:24 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031009112224.A6020@nautronix.com.au>
Reply-To: alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="--=_NextPart_ST_11_22_26_Thursday_October_09_2003_1884"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


----=_NextPart_ST_11_22_26_Thursday_October_09_2003_1884
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

(I'm posting this again with smaller attachments since my first attempt was
over-sized and appears to be stuck in the moderator's in-tray.  Many
appologies if both posts appear -- the content is otherwise identical.)

I've posted previously about problems getting the 9652 up-and-working.  We
overcame the original difficulties but have recently observed another problem
of which we were previously unaware.  I'll detail our setup first then the
symptoms:

Our setup:
----------

A RME Hammerfall HDSP 9652 card on a SMP redhat 9 box.  ALSA 0.9.6 with
Thomas Charbonnel's hdsp driver patch applied.  12 input channels and three
output channels, running at 96KHz 24bit samples.  The output of "uname -a" on
the box says:

    Linux wombat 2.4.20-19.9smp #1 SMP Tue Jul 15 16:45:28 EDT 2003 i686
    athlon i386 GNU/Linux

The amixer settings we use:

     #!/bin/bash
     amixer -c 0 cset numid=11 0
     amixer -c 0 cset numid=13 0
     for i in $(seq 1 26);do
         amixer -c 0 cset name=Chn,index=$i 32768
     done

(ie. sync reference is an external word clock, the card should not use any
internal clock source; and output channels should be turned on.)

I've also attached the contents of /proc/asound/card0/hdsp as hdsp.txt.

The symptoms:
------------

We connect a sine wave to the first 12 channels and record them, and see
three channels -- 0, 4, and 8 -- are "corrupted".  The remaining channels
appear to be well-formed and look as we expect them to.

We tried swapping the card with another identical card and the problem
remained.  We then tried swapping the HDSP 9652 with one of the older DIGI
9652 cards (and re-configuring ALSA) and the problem went-away.  This
indicates a problem with the HDSP 9652 or its driver (and absolves the
cables, AD/DA, and our recording software).

I've attached a plot of channel zero (corrupted) against channel one
(uncorrupted) as data.jpg.  We've determined that the samples on channel zero
are incorrectly ordered.  We've also found a formula that can reorder channel
zero to closely follow the samples of channel one, modulo an expected
difference in gain.

More specifically, it appears as though the following is occuring for (the
96KHz) channel zero:

    48kHz channel 0 samples:    0 2 4 6 ...
    48kHz channel 2 samples:    1 3 5 7 ...

    expected 96KHz channel :    0 1 2 3 4 5 6 7 ...
    observed 96KHz channel :    1 0 3 2 5 4 7 6 ...

(and we presume the same is happening for channels 4 and 8 also.)

It seems most likely to be some code in the driver, or perhaps the mixer is
responsible for this incorrect ordering.

The questions are:

    - could this be a bug, perhaps in the hdsp driver?

    - alternatively, could this be due to some mixer setting that has been
      turned on by default unbeknownst to us?  if so, how can we turn this
      off?

any help much appreciated,

nick.
--
This email is confidential and intended solely for the use of the individual to whom it is addressed.  Any views or opinions presented are solely those of the author and do not necessarily represent those of Nautronix Ltd.

If you are not the intended recipient, you have received this email in error and use, dissemination, forwarding, printing, or copying of this email is strictly prohibited.  If you have received this email in error please contact the sender.

Although our computer systems use active virus protection software, and we take various measures to reduce the risk of viruses being transmitted in e-mail messages and attachments sent from this company, we cannot guarantee that such
e-mail messages and attachments are free from viruses on receipt.  It is a condition of our using e-mail to correspond with you, that any and all liability on our part arising directly or indirectly out of any virus is excluded.
Please ensure that you run virus checking software on all e-mail messages and attachments before reading them.
----=_NextPart_ST_11_22_26_Thursday_October_09_2003_1884
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hdsp.txt"

RME Hammerfall HDSP 9652 (Card #1)
Buffers: capture f6e00000 playback f6a00000
IRQ: 18 Registers bus: 0xe3000000 VM: 0xf8a07000
Control register: 0x100a0ef
Control2 register: 0x800
Status register: 0x747cf0e
Status2 register: 0xffff8479
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff00
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff00

Buffer Size (Latency): 8192 samples (2 periods of 32768 bytes)
Hardware pointer (frames): 8192
Passthru: no
Line out: on
Firmware version: 1

Sample Clock Source: AutoSync
Preferred Sync Reference: Word Clock
AutoSync Reference: Word Clock
AutoSync Frequency: 48000
System Clock Mode: Slave
System Clock Frequency: 48000

IEC958 input: Internal
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off
IEC958 sample rate: Error flag set

ADAT1: Sync
ADAT2: Sync
ADAT3: Sync
SPDIF: No Lock
Word Clock: Sync
ADAT Sync: No Lock


----=_NextPart_ST_11_22_26_Thursday_October_09_2003_1884
Content-Type: image/jpeg
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="data.jpg"

/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAA4KCw0LCQ4NDA0QDw4RFiQXFhQUFiwgIRokNC43
NjMuMjI6QVNGOj1OPjIySGJJTlZYXV5dOEVmbWVabFNbXVn/2wBDAQ8QEBYTFioXFypZOzI7
WVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVn/wAAR
CAHwAjgDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAA
AgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkK
FhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWG
h4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl
5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREA
AgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYk
NOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOE
hYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk
5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDa8S+Iv7AW3P2VZxKp7hcYC+3vXPj4jgnA
0zJP+2v/AMTUnxHTzBp6blXcGG5jgD7lcnJphsZIlMkcryAnKn7v+f8AGqlaMbhBOc+SO51h
+IJWYxNpe1xwQZBx/wCO1IPHjf8AQOX/AL+D/wCJrnvF1qtv4ldk6MBn2O0V1F3aWU/jRNMi
CRKGz5cdlCAv7on7xB3fQj+Qow04VaSqNb/5DrRcJ8q8iD/hPG/6Bq/9/B/8TS/8J23/AEDl
/wC/g/8AiapJoFkLYq7XBuP7LOobw4Cg9l27f1zVg+GLIanqVt5txstZrWNDuGSJSA2eMcZ4
rp5aXb+vvMbyJh46b/oHL/38H/xNL/wnLf8AQOT/AL+D/wCJqiuiaZ5mqMbi4EGnlY28zCZc
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
9KuYorpHdk4HrRQB/9k=

----=_NextPart_ST_11_22_26_Thursday_October_09_2003_1884--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
