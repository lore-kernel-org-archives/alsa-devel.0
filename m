From: Roger E Critchlow Jr <rec@elf.org>
Subject: Re: tecra 8100 / ymfpci
Date: Fri, 12 Dec 2003 09:39:33 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FD9EF45.7060200@elf.org>
References: <3FCE77D2.8000204@elf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FCE77D2.8000204@elf.org>
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

Greetings --

   The alsa ymfpci drivers haven't worked on toshiba tecra 8100's
since 0.5.  But the OSS drivers derived from the 0.5 alsa drivers
work fine.  This is a non-deterministic problem in 1.0.0.rc2.

   I've found that I can switch the ymfpci on or off by
repeatedly starting/aplaying/stopping the alsa sound system.
About one time in 3, 4, 5, or more, the sound chip will work,
all the other times I get static out of the speakers.

  Specifically, all I'm doing is looping over:

    /etc/init.d/alsasound start
    aplay /usr/share/sounds/startup3.wav
    /etc/init.d/alsasound stop

and most times through the loop I hear static, but sometimes I
hear startup3.wav played instead.

  /sbin/lspci -vvxxs <ymfpci bus address> produces identical output
in all cases: alsa producing sound, alsa producing static, or old
oss driver producing sound, the lspci run in each case after the
aplay/play was finished.

  I have the current Planet CCRMA kernel-2.4.23.ll, alsa drivers
(1.0.0.rc2), and source installed.  I can run any with/without
comparisons that might be useful, or compile patches, or whatever.

  (This kernel, by the way, only boots with the options pci=noacpi
or acpi=off, otherwise the boot hangs when initializing the pcmcia
slots.  This goes for 2.6.0 and any other acpi enabled kernel that
I've tried on the tecra 8100.)

-- rec --



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
