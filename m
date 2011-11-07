From: Colomban Wendling <lists.ban@herbesfolles.org>
Subject: Realtek ALC889: HDA Intel and kernel 3.1 gives choppy
	sound (again)
Date: Mon, 07 Nov 2011 23:45:40 +0100
Message-ID: <4EB85F94.2060908@herbesfolles.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.herbesfolles.org (a4nancy.globenet.org [80.67.172.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 10F3824352
	for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2011 23:45:44 +0100 (CET)
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

Hi,

Back to 3.0, the sound on my soundcard [1] started to be choppy, I
reported it [2] and it got fixed (thanks to Takashi Iwai!).

However, the story repeated with 3.1 (and probably 3.0.8 or before [3]):
I've got similar choppy sound again.

I bisected the few commits that happened on
sound/pci/hda/patch_realtek.c, and finally found the villain:

"8974bd51 ALSA: hda/realtek - Fix auto-mute with HP+LO configuration"

Reverting it from v3.1 fixes the problem.

master (94956ee) also suffers of the problem, but I couldn't test
without that commit because reverting it fails, too much changes happened.


Thanks for your attention, and if you need any extra information
(although many are already available in my previous report [2]) or
testing, please let me know.


Regards,
Colomban


[1] Realtek ALC889 on an MSI H55M-E33

[2] bugs.debian.org/cgi-bin/bugreport.cgi?bug=635362,
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-July/042250.html
(though I can't find my original message here)

[3] I first saw the problem in Debian's 3.0.0-6 which includes 3.0 up to
.8 -- but the debugging I did was on vanilla kernel from
git://github.com/torvalds/linux.git.
