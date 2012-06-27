From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how to update hw_ptr and appl_ptr
Date: Wed, 27 Jun 2012 21:24:55 +0200
Message-ID: <4FEB5E07.3070801@ladisch.de>
References: <DBBC59900F0EF340B9938F193FB1A3453605DBD2@SC-VEXCH4.marvell.com>
	<4FE98239.7050908@ladisch.de>
	<DBBC59900F0EF340B9938F193FB1A3453605DD79@SC-VEXCH4.marvell.com>
	<4FE9AA98.7000307@ladisch.de>
	<DBBC59900F0EF340B9938F193FB1A3453611F4F2@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 5629024469
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 21:25:33 +0200 (CEST)
In-Reply-To: <DBBC59900F0EF340B9938F193FB1A3453611F4F2@SC-VEXCH4.marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zhen Fu <fuzh@marvell.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

Zhen Fu wrote:
> Because when I use aplay playback wav file, appear underrun phenomenon. So I want to ALSA driver how to handle xrun.

The most likely reason is that the .pointer callback returns wrong values.


Regards,
Clemens
