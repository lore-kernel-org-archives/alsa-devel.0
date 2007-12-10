From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: cmipci: have only surround40 on 6 ch card
Date: Mon, 10 Dec 2007 11:53:42 +0100
Message-ID: <1197284022.25582.1225725951@webmail.messagingengine.com>
References: <fjcgls$55i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C41F0244D9
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 11:53:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fjcgls$55i$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: SeNS <sens_boston@yahoo.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SeNS wrote:
> I have 6 channel CMI8738-based card (it works in 6 channel mode under win32; 
> and works before under Linux with ALSA).

In what ALSA version did it work?

> cat /proc/asound/card0/cmipci
> C-Media PCI CMI8738 (model 37) at 0xe000, irq 10
> ...
> 08: 03 00 00 01
> 0c: 00 00 01 00

These registers identify the chip as model 37 with four channels.

What model is this?


Regards,
Clemens
