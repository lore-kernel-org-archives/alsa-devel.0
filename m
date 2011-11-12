From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SPDIF receiver with dynamically changing sample
 rate
Date: Sat, 12 Nov 2011 16:36:14 +0100
Message-ID: <4EBE926E.8030603@ladisch.de>
References: <loom.20111112T133210-522@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 2502F103807
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2011 16:36:25 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 28636206A2
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2011 10:36:23 -0500 (EST)
In-Reply-To: <loom.20111112T133210-522@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sam Hawkens <Sam.Hawkens@freenet.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sam Hawkens wrote:
> I want to do the following: write an application that has its input fed from an
> SPDIF receiver without using sample rate conversion. The sample rate must not be
> set by the application but must be defined by the SPDIF receiver's PLL.

Most S/PDIF inputs do not resample, but this depends on the hardware.

> Is it possible to run the application continously with ALSA even if the sample
> rate changes?

Most drivers ignore the rate requested by the application and return the samples
as they come from the input.  Only the AK411* drivers monitor the rate and stop
the stream on changes.

> If yes, how can the application notice the change in sample rate?

This is usually not possible without measuring the rate at which samples arrive.
However, you could check the declared rate of the sender by monitoring the
channel status bits.


Regards,
Clemens
