From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: 1ca3d59d5a3e762fb1c002bcd912914bc858b430 broke
 passthrough [Was: Re: ALSA 1.0.25 broke AC3 passthrough?]
Date: Tue, 14 Feb 2012 21:58:37 -0600
Message-ID: <4F3B2D6D.20400@linux.intel.com>
References: <CANpj82JKFx1YXgaY3HZyTSyCZs83ZdvEtYGAbNJPdb6q7qN7kg@mail.gmail.com>
	<4F37BBDD.1090207@iki.fi>
	<CANpj82J+MmYNGbOqmFMCA587sCiUZfjRqDfesfmOG616478SqQ@mail.gmail.com>
	<s5h39ae3lhk.wl%tiwai@suse.de>
	<CANpj82Ktb8BZiOA50HuR5r0n6NpHk+Y5Bt0uU+mk=01q4VdAPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A342103D82
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 04:58:14 +0100 (CET)
In-Reply-To: <CANpj82Ktb8BZiOA50HuR5r0n6NpHk+Y5Bt0uU+mk=01q4VdAPg@mail.gmail.com>
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


> Is the issue believed to be related to nvidia hdmi only ? I just got 
> the report from a user stating that he had issue playing audio on his 
> Dell Vostro 200, which is pure intel

This is surprising, the hardware folks at Intel confirmed the rounding 
to multiple of 128 bytes is not needed and this patch has been there for 
over 6 months now without generating any complaints. Can you get us more 
information on that case, and ask this user to see what happens by 
enabling this rounding again.
Thanks,
-Pierre
