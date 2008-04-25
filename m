From: Timur Tabi <timur@freescale.com>
Subject: Re: How can you tell if the speaker jack on your	sound
 card has anything plugged into it???
Date: Fri, 25 Apr 2008 16:04:39 -0500
Message-ID: <48124767.1090004@freescale.com>
References: <48123137.70107@summitmediagroupllc.com>	<20080425194917.GA26621@sirena.org.uk>	<481244BD.3060501@summitmediagroupllc.com>	<4812458E.5030508@freescale.com>
	<481246D1.1050101@summitmediagroupllc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 62D18103822
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 23:04:43 +0200 (CEST)
In-Reply-To: <481246D1.1050101@summitmediagroupllc.com>
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
> How do you think Vista does it? I've used a couple of different 
> computers (totally different hardware) and it can detect insertion for 
> them all...

Since I've never used Vista, I have no idea how it does it.  However, my 
point still stands: unless the hardware detects it and provide status 
information to the driver, there's nothing you can do.

So just figure out how your hardware provides the info, and then update 
your driver accordingly.
