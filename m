From: Stefan Seyfried <seife@suse.de>
Subject: Re: 2.6.10-rc1-mm3: swsusp problems w/ ALSA driver, IRQs on AMD64
Date: Mon, 08 Nov 2004 10:29:37 +0100
Message-ID: <418F3C81.9060302@suse.de>
References: <200411062014.08202.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from Cantor.suse.de (cantor.suse.de [195.135.220.2])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4A38D21E
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2004 15:56:26 +0100 (MET)
In-Reply-To: <200411062014.08202.rjw@sisk.pl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, alsa-devel@alsa-project.org, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

Rafael J. Wysocki wrote:

> Third, some important messages related to suspend/resume do not appear on the 
> serial console (eg the above  ALSA messages, the "[nosave pfn 0x584]..." 
> etc.), so I can't save them if the box hangs or reboots in the process.

dmesg -n 8
(before suspend) may help with this.

    Stefang



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
