From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Support for USB-Audio devices with Multiple
	configurations?
Date: Fri, 15 May 2009 19:21:02 +0200
Message-ID: <4A0DA47E.1070607@ladisch.de>
References: <4A0BBAF4.6000108@cse.unsw.edu.au> <4A0D14BD.1050002@ladisch.de>
	<4A0D2CC7.7000408@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 35BF62439A
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 19:21:07 +0200 (CEST)
In-Reply-To: <4A0D2CC7.7000408@cse.unsw.edu.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cameron Stone <camerons.lists@cse.unsw.edu.au>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cameron Stone wrote:
> Is it possible to have alternate settings with different numbers of
> channels?

Yes.  Each alternate setting has its own set of descriptors; you can
change _any_ parameter in those descriptors.


Best regards,
Clemens
