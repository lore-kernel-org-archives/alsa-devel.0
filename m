From: Timur Tabi <timur@freescale.com>
Subject: Re: Unable to find an usable access for 'default'
Date: Thu, 05 Jul 2007 07:44:29 -0500
Message-ID: <468CE7AD.8020305@freescale.com>
References: <468ACB86.1040303@freescale.com>
	<1183530859.19025.1198427403@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id A0417103871
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2007 14:44:00 +0200 (CEST)
In-Reply-To: <1183530859.19025.1198427403@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

> It means that the plug plugin (that the ALSA lib uses to automatically
> convert between sample formats) was not able to find any combination of
> format/rate/channels/access that would work with your hardware.

Yes, I'm currently debugging that code, so that makes sense.  When you say "access", what do you mean by that?

> It is possible that some entries in the snd_pcm_hardware struct are set
> in an inconsistent way.  Please show the code of the driver.

I'd like to show the code, but the project is unannounced, so I can't yet.  Can you give me a suggestion as to what I should be looking for to resolve this?
