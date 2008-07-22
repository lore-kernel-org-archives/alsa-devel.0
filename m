From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_sw_params_set_xfer_align replacement?
Date: Tue, 22 Jul 2008 09:01:54 +0200
Message-ID: <488585E2.7090104@ladisch.de>
References: <20080718192315.GU835@arwen.poofy.goof.com>	<48844AB5.9010908@ladisch.de>
	<20080721183135.GX835@arwen.poofy.goof.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 98588103885
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 09:01:59 +0200 (CEST)
In-Reply-To: <20080721183135.GX835@arwen.poofy.goof.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aaron J. Grier" <agrier@poofygoof.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Aaron J. Grier wrote:
> On Mon, Jul 21, 2008 at 10:37:09AM +0200, Clemens Ladisch wrote:
> > You get partial reads/writes only when you ask for it (by using non-
> > blocking mode) or when an error occurs.
>
> I want non-blocking behavior (return immediately if there is no data
> available), but I don't want to have to deal with partial reads.  I
> figured out a workaround using snd_pcm_avail_update(), but I'm wondering
> if there isn't a better way.

You could write your own read function that calls snd_pcm_read*()
repeatedly until you have as much data as you want, but this is probably
more complex than just checking for data before doing a blocking read.


Regards,
Clemens
