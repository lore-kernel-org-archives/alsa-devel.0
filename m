From: Timur Tabi <timur@freescale.com>
Subject: Re: How can you tell if the speaker jack on your	sound
 card has anything plugged into it???
Date: Fri, 25 Apr 2008 15:56:46 -0500
Message-ID: <4812458E.5030508@freescale.com>
References: <48123137.70107@summitmediagroupllc.com>	<20080425194917.GA26621@sirena.org.uk>
	<481244BD.3060501@summitmediagroupllc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F860247E0
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 22:56:51 +0200 (CEST)
In-Reply-To: <481244BD.3060501@summitmediagroupllc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sean Thayne <sthayne@summitmediagroupllc.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sean Thayne wrote:
> How would one go about getting this info? I'm trying to create a 
> monitoring tool for a specific sound card, so the driver's standardized...

First, the hardware has to detect insertion.  Then, it has to send a 
signal to the driver (either via a status register or an interrupt).

Assuming you have all that (I've never seen a sound card that provides 
this info), perhaps you can specify the output jack only when something 
is plugged in?  That is, you register the output jack when something is 
plugged in, and then deregister it when something is removed.
