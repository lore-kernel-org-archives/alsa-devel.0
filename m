From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: New sound device question
Date: Sun, 26 Dec 2010 12:20:35 +0100
Message-ID: <1293362435.7496.1412275155@webmail.messagingengine.com>
References: <4D14A309.9030603@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 5690224440
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2010 12:20:37 +0100 (CET)
In-Reply-To: <4D14A309.9030603@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laurent Epinat <l.epinat@free.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Laurent Epinat wrote:
> I try to developpe a usb sound driver for a Alesis Multix 8 USB2.0
> 
> http://www.alesis.com/multimix8usb20
> 
> The output interface is allready fonctional, but the Input not :-(
> Because there is 2 end point for it. The first one is on Isochronous
> mode and the other is on Bulk mode
> 
> I don't know how to declare the second endpoint in the quirks_table.

There is no predefined quirk for such an endpoint; you'd have to write
your own code.

> Where can I get a good documentation or help about the alsa USB sound
> structure.

At the moment, the only documentation is the source code.

> The only informations I have about the devices, are dump from windows

What is the bulk endpoint used for?


Regards,
Clemens
