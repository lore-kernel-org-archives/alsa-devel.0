From: Stefan Macher <Stefan.Macher@web.de>
Subject: ALC658 SPDIF input patch
Date: Sun, 9 Jan 2005 22:49:44 +0100
Message-ID: <200501092249.44565.Stefan.Macher@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hi,

I have made a patch to get SPDIF input working with the Realtek ALC658. 
Realtek has changed the meaning of the Pin47 function selection bit (MX7A bit 
1 ) between ALC655 and ALC658.

ALC655: 0 -> external amplifier power down; 1 -> SPDIF IN
ALC658: 0 -> SPDIF IN; 1 -> external amplifier power down


Can please anybody include this into CVS.

Thanks,
Stefan
-------------------------------------------------------------------------------------------------------------

--- alsa-driver-1.0.8rc2/alsa-kernel/pci/ac97/ac97_patch.c      2005-01-04 
12:01:01.000000000 +0100
+++ alsa-driver-1.0.8rc2-alc658patch/alsa-kernel/pci/ac97/ac97_patch.c  
2005-01-09 22:20:53.933529512 +0100
@@ -1605,7 +1605,10 @@

        /* adjust default values */
        val = snd_ac97_read(ac97, 0x7a); /* misc control */
-       val |= (1 << 1); /* spdif input pin */
+       if(ac97->id == 0x414c4780) /* ALC658 */
+               val &= ~(1 << 1); /* Pin 47 is spdif input pin */
+       else /* ALC655 */
+               val |= (1 << 1); /* Pin 47 is spdif input pin */
        val &= ~(1 << 12); /* vref enable */
        snd_ac97_write_cache(ac97, 0x7a, val);
        /* set default: spdif-in enabled,


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
