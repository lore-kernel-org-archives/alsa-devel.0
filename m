From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/3] ALSA: usb: move ua101 driver
Date: Mon, 1 Mar 2010 15:01:29 +0100
Message-ID: <20100301140129.GI28972@buzzloop.caiaq.de>
References: <1267194883-6854-1-git-send-email-daniel@caiaq.de>
	<1267194883-6854-2-git-send-email-daniel@caiaq.de>
	<4B8BA4A3.1060506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F3A610385A
	for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2010 15:01:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B8BA4A3.1060506@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 01, 2010 at 12:27:31PM +0100, Clemens Ladisch wrote:
> Daniel Mack wrote:
> > As part of the USB audio code cleanup, move the non-standard ua101
> > driver out of the way.
> 
> A directory with a single source file in it isn't quite an improvement.
> Please name it "misc" so that other specialized drivers could be put in
> there.

Ok, will do. However, I wonder which way is best to do that. Given that
you posted patches on top of mine, can I take this as a general
agreement to my changeset? If so, I will just provide a patch on top to
do the ua101 -> misc rename, because otherwise, I would have to rebase
all three patches for that.

Daniel
