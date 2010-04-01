From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: C-Media CMI8738-LX noise in recording from line in
Date: Thu, 01 Apr 2010 11:52:38 +0200
Message-ID: <4BB46CE6.1000103@ladisch.de>
References: <20100401031825.557be2bc@romy.gusto>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id A2B56103830
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 11:52:41 +0200 (CEST)
In-Reply-To: <20100401031825.557be2bc@romy.gusto>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars Schotte <lars.schotte@schotteweb.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lars Schotte wrote:
> The soundcard has following chipset - C-Media CMI8738-LX.

This chip was designed before on-board sound devices were common, and
manages to have worse analog sound quality than many of those,
especially on its inputs.

> So I try to record from the line in input, ...
> its too silent and there is a lot of noise in it.

Even if your current mixer settings are suboptimal and can be improved
(please show the output of "amixer contents" or the alsa-info output),
be aware that this card never will have good quality.


Regards,
Clemens
