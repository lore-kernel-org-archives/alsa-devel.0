From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 3/3] ALSA: usb-audio: support multiple
 formats with audio class v2 devices
Date: Mon, 01 Mar 2010 16:26:31 +0100
Message-ID: <4B8BDCA7.8030301@ladisch.de>
References: <1267194883-6854-1-git-send-email-daniel@caiaq.de>	<1267194883-6854-2-git-send-email-daniel@caiaq.de>	<1267194883-6854-3-git-send-email-daniel@caiaq.de>	<1267194883-6854-4-git-send-email-daniel@caiaq.de>	<4B8BA4BA.8040609@ladisch.de>
	<20100301142634.GK28972@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 1FB02103857
	for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2010 16:26:34 +0100 (CET)
In-Reply-To: <20100301142634.GK28972@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On Mon, Mar 01, 2010 at 12:27:54PM +0100, Clemens Ladisch wrote:
> > Change the parser to correctly handle v2 descriptors with multiple
> > format bits set.
> 
> I got compile errors with that one, and needed the patch below to fix
> them.

Sorry, my branch already moved the UA-1000 support into the ua101
driver.

> Want to squash that into your commit and resend?

I guess the UA-1000 change will be merged sooner.


Regards,
Clemens
