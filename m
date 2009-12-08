From: Marc Garnier <marc.garnier@heig-vd.ch>
Subject: How to use soc API without codec driver
Date: Tue, 8 Dec 2009 15:46:53 +0100
Message-ID: <4B1E66DD.1000906@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heig-vd.ch (mailcl1.heig-vd.ch [193.134.216.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F3D2103859
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 15:46:54 +0100 (CET)
Received: from [10.192.41.20] (helo=eintfe01.einet.ad.eivd.ch)
	by mailcl1.heig-vd.ch stage1 with esmtp (Exim MailCleaner)
	id 1NI1L4-0006b0-8B for <alsa-devel@alsa-project.org>
	from <Marc.Garnier@heig-vd.ch>; Tue, 08 Dec 2009 15:46:54 +0100
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

I need to receive and transmit PCM data through SSC port of a sam9261 to 
a device which doesn't have any kind of I/O controls (neither i2c nor 
spi). So, I wonder how to deal with the codec driver side.
Someone could explain me what are the minimum requirements to write a 
Asoc driver of this kind?
