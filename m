From: Randy Cushman <rcushman_linux@earthlink.net>
Subject: Inexplicable mixer control creation
Date: Tue, 13 Mar 2007 20:21:08 -0400
Message-ID: <45F73FF4.1000902@earthlink.net>
References: <45F1830D.9020609@earthlink.net> <s5hodmyr6j9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mta9.adelphia.net (mta9.adelphia.net [68.168.78.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 69B19243DA
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2007 01:21:27 +0100 (CET)
Received: from [127.0.0.1] (really [67.20.25.133]) by mta9.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
	id <20070314002125.BAVA2196.mta9.adelphia.net@[127.0.0.1]>
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2007 20:21:25 -0400
In-Reply-To: <s5hodmyr6j9.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In attempting to implement my proposed mixer control name changes (see 
"[Alsa-devel] RFC: Enhance AD AC '97 mixer control names") I have 
encountered behavior that makes no sense to me:  If module 
snd_ac97_codec does not create a control with the name 'PCM Playback 
Volume' then something else creates a control with that name.  Not 
surprisingly, this phantom control serves no useful purpose in my 
environment, as it has no affect on AC '97 control registers.

Configuration details:  Using Fedora Core 5 kernel 2.6.18-1.2239.fc5 
(i686) with the latest ALSA-driver source from Mercurial.

Details:
- I have ruled out the possibility that module snd_ac97_codec or 
snd_intel8x0 could be creating the control, because the following steps 
cause the control to disappear:
# modprobe -r snd_intel8x0
# modprobe -r snd_ac97_codec
# modprobe snd_ac97_codec
# modprobe snd_intel8x0
- I have also ruled out (using calls to printk) the possibility of the 
control being created via calls to snd_ac97_cnew(), 
snd_ac97_cmute_new_stereo() or snd_ac97_cvol_new().
- The phantom control appears after booting to runlevel 3 or 5.
- If removed using the above modprobe commands, the phantom control will 
appear after logging into a KDE session.
- If removed using the above modprobe commands, the phantom control does 
not appear after logging into a Gnome session.

Any suggestions for how I might track down the source of this phantom 
control would be welcome.

Randy Cushman



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
