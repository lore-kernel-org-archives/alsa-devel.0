From: Ross Wille <wille@freescale.com>
Subject: Porting ARM ALSA driver to 2.6.16 kernel
Date: Wed, 14 Jun 2006 08:30:55 -0600
Message-ID: <200606140830.55570.wille@freescale.com>
Reply-To: wille@freescale.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

I have an ALSA sound driver working on an ARM platform running on a 
2.6.10 kernel.  But when I ported this driver to the 2.6.16.19 kernel 
it does not work.  The device nodes show up, but when I try to call any 
of the OSS-emulation ioctls (for example, SNDCTL_DSP_SETFMT) I get a 
-EINVAL return code from the ioctl call and a "No usable accesses" 
error gets printed to the console.  (I do have OSS emulation enabled in 
the kernel.)

Has something changed with the kernel sound APIs between 2.6.10 and 
2.6.16 that would cause this problem?  I have reviewed the kernel 
ChangeLogs, but nothing pops out at me.  Any suggestions would be 
appreciated.

Thanks,

-Ross
