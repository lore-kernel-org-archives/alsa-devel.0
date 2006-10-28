From: Anders Johansson <ajh@watri.org.au>
Subject: Re: vxpocket 440
Date: Sat, 28 Oct 2006 19:31:54 +0800
Message-ID: <20061028113154.GC4356@watri.org.au>
References: <20061027093747.GA29589@watri.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061027093747.GA29589@watri.org.au>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have had some more luck getting this thing going. I rebooted and
managed to get alsamixer working. Also compiled and installed kernel 
2.6.18.1 (SMP, no preemption), with alsa message logging. 


This is what the boot messages in syslog looks like:

Oct 28 18:21:07 asil kernel: ALSA sound/pcmcia/vx/vxpocket.c:220: vxpocket_config called
Oct 28 18:21:07 asil kernel: ALSA sound/pcmcia/vx/vxpocket.c:245: VX-pocket 440 is detected
Oct 28 18:21:07 asil kernel: ALSA sound/pcmcia/vx/vxpocket.c:188: vxpocket assign resources: port = 0x2100, irq = 3
Oct 28 18:21:07 asil kernel: ALSA sound/pcmcia/vx/vxp_ops.c:170: check ISR_HF2
Oct 28 18:21:07 asil kernel: ALSA sound/pcmcia/vx/vxp_ops.c:205: xilinx: dsp size received 0x577b, orig 0x577b
Oct 28 18:21:07 asil kernel: ALSA sound/drivers/vx/vx_uer.c:214: set internal clock to 0x4b from freq 48000
Oct 28 18:21:07 asil kernel: ALSA sound/drivers/vx/vx_core.c:700: checksum = 0xabaa657f
Oct 28 18:21:07 asil kernel: ALSA sound/drivers/vx/vx_pcm.c:261: vx_set_ibl: size = 2016, max = 2016, min = 504, gran = 126
Oct 28 18:21:07 asil kernel: ALSA sound/drivers/vx/vx_pcm.c:261: vx_set_ibl: size = 504, max = 2016, min = 504, gran = 126


Why is there ony one message about loaded firmware? I thought there
were 4 firmware files?



I have tried accessing the card, both directly using arecord, aplay
and using JACK, but with no luck, only some data gets in or out from the
card. Trying to use JACK results in the following error messages:

Oct 28 18:24:41 asil kernel: ALSA sound/drivers/vx/vx_uer.c:214: set internal clock to 0x571 from freq 8000
Oct 28 18:24:42 asil kernel: ALSA sound/drivers/vx/vx_core.c:299: <7>ALSA sound/drivers/vx/vx_core.c:299: msg got error = 0x802a15 at
cmd[0]
Oct 28 18:24:42 asil kernel: ALSA sound/drivers/vx/vx_pcm.c:795: vx: cannot start stream
Oct 28 18:24:42 asil kernel: ALSA sound/drivers/vx/vx_pcm.c:687: error hbuffer
Oct 28 18:24:42 asil kernel: ALSA sound/drivers/vx/vx_core.c:299: msg got error = 0xcfe at cmd[0]
Oct 28 18:24:43 asil kernel: ALSA sound/drivers/vx/vx_core.c:69: vx_check_reg_bit: timeout, reg=ISR, mask=0x10, val=0x7

I have managed to get JACK working with bigger bigger buffer size
(512 samples) but I don't get any sound through.


Playing a wav file works, but results in the following error 
messages:

Oct 28 18:35:36 asil kernel: ALSA sound/drivers/vx/vx_core.c:299: msg got error = 0xc00 at cmd[0]
Oct 28 18:35:36 asil kernel: ALSA sound/drivers/vx/vx_pcm.c:799: vx: cannot start pipe


Recording works sometimes, but sometimes only for a fraction of a
second, after that only noise is recorded.


Playing and recording simultaneously (using arecord | aplay) hardly
ever works, and no error messages are logged. When there is an error
message it is most often the same as for playback.


The biggest problem is that the machine often hangs when the sound
card is used. I have not been able to reproduce the problem in any
consistent way (use of uninitialised pointer perhaps)?



I really need to get the card working, downgrading is not an option
due to a very new chipset. 


Please help me,
//Anders

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
