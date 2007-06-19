From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: pcm->private_data is NULL in alsa core!!
Date: Tue, 19 Jun 2007 16:29:38 +0200
Message-ID: <1182263378.1273.1195944481@webmail.messagingengine.com>
References: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
	<1182152265.9399.1195673497@webmail.messagingengine.com>
	<61445c750706180456i5228c8dbqbd168e5a3bbbe435@mail.gmail.com>
	<1182251430.29389.1195911445@webmail.messagingengine.com>
	<61445c750706190430i7d8f37b3g95326d7aee6c5056@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4D7AA243E8
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 16:29:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706190430i7d8f37b3g95326d7aee6c5056@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> in register codec 4 pvt data is c3d81180
> Registering the sound card
> in register codec 5 pvt data is c3998f20
> 
> i.e. after registering the sound card the value changes/gets
> corrupted, and c3998f20
> is not the value I get everytime, so I am thinking it is corrrupted somehow.

I'd guess the memory gets overwritten.

> But back in probe, after above function are executed, i.e. after
> register codec is over, I get the correct value for
> eac->pcm->private_data i.e. c3d81180, but by now the value of
> pcm->private_data is corrupted!

This implies that eac->pcm != pcm.

It seems quite a lot of memory gets corrupted.
Try to check which one of the various "eac" and "pcm" pointers changes
its value.


HTH
Clemens
