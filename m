From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Problem with CME UF5 MIDI keyboard master volume
 slider
Date: Fri, 10 Aug 2007 16:55:23 +0200
Message-ID: <1186757723.30437.1204736811@webmail.messagingengine.com>
References: <1186223690.3246.11.camel@localhost.localdomain>
	<1186396868.28794.1203930879@webmail.messagingengine.com>
	<1186503487.3160.26.camel@localhost.localdomain>
	<1186560704.30326.1204316209@webmail.messagingengine.com>
	<1186581239.3160.6.camel@localhost.localdomain>
	<1186584284.2915.1204373387@webmail.messagingengine.com>
	<1186590962.3160.10.camel@localhost.localdomain>
	<1186648031.27177.1204511703@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 2D443103834
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 16:55:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1186648031.27177.1204511703@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Damon Chaplin <damon@karuna.eclipse.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I wrote:
> Damon Chaplin wrote:
> > Is it possible to workaround the problem?
> 
> Only by changing the driver.  Please wait until tomorrow.

Well, the driver should now continue after receiving bad data.

To be able to convert the data sent by the CME UFx to a real master
volume message, I need to know the data format at a lower level.
Please change line 58 of sound/usb/usbmidi.c to
	#define DUMP_PACKETS
and recompile the driver, then show the entries that are written to the
(debug) system log when a master volume message is received.


Regards,
Clemens
