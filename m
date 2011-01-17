From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Card driver: device or resource busy
Date: Mon, 17 Jan 2011 08:46:20 +0100
Message-ID: <4D33F3CC.1070202@ladisch.de>
References: <12d8ae03d3b.-1810748071142587921.-87582792196928800@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id BBF9124419
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 08:46:37 +0100 (CET)
In-Reply-To: <12d8ae03d3b.-1810748071142587921.-87582792196928800@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "torsten.schenk" <torsten.schenk@zoho.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

torsten.schenk wrote:
> I figured out that the difference between my driver and existing ones
> is, that my driver only allows one client and others multiple.

Very few devices can mix streams in hardware.

To get software mixing, you have to add the dmix plugin to the default
device for your card; see alsa-lib/src/conf/cards/.

> Another point (perhaps not unrelated to this) is, that I get a bug
> (see below) that seems to tell me, that prepare cannot schedule.

ALSA doesn't prevent the prepare callback from scheduling, but I'd guess
that your code disables interrupts somewhere.


Regards,
Clemens
