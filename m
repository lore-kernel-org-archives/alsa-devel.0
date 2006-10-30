From: Anders Johansson <ajh@watri.org.au>
Subject: Re: vxpocket 440
Date: Mon, 30 Oct 2006 17:22:30 +0800
Message-ID: <20061030092230.GB19442@watri.org.au>
References: <20061027093747.GA29589@watri.org.au>
	<20061028113154.GC4356@watri.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061028113154.GC4356@watri.org.au>
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

I have found 3 consistent ways to reproduce the hard locks. 

1. Unplug the power cord. 
   If the sound card is in use, the application using the sound card hangs.
   When the application is restarted, the computer locks.
   The sound card is not in use when the cord is unplugged the
   computer locks the next time it is accessed (either via mixer or
   sound I/O).

2. Access mixer and sound I/O simultaneously. 

3. On buffer overrun. 
   If the CPU is under load, so that ALSA is dropping
   samples, the application using the sound card sometimes hangs.
   The next time the sound card is accessed the computer locks.


I still get a variety of error messages in the syslog before the card
hangs:

Type 1:
Oct 30 16:31:10 asil kernel: ALSA sound/drivers/vx/vx_core.c:69:
<7>ALSA sound/drivers/vx/vx_core.c:69: vx_check_reg_bit: timeout,
reg=ISR, mask=0x10, val=0x3
Oct 30 16:31:10 asil kernel: ALSA sound/drivers/vx/vx_core.c:282:
vx_send_msg: send IRQ_MESSAGE error
Oct 30 16:31:10 asil kernel: ALSA sound/drivers/vx/vx_pcm.c:799: vx:
cannot start pipe

Type 2 sometimes repeated several times:
Oct 30 16:16:52 asil kernel: ALSA sound/drivers/vx/vx_core.c:69:
vx_check_reg_bit: timeout, reg=ISR, mask=0x2, val=0x0
Oct 30 16:16:52 asil kernel: ALSA sound/drivers/vx/vx_core.c:271:
vx_send_msg: wait tx empty error

Type 3:
Oct 30 15:44:57 asil kernel: ALSA sound/drivers/vx/vx_core.c:299: msg
got error = 0x0 at cmd[0]
Oct 30 15:44:57 asil kernel: ALSA sound/drivers/vx/vx_pcm.c:795: vx:
cannot start stream


Also if the card is ejected, it will not get detected when reinserted.

Could this be a problem with the pcmcia bridge or the chipset? Do you
think a bios upgrade could help?


Cheers,
//Anders

P.S. If no one can help me, please tell me that so that I can stop sending
mails to the list, or redirect me to a list where I can get help. D.S.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
