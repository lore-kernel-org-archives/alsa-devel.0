From: d <dieb13@klingt.org>
Subject: hdsp9652 (kind of) working
Date: Fri, 30 May 2003 16:10:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED7663E.7020405@klingt.org>
References: <E19LRDo-0006qW-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19LRDo-0006qW-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

hi list+paul again!

just to let you know:
i asked the previous owner of my hdsp 9652 card and he gave me the hint 
to use alsa 0.9rc7 plus a patch to ignore the reality and handle the 
card as a hdsp+digiface:

*** hdsp.c.orig 2003-05-30 14:01:17.000000000 +0200
--- hdsp.c      2003-05-30 13:20:12.000000000 +0200
***************
*** 2978,2983 ****
--- 2978,2984 ----

         switch (rev & 0xff) {
         case 0xa:
+       case 0x68:
                 /* hdsp_initialize_firmware() will reset this */
                 hdsp->card_name = "RME Hammerfall DSP";
                 break;

he said, this patch was posted on the list once. (!?!)

the card now works with audible results, but still has two issues:
1) the card ignores alsamixer, but the sound comes out at a regular level.
2) i get constant clicks (about 2/sec), but that might come from the 
duron hardware i'm using.

regards
d13b

ps: i didn't invest much time in reproducing yesterdays last kernel 
panic, so i can't send you a trace - sorry



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
