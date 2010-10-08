From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Fri, 08 Oct 2010 08:26:52 +0200
Message-ID: <4CAEB9AC.1060208@ladisch.de>
References: <4C9DC7A1.8050001@showlabor.de>
	<4CA5BF35.2030108@showlabor.de>	<4CA60C5B.6010809@ladisch.de>
	<4CA86E1A.30405@showlabor.de>	<4CAAD212.9090805@ladisch.de>
	<4CAC804A.8040806@showlabor.de>	<4CAC89EA.8080207@ladisch.de>
	<4CACA471.2000504@showlabor.de>	<4CAD6AA2.4050205@ladisch.de>
	<20101007081010.GZ7159@buzzloop.caiaq.de>
	<4CADB077.3060907@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 0CFE424614
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 08:25:23 +0200 (CEST)
In-Reply-To: <4CADB077.3060907@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> @Daniel:
> You asked for the output of lsusb. Are you thinking of modifying the
> UA-101 driver yourself? Or something more generic?

I guess he wanted to look for UAC2 descriptors (which this device does
not have).

When (if) the driver has UAC2 implicit feedback support, it's easy to
add a simple quirk that makes the FTU work.  (In that case, the UA-101
driver can be merged back, too.)

> Did anyone notice the patch adding mixer support for the FTU devices I
> send on Sept, 25?

Yes, I noticed it.


Regards,
Clemens
