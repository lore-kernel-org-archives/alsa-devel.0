From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp update
Date: Mon, 24 Nov 2003 19:37:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FC24FF1.2070405@undata.org>
References: <3FC0EC7D.1010701@undata.org>	<s5hu14u2dwg.wl@alsa2.suse.de>	<s5hhe0t3jl7.wl@alsa2.suse.de>	<3FC24454.8000902@undata.org> <s5hsmkd1vho.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080502080107090309060808"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmkd1vho.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080502080107090309060808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote :
>>
>>I updated hdspmixer and hdspconf to fix all these problems :
>>http://www.undata.org/~thomas/
> 
> 
> applied to cvs.  thanks!
> 
> 
>>I just checked cvs to send you a clean patch instead, but the latest 
>>changes were not in there yet. Sorry for the extra workload this gives you.
> 
> 
> no problem at all.  (blame to sourceforge :)
> 
> 
> ciao,
> 
> Takashi

Thanks !
While we're at we should shut up the warnings in hdsploader too. Trivial 
diff attached.

Thomas

--------------080502080107090309060808
Content-Type: text/plain;
 name="hdsploader.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdsploader.patch"

--- hdsploader.c.cvs	2003-11-03 20:09:55.000000000 +0100
+++ hdsploader.c	2003-11-24 19:25:50.000000000 +0100
@@ -31,14 +31,13 @@
 
 void upload_firmware(int card)
 {
-    int err, i;
+    int err;
     snd_hwdep_t *hw;
     snd_hwdep_info_t *info;
     char card_name[6];
     hdsp_version_t version;
     
     hdsp_firmware_t firmware;
-    hdsp_config_info_t config_info;
     
     snd_hwdep_info_alloca(&info);
     snprintf(card_name, 6, "hw:%i", card);
@@ -97,7 +96,6 @@
 
     snd_ctl_card_info_t *info;
     snd_pcm_info_t *pcminfo;
-    int cards = 0;
     
     snd_ctl_card_info_alloca(&info);
     snd_pcm_info_alloca(&pcminfo);    

--------------080502080107090309060808--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
