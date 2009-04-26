From: Jon Smirl <jonsmirl@gmail.com>
Subject: Breakage in pcm_lib.c
Date: Sat, 25 Apr 2009 20:56:13 -0400
Message-ID: <9e4733910904251756y6534d2d0x6c201d00cbc728d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id DB5DF24692
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 02:56:14 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3400081qyk.16
	for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2009 17:56:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: alsa-devel@alsa-project.org

These recent commits to pcm_lib.c have fundamentally changed the way
snd_pcm_update_hw_ptr_interrupt() works.  They have introduced a
requirement that snd_pcm_ops.pointer function be able to report the
current position of the DMA transfer while the transfer is in
progress. The chip I'm working, PowerPC mpc5200, can't do that. There
is no access to the internal registers of the DMA engine. On the
mpc5200 snd_pcm_ops.pointer always returns the beginning address of
the DMA buffer. These checks break audio on the mpc5200 by trying to
fix up the pointers when they are actually correct.

These checks can probably be modified to take this hardware limitation
into account. To simulate our problem on your desktop machine, modify
snd_pcm_ops.pointer in your HDA driver to return the front of the DMA
buffer instead of the current position inside the buffer.

commit bbf6ad1399e9516b0a95de3ad58ffbaed670e4cc
Author: Jaroslav Kysela <perex@perex.cz>
Date:   Fri Apr 10 12:28:58 2009 +0200

    [ALSA] pcm-midlevel: Add more strict buffer position checks based on jiffies

    Some drivers like Intel8x0 or Intel HDA are broken for some
hardware variants.
    This patch adds more strict buffer position checks based on jiffies when
    internal hw_ptr is updated. Enable xrun_debug to see mangling of wrong
    positions.

    As a side effect, the hw_ptr interrupt update routine might do
slightly better
    job when many interrupts are lost.

    Signed-off-by: Jaroslav Kysela <perex@perex.cz>

commit 8b22d943c34b616eefbd6d2f8f197a53b1f29fd0
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Mar 20 16:26:15 2009 +0100

    ALSA: pcm - Safer boundary checks

    Make the boundary checks a bit safer.
    These caese are rare or theoretically won't happen, but nothing
    bad to keep the checks safer...

    Signed-off-by: Takashi Iwai <tiwai@suse.de>

commit ded652f7024bc2d7b6118b561a44187af30841b0
Author: Takashi Iwai <tiwai@suse.de>
Date:   Thu Mar 19 10:08:49 2009 +0100

    ALSA: pcm - Fix delta calculation at boundary overlap

    When the hw_ptr_interrupt reaches the boundary, it must check whether
    the hw_base was already lapped and corret the delta value appropriately.

    Also, rebasing the hw_ptr needs a correction because buffer_size isn't
    always aligned to period_size.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>


root@phyCORE:~ aplay phone.wav
mpc5200-psc-ac97 f0002200.sound: psc_dma_startup(substream=c792d700)
mpc5200-psc-ac97 f0002200.sound: psc_dma_pcm_open(substream=c792d700)
Playing WAVE 'phone.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
mpc5200-psc-ac97 f0002200.sound:
psc_ac97_hw_analog_params(substream=c792d700) p_size=5513
p_bytes=44104 periods=3 buffer_size=22050  buffer_bytes=176400
channels=2 rate=44100 format=11
boundary 22050
boundary 1 1445068800
stac9766: ac97_analog_prepare rate 44100
rate is bb80 5622
mpc5200-psc-ac97 f0002200.sound: psc_dma_trigger(substream=c792d700,
cmd=1) stream_id=0
psc_dma_pcm_pointer pos 5513
hw_ptr_interrupt 5513 new_hw_ptr 5513
delta 0 buffer_size 22050
old_hw_ptr 0 new_hw_ptr 5513
rate 44100 HZ 300
jdelta 50 jiffies -79179 runtime->hw_ptr_jiffies -79229
Saved jiffies a -79179
psc_dma_pcm_pointer pos 11026
hw_ptr_interrupt 11026 new_hw_ptr 11026
delta 0 buffer_size 22050
old_hw_ptr 5513 new_hw_ptr 11026
rate 44100 HZ 300
jdelta 38 jiffies -79141 runtime->hw_ptr_jiffies -79179
Saved jiffies a -79141
psc_dma_pcm_pointer pos 16539
hw_ptr_interrupt 16539 new_hw_ptr 16539
delta 0 buffer_size 22050
old_hw_ptr 11026 new_hw_ptr 16539
rate 44100 HZ 300
jdelta 37 jiffies -79104 runtime->hw_ptr_jiffies -79141
Saved jiffies a -79104
psc_dma_pcm_pointer pos 0
hw_ptr_interrupt 22052 new_hw_ptr 0
delta -22052 buffer_size 22050
ALSA sound/core/pcm_lib.c:241: PCM: Unexpected hw_pointer value
(stream=0, pos=0, intr_ptr=22052)
old_hw_ptr 16539 new_hw_ptr 22052
rate 44100 HZ 300
jdelta 38 jiffies -79066 runtime->hw_ptr_jiffies -79104
Saved jiffies a -79066
psc_dma_pcm_pointer pos 5513
hw_ptr_interrupt 27565 new_hw_ptr 27563
delta -2 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 49613
rate 44100 HZ 300
jdelta 37 jiffies -79029 runtime->hw_ptr_jiffies -79066
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=5513,
delta=27561, period=5513, jdelta=37/187/0)
Saved jiffies a -79029
psc_dma_pcm_pointer pos 11026
hw_ptr_interrupt 27565 new_hw_ptr 33076
delta 5511 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 33076
rate 44100 HZ 300
jdelta 38 jiffies -78991 runtime->hw_ptr_jiffies -79029
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=11026,
delta=11024, period=5513, jdelta=38/74/0)
Saved jiffies a -78991
psc_dma_pcm_pointer pos 16539
hw_ptr_interrupt 27565 new_hw_ptr 38589
delta 11024 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 38589
rate 44100 HZ 300
jdelta 37 jiffies -78954 runtime->hw_ptr_jiffies -78991
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=16539,
delta=16537, period=5513, jdelta=37/112/0)
Saved jiffies a -78954
psc_dma_pcm_pointer pos 0
hw_ptr_interrupt 27565 new_hw_ptr 22050
delta -5515 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 44100
rate 44100 HZ 300
jdelta 38 jiffies -78916 runtime->hw_ptr_jiffies -78954
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=0,
delta=22048, period=5513, jdelta=38/149/0)
Saved jiffies a -78916
psc_dma_pcm_pointer pos 5513
hw_ptr_interrupt 27565 new_hw_ptr 27563
delta -2 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 49613
rate 44100 HZ 300
jdelta 37 jiffies -78879 runtime->hw_ptr_jiffies -78916
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=5513,
delta=27561, period=5513, jdelta=37/187/0)
Saved jiffies a -78879
psc_dma_pcm_pointer pos 11026
hw_ptr_interrupt 27565 new_hw_ptr 33076
delta 5511 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 33076
rate 44100 HZ 300
jdelta 38 jiffies -78841 runtime->hw_ptr_jiffies -78879
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=11026,
delta=11024, period=5513, jdelta=38/74/0)
Saved jiffies a -78841
psc_dma_pcm_pointer pos 16539
hw_ptr_interrupt 27565 new_hw_ptr 38589
delta 11024 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 38589
rate 44100 HZ 300
jdelta 37 jiffies -78804 runtime->hw_ptr_jiffies -78841
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=16539,
delta=16537, period=5513, jdelta=37/112/0)
Saved jiffies a -78804
Aborted by signal Interrupt...
mpc5200-psc-ac97 f0002200.sound: psc_dma_trigger(substream=c792d700,
cmd=0) stream_id=0
mpc5200-psc-ac97 f0002200.sound: psc_dma_shutdown(substream=c792d700)
mpc5200-psc-ac97 f0002200.sound: psc_dma_pcm_close(substream=c792d700)
root@phyCORE:~ mpc5200-psc-ac97: timeout on ac97 write



-- 
Jon Smirl
jonsmirl@gmail.com
