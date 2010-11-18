From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] cm6206: turn off de-emphasis in s/pdif
Date: Thu, 18 Nov 2010 10:11:11 +0100
Message-ID: <4CE4EDAF.4010200@ladisch.de>
References: <Pine.LNX.4.61.1011161859260.551@kermit.ultrawaves>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A39E2103908
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 10:09:28 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.1011161859260.551@kermit.ultrawaves>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Lammerts <alsa-devel@lists.lammerts.org>
Cc: Dan Allongo <gongo2k1@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eric Lammerts wrote:
> I noticed on my DAC that the de-emphasis LED was on. Is this by
> accident?

Probably.  The mechanism to set the S/PDIF status bits should be added
to the driver, but as long as we do not have that, setting this bit by
default is silly.

> Below is a patch that turns it off.

Thanks.  Please provide a Signed-off-by tag as described in
Documentation/SubmittingPatches.


Regards,
Clemens
