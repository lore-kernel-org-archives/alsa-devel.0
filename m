From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: No HDMI audio output,
 nVidia audio not listed in lspci
Date: Thu, 26 May 2011 12:31:31 +0200
Message-ID: <4DDE2C03.5030607@ladisch.de>
References: <BANLkTimybCjUxvTEJZJ_qZZ8y+s7+cHcUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8DC2810389D
	for <Alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 12:29:19 +0200 (CEST)
In-Reply-To: <BANLkTimybCjUxvTEJZJ_qZZ8y+s7+cHcUg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joost Verdoorn <jpverdoorn@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joost Verdoorn wrote:
> No HDMI audio output

Did you try device "hw:0,1"?

> nVidia audio not listed in lspci

I'd guess that your GPU does not have a separate audio controller for
HDMI but uses S/PDIF data as a source, so you actually have to use the
digital output of the internal HDA device.

I don't know if the graphics driver has to enable something for this
to work.


Regards,
Clemens
