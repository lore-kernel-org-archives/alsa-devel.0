From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: snd-hda-intel prevents machine to power off
Date: Tue, 28 Oct 2008 13:59:33 -0200
Message-ID: <20081028135933.36778d60@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752583AbYJ1P7M@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


 Hi Takashi,

 If I have some process with the sound device opened in my eeepc
(say KDE's kmix) and try to power off the machine, for example with:

# echo o > /proc/sysrq-trigger

 The machine will not power off.

 But it does work if I remove the snd-hda-intel module before issuing
the echo above.

 This problem seems to be pretty popular among distros, I could find
it reported for Mandriva, Ubuntu and Fedora.

 Its workaround is also documented in a few wikis: people are doing
a 'rmmod snd-hda-intel' in the last halt stage (ie, halt script
in etc).

 I have tested with 2.6.27.4 and latest 2.7.28-rc2.

 How I can I help you to debug this?

 Thanks.

-- 
Luiz Fernando N. Capitulino
