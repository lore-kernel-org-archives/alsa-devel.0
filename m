From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Pending patches for 1.0.15
Date: Fri, 21 Sep 2007 08:31:16 +0200
Message-ID: <1190356276.15047.1211823011@webmail.messagingengine.com>
References: <s5hbqbyjuyd.wl%tiwai@suse.de>
	<1190270397.1203.1211622015@webmail.messagingengine.com>
	<s5hmyvhr6gm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 2350F1037FC
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Sep 2007 08:31:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmyvhr6gm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > Takashi Iwai wrote:
> > > we're planning to release 1.0.15rc3 tomorrow.  This should be the
> > > last candidate before 1.0.15 (hopefully).
> > 
> > emu10k1 doesn't work with older kernels because of the kthread stuff.
> 
> Doesn't work or build error?

Doesn't load because the kernel doesn't have the kthread_* functions.

> As a simplest workaround, we can put if KERNEL_VERSION >= 2.6.0 for
> the relevant part as a patch.

Okay, did that, and a bunch of other compatibility hacks.


Regards,
Clemens
