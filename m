From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] sound: usb: mixer: increase control
	transfer timeout
Date: Tue, 27 Sep 2011 08:52:59 +0200
Message-ID: <4E8172CB.8040509@ladisch.de>
References: <1314616226-15942-1-git-send-email-balbi@ti.com>
	<s5hehzht34k.wl%tiwai@suse.de>
	<20110926084935.GJ3391@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de
	[80.67.31.98]) by alsa0.perex.cz (Postfix) with ESMTP id 3829F2439F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 08:52:40 +0200 (CEST)
In-Reply-To: <20110926084935.GJ3391@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: balbi@ti.com
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Felipe Balbi wrote:
> On Fri, Sep 16, 2011 at 08:25:47AM +0200, Takashi Iwai wrote:
> > Felipe Balbi wrote:
> > > 100ms might not be enough for slower devices. Increasing
> > > timeout to 1000ms doesn't seem like overkill.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > 
> > Felipe, what is the status of this patch?
> > Could you resend a revised patch?
> 
> Someone else can take care of it. It was supposed to be a very simple
> patch and became something larger which I don't have enough time to
> handle right now.

Done:
http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=14d1242f90e0


Regards,
Clemens
