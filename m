From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Need help diagnosing "hw_ptr skipping" message
Date: Wed, 17 Jul 2013 16:02:37 +0200
Message-ID: <51E6A3FD.9070405@ladisch.de>
References: <51824609.30405@canonical.com> <1367498241.8766.3.camel@localhost>
 <5182746C.1070603@topic.nl> <5187AEA5.1020108@ladisch.de>
 <51A49907.70105@topic.nl> <20130529194211.GB5180@sirena.org.uk>
 <51A84AC2.5070702@topic.nl> <51E54E82.5030402@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 1308C26549E
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 16:02:43 +0200 (CEST)
In-Reply-To: <51E54E82.5030402@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mike Looijmans wrote:
> If I enable the "jiffies check", what is my driver doing wrong if I
> get this complaint on the kernel log while capturing:
>
> PCM: hw_ptr skipping! (pos=13677, delta=876, period=6400, jdelta=0/17/0, hw_ptr=1241601/1241601)

"hw_ptr skipping" means that the hw_ptr is skipping.  Er, the value
returned by the .pointer callback moves too far in a too short amount
of time.

> hwptr log: pcmC6D0c:0 [Q]: j=19310, pos=12801/6400/25600, hwptr=1236601/1228800
> hwptr log: pcmC6D0c:0 [ ]: j=19310, pos=13677/6400/25600, hwptr=1241601/1228800

The interrupt and the userspace check happen at almost the same time
(same jiffies value), but there is suddenly a jump of 876 frames.

How does your driver compute the .pointer return value?  How does this
value change?


Regards,
Clemens
