From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Bug in pcm_lib.c ?? (using Xmms)
Date: Sun, 08 Dec 2002 13:45:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF33EF4.5060207@cucumelo.org>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

Just updated CVS tree and recompiled. Everything works OK execpt that I 
got this message in log
when using Xmms with ALSA-plugin and OSS-plugin. Using aplay the message 
dont apear.

Dec  8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: 
BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200
Dec  8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: 
BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200
Dec  8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:110: 
BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200
Dec  8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: 
BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200
Dec  8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: 
BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200
Dec  8 13:40:16 cactus kernel: ALSA 
../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: 
cs46xx_dsp_proc_free_scb_desc: freeing PCMReader_SCB0
Dec  8 13:40:16 cactus kernel: ALSA 
../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: 
cs46xx_dsp_proc_free_scb_desc: freeing SrcTask_SCB0

With the ALSA-plugin I got the message only one time, with the 
OSS-plugin it apears about a 1000 of times.
(have not done any changes to the cs46xx driver yet,  except what's in 
current CVS ;) )

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
