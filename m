From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Roland/Edirol M-16DX
Date: Fri, 14 Nov 2008 09:12:48 +0100
Message-ID: <491D3300.5050405@ladisch.de>
References: <487F10EE.6030405@trn.iki.fi> <48883AAC.6060101@ladisch.de>	
	<4917B029.7010809@trn.iki.fi> <491C6E10.7090308@trn.iki.fi>
	<1226624101.4836.95.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 839D62434D
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 09:12:39 +0100 (CET)
In-Reply-To: <1226624101.4836.95.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Trevelyan <james@jamestrev.com>
Cc: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+cv5n@trn.iki.fi>, james@jamestrevelyan.com, alsa-devel@alsa-project.org, timc@wnsp.com
List-Id: alsa-devel@alsa-project.org

James Trevelyan wrote:
> ...
> However, what I did notice is that in all circumstances the windows
> driver was capturing at the same time as playback, even when I was not
> asking it to record.  This suggests to me that the comment in the driver
> source about synchronising playback to capture has some relevance ...

Indeed.  The driver would have to send the data at the exact speed of
the device's internal clock, and the only way to determine that clock's
speed is to capture data.

So far I haven't found the time to rewrite the driver to support this
synchronization mechanism.


Best regards,
Clemens
