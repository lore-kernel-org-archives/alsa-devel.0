From: llandre <r&d2@dave-tech.it>
Subject: Running ALSA on embedded system (PowerPC 405EP)
Date: Tue, 02 Nov 2004 19:26:04 +0100
Message-ID: <6.0.1.1.0.20041102164518.01c8a3e0@192.168.2.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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

Hi ALSA developers,

I'm a newbie. If this subject is off topic, please excuse me and
tell me the right mailing list I should write to.
I'm trying to build ALSA drivers, libs and utilities on an embedded
platform. The CPU is PowerPC 405EP by IBM. The kernel is 2.4.20.
After some work I successfully built and installed the following packages:
drivers: 0.9.0rc6
library: 0.9.0rc1
utilities: 0.9.0rc1
The sources are built on the target, that is no cross-compilation is involved.
I tried to build newer packages but I was not able to compile them (working
with embedded systems is often a PITA :-( )

1) When running the ALSA mixer I get the following error:

bash-2.05# ./alsamixer/alsamixer

alsamixer: function snd_mixer_load failed: Inappropriate ioctl for device
bash-2.05#

Am I missing something?
Anybody can help me about it?

2) As you can see I don't use the same version for drivers and libraries.
May this lead to problems?


Thanks in advance for your help,

llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2@dave-tech.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
