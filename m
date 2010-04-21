From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [REGRESSION] SB X-Fi Notebook stopped working in
 1.0.23
Date: Wed, 21 Apr 2010 08:53:58 +0200
Message-ID: <4BCEA106.10804@ladisch.de>
References: <4BCE0BC8.3020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id DC6FE103823
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 08:54:02 +0200 (CEST)
In-Reply-To: <4BCE0BC8.3020201@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: The Source <thesourcehim@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Source wrote:
> This device works fine with 1.0.22.1 driver, but doesn't with 1.0.23.
> snd-usb-audio & Ko are loaded but to no good. alsamixer doesn't list the
> device and no device files in /dev/snd.

When the driver doesn't attach, it should log some error message(s) to
the system log.


Regards,
Clemens
