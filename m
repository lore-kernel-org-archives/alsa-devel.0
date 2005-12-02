From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001606]: cs4281 dmix oss does not work
Date: Fri, 2 Dec 2005 14:47:11 +0100
Message-ID: <22ad5cd996ac71dd7b8dcc61c4bf95a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0268716A
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2005 14:47:11 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1606> 
======================================================================
Reported By:                bogdan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1606
Category:                   PCI - cs4281
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo 2005.1 and Ubuntu 5.10 (both with newest
updates)
Kernel Version:             2.6.14, 2.6.13, 2.6.14
======================================================================
Date Submitted:             11-30-2005 12:44 CET
Last Modified:              12-02-2005 14:47 CET
======================================================================
Summary:                    cs4281 dmix oss does not work
Description: 
hi,

issue is exactly the same on all distros i tested - primarily tested with
gentoo 2005.1/linux-2.6.14/alsa1.0.10rc1 and
ubuntu5.10/linux-2.6.12/alsa1.0.9 (exactly the same issue)
firstly things that work fine:
1. alsa dmix works perfect without any modifications (without asoundrc
files), regardless what I do.
2. oss emulation also works perfect(/dev/dsp) without any modifications

what does not work:
it does not work when I would like to have multiple oss programs sending
to /dev/dsp - aka dmix oss (when I introduce the asoundrc script). I use
the following script for this:

pcm.cs4281 {
type hw
card 0
}

ctl.cs4281 {
type hw
card 0
}

pcm.dsp0 {
type plug
slave.pcm "ossmix"
}

ctl.mixer0 {
type hw
card 0
}

pcm.ossmix {
type dmix
ipc_key 1024
ipc_perm 0660
slave {
pcm cs4281
period_time 0
period_size 1024
buffer_size 8192
}

bindings {
0 0
1 1
}
}

now to test I use mpg123. Here is the output - quite interesting:

voynix mp3 # aoss mpg123 -vv /root/mp3/01\ -\ Cos\ optymistycznego   
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2 and 3.
Version 0.59s-r9 (2000/Oct/27). Written and copyrights by Michael Hipp.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!

Audio capabilities:
        |  s16  |  u16  |  u8   |  s8   | ulaw  | alaw  |
 --------------------------------------------------------
  8000  |   M   |   M   |   M   |   M   |   M   |   M   |
 11025  |   M   |   M   |   M   |   M   |   M   |   M   |
 12000  |   M   |   M   |   M   |   M   |   M   |   M   |
 16000  |       |       |       |       |       |       |
 22050  |       |       |       |       |       |       |
 24000  |       |       |       |       |       |       |
 32000  |       |       |       |       |       |       |
 44100  |       |       |       |       |       |       |
 48000  |       |       |       |       |       |       |

Title  : Co&#156; optymistycznego             Artist: Kasia Kowalska
Album  : Czek&#185;j&#185;c na...                  Year  : 1996
Comment:                                 Genre : Rock

Directory: /root/mp3/
Playing MPEG stream from 01 - Cos optymistycznego ...
Found new ID3 Header
MPEG 1.0, Layer: III, Freq: 44100, mode: Stereo, modext: 0, BPF : 626
Channels: 2, copyright: No, original: Yes, CRC: No, emphasis: 0.
Bitrate: 192 Kbits/s, Extension value: 0
Audio: 4:1 conversion, rate: 11025, encoding: signed 16 bit, channels: 1
Frame#   349 [ 7334], Time: 00:09.11 [03:11.58], Bitrate 192

as you see after we introduce the asoundrc script then the output gets
converted to rate 11025 and Mono. mpg123 sees reduced quality of the card
under /dev/dsp - see the table above. Voice is extremely bad quality and
garbled and playing 4xnormal speed. not enjoyable at all :-)

as comparision - the same but without dmix asoundrc:
voynix ~ # aoss mpg123 -vv /root/mp3/01\ -\ Cos\ optymistycznego 
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2 and 3.
Version 0.59s-r9 (2000/Oct/27). Written and copyrights by Michael Hipp.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!

Audio capabilities:
        |  s16  |  u16  |  u8   |  s8   | ulaw  | alaw  |
 --------------------------------------------------------
  8000  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |
 11025  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |
 12000  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |
 16000  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |
 22050  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |
 24000  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |
 32000  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |
 44100  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |
 48000  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |  M/S  |

Title  : Co optymistycznego             Artist: Kasia Kowalska
Album  : Czek&#185;j&#185;c na...                  Year  : 1996
Comment:                                 Genre : Rock

Directory: /root/mp3/
Playing MPEG stream from 01 - Cos optymistycznego ...
Found new ID3 Header
MPEG 1.0, Layer: III, Freq: 44100, mode: Stereo, modext: 0, BPF : 626
Channels: 2, copyright: No, original: Yes, CRC: No, emphasis: 0.
Bitrate: 192 Kbits/s, Extension value: 0
Audio: 1:1 conversion, rate: 44100, encoding: signed 16 bit, channels: 2
Frame#   356 [ 7327], Time: 00:09.29 [03:11.39], Bitrate 192
[0:09] Decoding of 01 - Cos optymistycznego finished.

all fine, still /dev/dsp gets locked for only one program (which is
normal)

As I said above I had exactly the same issue on different linux2.6
distros. Also I tested the asoundrc script above (without modifications!)
in different laptop - ibm x31 with snd-intel8x0 and dmix oss was working
perfect! (several copies of mpg123 running at the same time)

- That is why I suspect issue is related to the driver for cs4281.

Hope you can do sth about it - would be nice to have this feature working
also for cirrus logic 4281 card... Of course I can help you with any tests
you would require.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-02-05 14:47 
----------------------------------------------------------------------
It's a known problem.  Since cs4281 has only 2 periods in hardware, dmix
doesn't work as it is.
We'll need an extension to handle the arbitrary irq/timer synchronized
with DMA, but this is not implemented yet.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-30-05 12:44 bogdan         New Issue                                    
11-30-05 12:44 bogdan         Distribution              => Gentoo 2005.1 and
Ubuntu 5.10 (both with newest updates)
11-30-05 12:44 bogdan         Kernel Version            => 2.6.14, 2.6.13,
2.6.14
12-02-05 14:47 tiwai          Note Added: 0006892                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
