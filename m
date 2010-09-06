From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA sound/core/pcm_lib.c:318: BUG: pcmC0D0p:0,
 pos = 32768, buffer size = 32768 , period size = 2048
Date: Mon, 06 Sep 2010 09:16:18 +0200
Message-ID: <4C849542.4030409@ladisch.de>
References: <AANLkTikmZ0k2YQGMM+wdrqc+xAMgqYOZHtLA7Heag69H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A2D891037EA
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 09:15:50 +0200 (CEST)
In-Reply-To: <AANLkTikmZ0k2YQGMM+wdrqc+xAMgqYOZHtLA7Heag69H@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Doyle <wpdster@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Patrick Doyle wrote:
> pos = 32768, buffer size = 32768

This means that the driver's pointer callback returned a position that
is outside the buffer; in this case, the position is just after the end
of the buffer.


Regards,
Clemens
