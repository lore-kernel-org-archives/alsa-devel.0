From: "Wallace, Brooke" <brookew@qualcomm.com>
Subject: User space drivers
Date: Thu, 2 Aug 2007 14:39:34 -0700
Message-ID: <C7A98C6EB85FFF4FAE03BD695D68EC7601239680@NAEX05.na.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from numenor.qualcomm.com (numenor.qualcomm.com [129.46.51.58])
	by alsa0.perex.cz (Postfix) with ESMTP id 32A072437E
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Aug 2007 23:40:13 +0200 (CEST)
Received: from sabrina.qualcomm.com (sabrina.qualcomm.com [129.46.61.150])
	by numenor.qualcomm.com (8.13.6/8.12.5/1.0) with ESMTP id
	l72LeBfU016439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <alsa-devel@alsa-project.org>; Thu, 2 Aug 2007 14:40:12 -0700
Received: from SANEXCAS02.na.qualcomm.com (sanexcas02.qualcomm.com
	[172.30.36.176])
	by sabrina.qualcomm.com (8.13.6/8.13.6/1.0) with ESMTP id
	l72Le9WE027376
	for <alsa-devel@alsa-project.org>; Thu, 2 Aug 2007 14:40:11 -0700
Content-class: urn:content-classes:message
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

Hi,
 
I've been trying to sort thru the ALSA docs and am starting to get the
impression that all of the existing drivers are written as Kernel
Modules. Doesn't this mean that they are running in Kernel space and
infact are not User Space drivers? Shouldn't there be an ALSA Drivers
API document that covers an API that User Space Drivers can use? I must
be mssing something here...
 
I'm looking into ALSA because my company wants to use this standard for
writing User Space drivers for our product running on various linux
kernels. The reasoning for this is strictly proprietary licensing - our
leagl department is not comfortable with the GPL and the possiblitiy
that something written for Kernel space could at some time be considered
as required to be GPL - not my decision...
 
-Brooke
