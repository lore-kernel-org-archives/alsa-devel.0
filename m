From: Jason Fox <jfox@gai-tronics.com>
Subject: ASOC: AD193X, AT91SAM9263 and Channel Slot Shifting
Date: Thu, 17 Feb 2011 08:30:19 -0500
Message-ID: <1297949419.7194.55.camel@alice.bigman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exprod7og117.obsmtp.com (exprod7og117.obsmtp.com [64.18.2.6])
	by alsa0.perex.cz (Postfix) with SMTP id AF0712438A
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 14:31:35 +0100 (CET)
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

I am currently working with an AD1939 being driven by an AT91SAM9263 and
currently configured for 4 channels. The AT91 is successfully sending
data to to the CODEC but the DMA transfer is not correctly synchronized
to the LRCLK frame sync.  So, the data for channel 0 might show up in
slot 1, 2, 3 - or sometimes slot 0 where it belongs!  Can anyone give me
a suggestion as to where I might look in the drivers to debug this frame
sync problem?  My hardware engineer assures me that the AT91 SSC and
AD1939 are configured correctly which regard to LRCLK and BCLK.

Thanks!

Jason Fox 
*******************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager. This footnote also confirms that this
email message has been swept for the presence of computer viruses.
www.Hubbell.com - Hubbell Incorporated**
