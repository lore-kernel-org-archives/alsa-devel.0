From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Pops, Clicks on Capture w/ S/PDIF,
 Cirrus Logic CS4207, HDA
Date: Thu, 12 Aug 2010 08:54:35 +0200
Message-ID: <4C639AAB.5050606@ladisch.de>
References: <69FA8BA3444DD443841AF768F2F6C65A12490213C9@SERVER2.righthandtech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8B34F243D0
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 08:55:03 +0200 (CEST)
In-Reply-To: <69FA8BA3444DD443841AF768F2F6C65A12490213C9@SERVER2.righthandtech.local>
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
> ...
> So now we're getting some audio but it comes with pops and clicks when
> we try to capture.  An analysis of the captured stream shows there are
> corruptions of the data that are 8192 frames apart which I believe are
> the 4096 frame period boundaries (although tough to know for sure).
> When the corruption occurs there seems to be 5 to 7 frames that are
> screwed up.   Also worth noting: these same exact samples appear in
> the stream at a prior location so I think its old buffer data.

How far away is that prior location; exactly buffer_size?

If not, this looks like a bug in the CS4207's RX sample rate converter.
Try disabling it by setting bit 6 in the S/PDIF interface control
register (insert "coef |= 0x0040;" in the init_digital function).


Regards,
Clemens
