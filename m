From: Sundance <sundance@ierne.eu.org>
Subject: RE: Support for VIA 8233A chipset on a KT333 (MSI KT3 Ultra) motherboard?
Date: Sun, 5 May 2002 01:34:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <acqdp0$e41$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-user@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You wrote:

>> [Summary: ALSA doesn't work with the VIA VT8233A chipset, found on
>> some KT333-based motherboards]
>
> I have this board and I get the same problem.
> It uses a Realtek chipset for the sound (ALC 650) that is not listed in the
> ac97_codec.c file.

Thank you. :) By investigating further I actually discovered that.
Actually, based on this:
http://www.linuxhq.com/kernel/v2.4/unofficial/patch200202/44.html
adding ALC 650 awareness to ALSA 0.9.0rc1 isn't too hard, theorically: just 
patch alsa-kernel/pci/ac97/ac97_codec.c with the following:

---------------------------------------------------------------------------
--- alsa-kernel/pci/ac97/ac97_codec.c.old       Sat May  4 04:27:30 2002
+++ alsa-kernel/pci/ac97/ac97_codec.c   Sat May  4 04:33:49 2002
@@ -108,6 +108,7 @@
 { 0x414c4310, 0xfffffff0, "RL5382",            NULL },
 { 0x414c4320, 0xfffffff0, "RL5383",            NULL },
 { 0x414c4710, 0xffffffff, "ALC200/200P",       NULL },
+{ 0x414c4720, 0xfffffff0, "ALC650",           NULL },
 { 0x43525900, 0xfffffff8, "CS4297",            NULL },
 { 0x43525910, 0xfffffff8, "CS4297A",           NULL },
 { 0x42525920, 0xfffffff8, "CS4294/4298",       NULL },
---------------------------------------------------------------------------

That's in theory anyway.
The bad news is that... in practice it's not sufficient to get it to work.
Oh well.
More precisely, the system still freezes if I modprobe snd-via8233 from 
runlevel 4 with the desktop environment running. It still works when I 
modprobe at runlevel 1, but the sound still doesn't work -- in a different 
way now. ALSA software actually /can/ open the sound device now, but when 
it tries to write to it, I get an I/O error.

> I also try the drivers provided by realtek (based on Alsa 0.5.10) and they
> do not work too. 
> ftp://ftp.realtek.com.tw/sound/ac97codec/linux/linux.zip

I'll give them a look. Thanks. :)
Maybe by fiddling with them and ALSA 0.9.0rc1 I can get the whole thing to 
work (yeah, well, I can dream, can't I? :)).
>From the look of those sources there is some register pokepoking to do when 
writing to an ALC 650 chipset. I'll try just that.

CC'ed to alsa-devel, since it's kinda devel-relevant now.
(The original message, for the sake of alsa-devel's readers, can be found 
here: 
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg03164.html)

-- S.

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
