From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ALSA - driver 0002219]: snd-mpu401 don't load
Date: Wed, 21 Jun 2006 01:30:52 +0200
Message-ID: <4498852C.6060205@keyaccess.nl>
References: <563a1fc814a40148353e27926695fc8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D1ED6168
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jun 2006 01:29:35 +0200 (MEST)
In-Reply-To: <563a1fc814a40148353e27926695fc8f@bugtrack.alsa-project.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: rlrevell@joe-job.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

bugtrack@alsa-project.org wrote:

> ----------------------------------------------------------------------
>  rlrevell - 06-21-06 00:18 
> ----------------------------------------------------------------------
> It must be a kernel bug if the port does not appear in /proc/ioports.

Lee, please note that legacy (ISA/LPC, even PnP/ACPI controlled) hw does 
not ever appear in /proc/ioports without the driver loaded and having 
done a request_region().

By the way, the missing IRQ is not necesarily a problem. An MPU401 can 
output MIDI fine without using an IRQ and if his BIOS does not let him 
assign an IRQ (and Windows does not use one) I guess no IRQ is available 
for it.

Rene.
