From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Re: Phase Reversal on Santa Cruz (cs46xx) => XFire
 too
Date: Wed, 04 Dec 2002 09:52:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEDC234.40602@cucumelo.org>
References: <200211170056.11190.puetzk@iastate.edu> <3DDEC512.7030108@cucumelo.org> <3DED2F26.2070805@gmx.de> <200212031745.48194.puetzk@iastate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Kevin Puetz <puetzk@iastate.edu>
Cc: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>it seems that volumes 0-0x7fff ramp up volumes, then 8000-ffff go back down... 
>but with opposite phases. So...
>
>  
>
Great discovery!, probably the stream can be inverted several times when 
it processedthrough
through the SCB tree. (PCMReader->SrcTaskSCB->MasterMixSCB->CodecOut)
Almost all SCB's got a volume field.

>and it sounds correct (for CD analog passthru and PCM at least).
>(note - you'll need to open alsamixer and adjust the DAC volume before the 
>'fix' works, I haven't found where it gets programmed on driver load.
>  
>
I guess that the only thing left is to change the initial volume values 
set when driver is loaded
in dsp_spos.c line 260:
    /* maximize volume */
     ins->dac_volume_right = 0x8000;
-    ins->dac_volume_left = 0x8000;
+   ins->dac_volume_left = 0x7fff;
     ins->spdif_input_volume_right = 0x8000;
-    ins->spdif_input_volume_left = 0x8000;
+   ins->spdif_input_volume_left = 0x7fff;

>Now, I have no idea if this is correct, if I just broke SPDIF (no reciever), 
>rear speakers (ditto, I don't have any) but it fixes my case anyway, so 
>that's a start. If anyone can test more of these cases, that might be good.
>
>  
>
If it works and solves a problem then it must correct -:)


/Benny



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
