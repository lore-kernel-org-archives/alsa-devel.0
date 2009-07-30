From: "Jason Bell" <j.bell@cqu.edu.au>
Subject: Re: Chat 50 at usb-0000:00:1a.7-4.3 audio issues
Date: Thu, 30 Jul 2009 15:36:27 +1000
Message-ID: <AFC5FC5923CF194BA8CCD128CAFF92110D712F8F@UNIMAIL.staff.ad.cqu.edu.au>
References: <AFC5FC5923CF194BA8CCD128CAFF92110D712F80@UNIMAIL.staff.ad.cqu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.cqu.edu.au (hawk.cqu.edu.au [138.77.5.14])
	by alsa0.perex.cz (Postfix) with ESMTP id A10D92447F
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jul 2009 07:36:38 +0200 (CEST)
Received: from [127.0.0.1] (helo=hawk.cqu.edu.au)
	by mx.cqu.edu.au with esmtp (Exim 4.63)
	(envelope-from <j.bell@cqu.edu.au>) id 1MWOJe-00037X-Hq
	for alsa-devel@alsa-project.org; Thu, 30 Jul 2009 15:36:34 +1000
Received: from UNIMAIL.staff.ad.cqu.edu.au (romulus.staff.ad.cqu.edu.au
	[138.77.34.92])
	by hawk.cqu.edu.au (8.14.2/8.14.2) with ESMTP id n6U5aRmR011989
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2009 15:36:34 +1000 (EST)
	(envelope-from j.bell@cqu.edu.au)
Content-class: urn:content-classes:message
In-reply-to: <AFC5FC5923CF194BA8CCD128CAFF92110D712F80@UNIMAIL.staff.ad.cqu.edu.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

G'day All

To further my email from yesterday, I have found that using the USB hub
and the latest ALSA drivers 1.0.20 appears to create a workable
solution, as the 2 applications that I am interested in both appear to
now work.  

Note that I had tried 1.0.20 before, on a previous install of the Linux
OS (Fedora 10), but didn't use a USB hub at the same time.

Additionally, I am in contact with the hardware vendors who are going to
investigate the issue.

Keep up the good work guys.

Many regards,
Jason.

-----Original Message-----
From: Jason Bell [mailto:j.bell@cqu.edu.au] 
Sent: Wednesday, 29 July 2009 12:44 PM
To: alsa-devel@alsa-project.org
Subject: [alsa-devel] Chat 50 at usb-0000:00:1a.7-4.3 audio issues

G'day ASLA Developers

I am hoping that someone might be able to assist me with an audio issue
I am having.

Recently I have begun using the Dell T3500 precisions as an Video
Conferencing machine (using the Access Grid and EVO Software). 

Information on hardware specs, etc can be found at
http://www.alsa-project.org/db/?f=7f33770c89802b0ab3132f21914cc6ca7f6626
37

Unfortunately, I have issues when using either a clearone Chat50 or
Chat150 (these are essentially speaker phone devices [See
http://www.clearone.com/products/product.php?cat=9&prod=94 for device
description]) with the speaker audio being distorted and static, cracks
and popping type sounds being introduced.  The microphone audio quality
is fine.  These issues were seen using Fedora 10 and Fedora 11.

I tried upgrading to the latest ALSA drivers and "testing" kernels
without any success (on a previous Fedora 10 install).  It was found
(still in the initial stages of testings) that if I plugged the Chat50
device into a USB hub, rather than directly into the Machine, the audio
issues disappeared (at least for some of the software). 

It should also be noted that I have a number of Dell T3400 series
machines that don't experience these issues.

Additionally is should be mentioned that the T3400 uses the ICH9 chipset
family whereas the T3500 uses the ICH10 chipset family which includes
the USB controller.

Just wondering if there is anything I can do to resolve this issue?

Many thanks in advance,
Jason.

--------------------------------------------
Jason Bell, B.I.T. (Honours)

Research Systems Support Officer
Information Technology Division 
CQ University Australia

Australian Research Collaboration Service
http://www.arcs.org.au/

E-mail : j.bell@cqu.edu.au
         jason.bell@arcs.org.au
Work   : +61 7 4930 9229
Mobile : 0409 630897
Postal : Building 19
         Central Queensland University
         Bruce Highway
         Rockhampton, Queensland, Australia, 4702
--------------------------------------------
Patience is a virtue.

But if I wanted Patience,
I would have become a Doctor.
--------------------------------------------


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
