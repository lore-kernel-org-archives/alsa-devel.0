From: William <walsac3@orthoset.com>
Subject: Re: VIA 8235: Bad IRQ after PCM playback and moving the mouse
Date: Thu, 18 Nov 2004 20:03:48 GMT
Message-ID: <200411182003.UAA29785@orthoset.com>
References: <200411181943.TAA28593@orthoset.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411181943.TAA28593@orthoset.com>
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

> VIA 8235 sound system on a laptop:
> 
> I keep getting bad IRQ errors after PCM playback and moving the mouse.

kernel 2.6.8.1 modularised with soundcore but in-kernel alsa disabled
alsa-driver-1.0.7rc2

If APM BIOS is enabled in kconfig, the laptop will not boot at all
so I disabled it and am using ACPI modules instead.
The laptop has an external USB mouse and a touchpad.
If the sound modules are loaded but PCM is unused,
then the mouse and the touchpad can both work ok.
However, after ALSA PCM has been used, the IRQ errors happen every time
I move the pointer using either the external mouse or the touchpad.
Why is this happening?

William


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
