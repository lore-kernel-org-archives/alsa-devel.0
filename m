From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: is there ioctl compat issues on x86_64?
Date: Wed, 13 Sep 2006 21:15:44 +0200
Message-ID: <m2bqpjtw67.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

I just found out that running alsamixer from alsa-utils-1.0.12 with a
2.6.17 kernel with alsa-kernel-1.0.12 results in the following kernel messages:
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(08075f70) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5014): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5025): Unknown cmd fd(3) cmd(c008551a){00} arg(08075f70) on /dev/snd/controlC0
ioctl32(alsamixer:5025): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5025): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5025): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5025): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5025): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0
ioctl32(alsamixer:5025): Unknown cmd fd(3) cmd(c008551a){00} arg(080769d8) on /dev/snd/controlC0

are there ioctl compat issues on x86_64?
both kernel, alsa-lib and alsamixer are native 64bits...

It works though...

see you

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
