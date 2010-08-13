From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Pops, Clicks on Capture w/ S/PDIF,
 Cirrus Logic CS4207, HDA
Date: Fri, 13 Aug 2010 09:06:57 +0200
Message-ID: <4C64EF11.8000407@ladisch.de>
References: <69FA8BA3444DD443841AF768F2F6C65A12490213C9@SERVER2.righthandtech.local>
	<4C639AAB.5050606@ladisch.de>
	<69FA8BA3444DD443841AF768F2F6C65A1249021427@SERVER2.righthandtech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D4EDC103805
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 09:06:35 +0200 (CEST)
In-Reply-To: <69FA8BA3444DD443841AF768F2F6C65A1249021427@SERVER2.righthandtech.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dave Zielinski <DZielinski@righthandtech.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dave Zielinski wrote:
> Yes prior location is exactly 1 buffer_size! - which is this case was
> 16384.  But what does that mean? 

It means that the controller did not actually write to that part of the
buffer before it updated the buffer pointer.  This appears to be a HDA
controller bug which must be worked around in the controller driver.


Regards,
Clemens
