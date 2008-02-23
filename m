From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Adapt eeepc p710 mixer for virtual master control
Date: Sat, 23 Feb 2008 01:57:22 -0300
Message-ID: <200802230157.22461.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CEB4243DA
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 05:58:24 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 37FC23AA07
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 01:58:23 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id hRkZem6EGVJ9 for <alsa-devel@alsa-project.org>;
	Sat, 23 Feb 2008 01:58:22 -0300 (BRT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id C53A53AA06
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 01:58:22 -0300 (BRT)
Received: from [172.21.225.10] (unknown [172.21.225.10])
	by fox.conectiva (Postfix) with ESMTP id 4240F2F5B3
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 01:58:22 -0300 (BRT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adapt eeepc p710 mixer for virtual master control
    
Currently eeepc p710 mixer doesn't define any slave volume control. This
is incompatible with current virtual master control code, that will return
-ENOENT in this case.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6f7dd96..bda09ad 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -12989,8 +12989,8 @@ static struct snd_kcontrol_new alc662_lenovo_101e_mixer[] = {
 static struct snd_kcontrol_new alc662_eeepc_p701_mixer[] = {
 	HDA_CODEC_MUTE("Speaker Playback Switch", 0x14, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME("LineOut Playback Volume", 0x02, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("LineOut Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Line-Out Playback Volume", 0x02, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Line-Out Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 
 	HDA_CODEC_VOLUME("e-Mic Boost", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("e-Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),


I'll explain the issue a bit more: after commit 2134ea4f37d36addbe86d4901f6c67a22a5db006
"[ALSA] hda-codec - Add virtual master controls", alsamixer for example doesn't
work anymore on eeepc p710:
"alsamixer: function snd_mixer_load failed: No such file or directory"

I figured out that the problem was with the virtual master controls code and the
eeepc p710 mixer that doesn't have any slave volume control. Given eeepc
hardware and my understading in reality this virtual master doesn't seem much
useful (you have only one playback source - LineOut Playback), only for master
switch it is useful as you have Speaker and HeadPhone switches (Headphone is
name LineOut Playback Switch in this case) as slave switches. But as only
master switch doesn't seem good (it would be strange change vmaster
code to accept only a master switch) and I didn't want to refactor the eeepc
mixer, this patch seemed a good solution, please comment on it, what do you
think?

I also thought of making code to just disable vmaster for this model, I don't
know what could be the better solution.

Something should be done also for the other eeepc ep20 model mixer, it will not
suffer the same bug, but the way its mixer is currently seems to conflict with the
virtual master control idea (may be "MuteCtrl" would be obsoleted).

--
[]'s
Herton
