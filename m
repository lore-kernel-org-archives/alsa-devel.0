From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: es1968 locks up on rmmod
Date: Mon, 26 Jan 2004 18:12:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40154A62.7080403@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

I have a Toshiba 4100XCDT laptop with an ES1968 chip. lspci follows:

00:0c.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
    Subsystem: Toshiba America Info Systems ES1978 Maestro-2E Audiodrive
    Flags: bus master, medium devsel, latency 64, IRQ 11
    I/O ports at fc00 [size=256]
    Capabilities: <available only to root>

When the init scripts try to unload snd_es1968 on shutdown, my machine
freezes instantly.

Distribution is SUSE 9.0 Professional. Kernel is kernel-default-26-2.6.1-4
from ftp.suse.com/pub/people/kraxel which is basically 2.6.2-rc1.

I assume the lockup happens because interrupts are not disabled for the
device.

Debug traces are not available since SysRq-T and SysRq-P do not work. The
nmi watchdog does not work on my hardware. The only SysRq keys that work
are "O" and "B" to switch the machine off/reboot it.

Right now, I can disable the rmmod, but that's not a solution for long.

Please take a look at the module unloading function and fix it if possible.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
