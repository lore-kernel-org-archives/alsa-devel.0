From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: Re: Phase Reversal on Santa Cruz (cs46xx) => XFire too
Date: Tue, 3 Dec 2002 17:45:48 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212031745.48194.puetzk@iastate.edu>
References: <200211170056.11190.puetzk@iastate.edu> <3DDEC512.7030108@cucumelo.org> <3DED2F26.2070805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DED2F26.2070805@gmx.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>, Benny Sjostrand <gorm@cucumelo.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 03 December 2002 16:24, Friedrich Ewaldt wrote:
>   Hi Benny,

w00t!

it seems that volumes 0-0x7fff ramp up volumes, then 8000-ffff go back down... 
but with opposite phases. So...

--- alsa-cvs/alsa-driver-0.9.0rc6cvs20021202/alsa-kernel/pci/cs46xx/dsp_spos.h	
2002-11-24 19:52:17.000000000 -0600
+++ modules/alsa-driver/alsa-kernel/pci/cs46xx/dsp_spos.h	2002-12-03 
17:27:10.000000000 -0600
@@ -215,7 +215,7 @@
 
 static inline void cs46xx_dsp_scb_set_volume (cs46xx_t * 
chip,dsp_scb_descriptor_t * scb,
 					      u16 left,u16 right) {
-	unsigned int val = ((0xffff - left) << 16 | (0xffff - right));
+	unsigned int val = (left << 16 | (0xffff - right));
 
 	snd_cs46xx_poke(chip, (scb->address + SCBVolumeCtrl) << 2, val);
 	snd_cs46xx_poke(chip, (scb->address + SCBVolumeCtrl + 1) << 2, val);


and it sounds correct (for CD analog passthru and PCM at least).
(note - you'll need to open alsamixer and adjust the DAC volume before the 
'fix' works, I haven't found where it gets programmed on driver load.

Now, I have no idea if this is correct, if I just broke SPDIF (no reciever), 
rear speakers (ditto, I don't have any) but it fixes my case anyway, so 
that's a start. If anyone can test more of these cases, that might be good.

Throwing it out before I head out here for a few hours, in the hope that it 
will cause some insight :-)


-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
