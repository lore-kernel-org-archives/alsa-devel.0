From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_sw_params_set_xfer_align replacement?
Date: Mon, 21 Jul 2008 10:37:09 +0200
Message-ID: <48844AB5.9010908@ladisch.de>
References: <20080718192315.GU835@arwen.poofy.goof.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 24A32245DD
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 10:37:17 +0200 (CEST)
In-Reply-To: <20080718192315.GU835@arwen.poofy.goof.com>
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
> snd_pcm_sw_params_set_xfer_align() has been deprecated but the docs
> don't mention what it was replaced with.

There is no replacement; the transfer alignment always is one frame,
i.e., there is none.

> I don't ever want or need partial reads and writes

You get partial reads/writes only when you ask for it (by using non-
blocking mode) or when an error occurs.


HTH
Clemens
