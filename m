From: K.Fetscher@t-online.de (Klaus Fetscher)
Subject: Cross Compile Problems
Date: Mon, 08 Nov 2004 23:11:26 +0100
Message-ID: <418FEF0E.8080304@fetron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hallo,

I want to use ALSA for my ARM based custom board, but I have the 
following problems.

- I am using a NFS-Root Filesystem for my embedded hardware. I have 
cross compiled the alsa-lib and the alsa-utils with the 
"--PREFIX=/tftpboot/acc-rootfs" . The root filesystem is mounted below 
"/tftpboot/acc-rootfs". When I start the mixer, he want to load the file 
"alsa.conf" with the complete path 
"/tftpboot/acc-rootfs/share/alsa/alsa.conf" . The problem is, that the 
correct path for the ARM CPU is only "/share/alsa/alsa.conf" . Are there 
any options to solve this problem ?

- After temporary copy the files to 
"/tftpboot/acc-rootfs/tftpboot/acc-rootfs/share/alsa/alsa.conf" I get 
the following error:
"ALSA lib control.c:629:(snd_ctl_open_conf) symbol _snd_ctl_hw_open is 
not defined inside (null)"
"amixer: Mixer attach default error: No such device or address"
Is it necessary to add entries to "/share/alsa.conf" or to 
"/etc/asound.conf" or to to ".asoundrc" ?
I couldn't not use "alsaconf" because my shell can't interpret the 
commands "dialog" or "whiptail".
The detection of the card works correct, because I have can see the card 
in the "/proc/asound" directory and also the streams under the 
"/proc/asound/card0" directory.

Thanks

Klaus Fetscher



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
