From: =?utf-8?B?VsOhY2xhdiDFoG1pbGF1ZXI=?= <eudoxos@arcig.cz>
Subject: pin assignment for ALC260 (hda-intel)
Date: Thu, 19 Jan 2006 10:46:53 +0100
Message-ID: <20060119094653.GA3838@ag-smil.arcig>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(jwoithe: respond privately, we take this off list unless someone else
gets in.)

I've been playing with ALC260 (patch_realtek.c) following the directions
for bug #1618.

What I've done is the following:

1. I did not modify alc260_base_mixer, as it seems to cover all mixers
on the chip (i.e. 0x7-0xa, following the diagram in the datasheet); I
assume that if it is HDA_INPUT or HDA_OUTPUT makes only the difference
whether the mixer displays it under playback or capture.

2. alc260_init_verbs is problematic for me. I did
{0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT} for all the i/o widgets,
i.e. 0xf-0x16. No sound so far. PIN_OUT is defined as 0x40, which is not
a number I was able to find in the datasheet. Can I assume that widgets
connected to PIN_OUT are relly going to the real output.

I am at loss also with AC_VERB_CONNECT_SEL. What is its parameter 0x0?
/* select line-out */ {0x15, AC_VERB_SET_CONNECT_SEL, 0x00}.? Is the
only point that I will try to connect all line IO (0xf-0x16) to 0x0-0x3
(or more?) (which is, according to some comments in the realtek_patch.c:
HP, line, mic?) I don't find any such numbers on the datasheet.

I am sorry that I pose such questtions, but I don't really know nothing
about ALSA internals.

I had the idea of having a Windows program querying the ALC260 chip for
those widget settings with the get verbs - the laptop has XP
preinstalled and sound works fine there. Or perhaps reverse-engineer the
initilization verbs from the Windows driver?

Thanks for any help,

Vaclav Smilauer


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
