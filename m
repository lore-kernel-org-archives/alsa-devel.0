From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: issue at 44.1 Khz capturing
Date: Mon, 10 Aug 2009 13:51:17 +0200
Message-ID: <4A8009B5.5020305@ladisch.de>
References: <98769532B4BB14429434178695419EAE5F937821@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B2B8E103834
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 13:51:04 +0200 (CEST)
In-Reply-To: <98769532B4BB14429434178695419EAE5F937821@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Harsha, Priya wrote:
> ... But when I printed out the values passed from the pointer function,
> they are exactly at the intervals of 5513 bytes.

What is the exact buffer size?  Half a second would be 22050 bytes
(frames?), while four of your periods are 22052 bytes.
Does your hardware support buffers whose length is not an integer
multiple of the period size?


Best regards,
Clemens
