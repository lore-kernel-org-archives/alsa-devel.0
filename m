From: Jeremy Cline <jcline@redhat.com>
Subject: Regression: very quiet speakers on Thinkpad T570s
Date: Fri, 30 Nov 2018 09:49:17 -0500
Message-ID: <bbba2653-d57b-5fab-8c06-5fd22ae80aa5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kailang Yang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: Tim Van den Eynde <redhat@vdeynde.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Some folks have reported on the Fedora bug tracker[0] that the laptop
speaker volume is very low on the Thinkpad T570 when running a kernel
that includes commit 61fcf8ece9b6 ("ALSA: hda/realtek - Enable Thinkpad
Dock device for ALC298 platform").

alsa-info.sh from v4.15.4 (just before commit 61fcf8ece9b6 arrived in
stable) and v4.19.4 with the issue present are attached to the bugzilla.
I've also Cc'd Tim, who uploaded them and has the laptop in question.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1554304

Regards,
Jeremy
