From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Bug in pcm_lib.c ?? (using Xmms)
Date: Sun, 8 Dec 2002 19:13:01 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212081905470.629-100000@pnote.perex-int.cz>
References: <3DF33EF4.5060207@cucumelo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DF33EF4.5060207@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 8 Dec 2002, Benny Sjostrand wrote:

> Hi!
> 
> Just updated CVS tree and recompiled. Everything works OK execpt that I 
> got this message in log
> when using Xmms with ALSA-plugin and OSS-plugin. Using aplay the message 
> dont apear.
> 
> Dec  8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: 
> BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200
> Dec  8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: 
> BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200
> Dec  8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:110: 
> BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200
> Dec  8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: 
> BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200
> Dec  8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: 
> BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200
> Dec  8 13:40:16 cactus kernel: ALSA 
> ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: 
> cs46xx_dsp_proc_free_scb_desc: freeing PCMReader_SCB0
> Dec  8 13:40:16 cactus kernel: ALSA 
> ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: 
> cs46xx_dsp_proc_free_scb_desc: freeing SrcTask_SCB0
> 
> With the ALSA-plugin I got the message only one time, with the 
> OSS-plugin it apears about a 1000 of times.
> (have not done any changes to the cs46xx driver yet,  except what's in 
> current CVS ;) )

It's definitely a bug in CS46xx driver. I've changed the test for the ring 
buffer pointer to be in range 0 .. buffer_size-1 . pointer equal to 
buffer_size doesn't make any sense and it should be really zero.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
