From: Niels Langendorff <linux@langendorff.nl>
Subject: Two codecs using the same I2S bus
Date: Fri, 11 Dec 2009 13:29:07 +0100
Message-ID: <4B223B13.8050502@langendorff.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
	[213.251.177.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B7CC244C7
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 13:28:31 +0100 (CET)
Received: from [82.210.249.81] (helo=[10.123.23.32])
	by inca-roads.misterjones.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <linux@langendorff.nl>)
	id 1NJ4gr-0006Rn-Ls
	for alsa-devel@alsa-project.org; Fri, 11 Dec 2009 13:33:45 +0100
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

for a samsung based project we have chosen two codecs, one for input, 
the other for output. The two codecs are using the same I2S bus due to 
audio requirements (HF audio in combination with EC)

When having two machine implementations at the same time for the two 
codecs we will run into problems attaching to the I2S bus. A solution is 
to combine the machine implementation into one file, but then I probaly 
have to modify generic kernel code.

I there some solution for this and/or example code

Thanks in advance,


Niels Langendorff
