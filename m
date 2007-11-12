From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: hardware-dependent features
Date: Mon, 12 Nov 2007 18:26:08 +0100
Message-ID: <1194888368.31578.1220875067@webmail.messagingengine.com>
References: <20071112131350.GA25885@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 7AEA8243D4
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 18:26:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071112131350.GA25885@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> Also, I'd like to support the LEDs and displays on the devices and was
> wondering which interface to choose for that. I've got a patch ready
> which uses the generic led subsystem, but that approach seems to be a
> bit ugly as I end up having one entry per led on each device in one
> single folder. Any idea of a better way?

I've used three 'mixer' controls for the three LEDs of the SB Audigy 2
NX.  Whether this is a good idea depends on how many LEDs there are, and
how one might want to use them.  Are there LED displays, i.e., multiple
LEDs in a row?

I think the displays could by controlled by mixer controls of type
"bytes".  Usual mixer applications can't handle those, but this is
quite hardware dependent anway ...


Regards,
Clemens
