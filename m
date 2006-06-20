From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ALSA - driver 0002219]: snd-mpu401 don't load
Date: Wed, 21 Jun 2006 01:57:13 +0200
Message-ID: <44988B59.3020301@keyaccess.nl>
References: <563a1fc814a40148353e27926695fc8f@bugtrack.alsa-project.org>	<4498852C.6060205@keyaccess.nl>
	<1150846540.2754.195.camel@mindpipe>
	<449888DA.3090009@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtpq3.tilbu1.nb.home.nl (smtpq3.tilbu1.nb.home.nl
	[213.51.146.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9A081175
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jun 2006 01:55:57 +0200 (MEST)
In-Reply-To: <449888DA.3090009@keyaccess.nl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:

> Dunno -- but the snd-mpu401 thing is irrelevant; he said
> snd-mpu401-uart _was_ being loaded, and it should then just take care
> of the port. As to why it's not doing so...

Looking at the driver, please make him provide "mpu_port=0x330" as a 
parameter to snd-via82xx and check if it then works (if it does, there 
is a "VIA82xx MPU401" at 0x330 in /proc/ioports, and aplaymidi -l will 
list the MPU401 UART).

Rene.
