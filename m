From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Change alsamixer to show different views.
 Playback controls, or Capture controls.
Date: Fri, 27 Aug 2004 22:16:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <412FA49B.3020806@superbug.demon.co.uk>
References: <412F2E4E.4080300@superbug.demon.co.uk>	<s5hwtzkk0hf.wl@alsa2.suse.de>	<412F6481.7030300@superbug.demon.co.uk>	<s5hsma8jzfp.wl@alsa2.suse.de>	<412F709D.10903@superbug.demon.co.uk> <s5hisb4jwun.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070106070606090602040301"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net [194.217.242.89])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 43EF1210
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 23:16:12 +0200 (MEST)
In-Reply-To: <s5hisb4jwun.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070106070606090602040301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Fri, 27 Aug 2004 18:34:21 +0100,
> James Courtier-Dutton wrote:
> 
>>Takashi Iwai wrote:
>>
>>>>I have a question. The "Mic Boost" seems to think it is a "Playback" 
>>>>control. What would be the best way to getting that to be a "Capture" 
>>>>control. Would simply editing it in ac97_codec.c be enough?
>>>
>>>
>>>Hmm, when you change the control name itself, it breaks slightly
>>>compatibility with older version.
>>
>>What does the name have to be compatible with?
>>I.e. What program might break if we change this in ac97_codec.c ?
> 
> 
> Dunno.  But, at least, when you run "alsactl restore", the status
> won't be restored.
> 
> 
> Takashi
> 
> 

Thats true, but from a purely conceptual point of view, I think the Mic 
Boost should be associated with Capture and not associated with Playback.

I attach a patch to do just that.

James


--------------070106070606090602040301
Content-Type: text/plain;
 name="mic-boost.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mic-boost.diff.txt"

Index: alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.144
diff -u -r1.144 ac97_codec.c
--- alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c	11 Aug 2004 18:51:58 -0000	1.144
+++ alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c	27 Aug 2004 21:10:44 -0000
@@ -687,7 +687,7 @@
 static const snd_kcontrol_new_t snd_ac97_controls_mic[3] = {
 AC97_SINGLE("Mic Playback Switch", AC97_MIC, 15, 1, 1),
 AC97_SINGLE("Mic Playback Volume", AC97_MIC, 0, 15, 1),
-AC97_SINGLE("Mic Boost (+20dB)", AC97_MIC, 6, 1, 0)
+AC97_SINGLE("Mic Boost (+20dB) Capture Switch", AC97_MIC, 6, 1, 0)
 };
 
 static const snd_kcontrol_new_t snd_ac97_control_capture_src = {

--------------070106070606090602040301--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
