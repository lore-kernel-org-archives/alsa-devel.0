From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: asus xonar d1
Date: Wed, 14 Apr 2010 16:02:05 +0200
Message-ID: <4BC5CADD.2020700@ladisch.de>
References: <20100413183103.64d0fa94@romy.gusto>	<20100413184304.3ffe3b3b@romy.gusto>	<4BC56891.6070909@ladisch.de>
	<20100414154223.246e7416@romy.gusto>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 4BC681037FC
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 16:02:10 +0200 (CEST)
In-Reply-To: <20100414154223.246e7416@romy.gusto>
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
> > What controls are missing?
> 
> hmm. i dont know, i thought there will be more on such a card. because
> on creatives and hd audio usually you have tons of controls and there
> only 5 or so.

The D1/DX hardware doesn't have that many controls because there
aren't so many inputs or outputs.

> and 3 of them is 7.1 output so its a bit confusing.

There is one "Master" control with 8 channels.  How this is displayed
is up to the mixer application.  (alsamixer isn't ideal in this respect,
older versions even less so.)

> to fedora 13 the controls are noticably faster, to my old debian lenny
> even w/ the 2.6.32 kernel they lag. on fedora 13 w/ 2.6.33 they are
> fast as usual, seems like you fixed that already ;-) .

Yes, the driver now doesn't write registers that have not changed.
In theory, this shouldn't make too much of a difference unless the
mixer tries to set the same volume repeatedly.


Regards,
Clemens
