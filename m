From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Application supporting forward/rewind APIs
Date: Tue, 29 Sep 2009 11:42:38 +0200
Message-ID: <4AC1D68E.7040702@ladisch.de>
References: <2ee9e08d0909240034t6fdab6aftc24e733621638f09@mail.gmail.com>
	<s5hocp0vlm6.wl%tiwai@suse.de>	<4f3252890909240057l1a2b5b88m861dea551f69afce@mail.gmail.com>
	<2ee9e08d0909240201l5cf5675m111b6da1434cff60@mail.gmail.com>
	<4f3252890909252059t3d8cc2aaqffc880991d148e56@mail.gmail.com>
	<2ee9e08d0909290213r3ca53b6cq5909bcf79752a26c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D3E80103845
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 11:42:42 +0200 (CEST)
In-Reply-To: <2ee9e08d0909290213r3ca53b6cq5909bcf79752a26c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anuj Aggarwal <anuj.aggarwal@gmail.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Anuj Aggarwal wrote:
> I found the solution, one can use mplayer to test forward/rewind
> feature of ALSA library.

mplayer disables ALSA's underrun detection and uses snd_pcm_forward() to
recover from an underrun, if it happens.

(To force an underrun, press Ctrl+S (then Ctrl+Q) to prevent mplayer
from updating its status line.)


HTH
Clemens
