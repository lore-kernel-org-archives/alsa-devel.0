From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/3] ALSA: snd-usb-caiaq: set up internal
 sample pointer positions in trigger callback
Date: Fri, 10 Sep 2010 10:10:10 +0200
Message-ID: <20100910081010.GN7159@buzzloop.caiaq.de>
References: <1284090901-4533-1-git-send-email-daniel@caiaq.de>
	<1284090901-4533-2-git-send-email-daniel@caiaq.de>
	<4C89DDF4.8030200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 28B62103939
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 10:10:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C89DDF4.8030200@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 09:27:48AM +0200, Clemens Ladisch wrote:
> Daniel Mack wrote:
> > Calling prepare() on a stream which is already active
> 
> ... would be a bug; snd_pcm_pre_prepare() in sound/core/pcm_native.c
> should prevent this.  Why do you feel the need for this patch?

You're right, thanks for the heads-up. It was indeed a bug in a
different part of my driver which only affected the newly added model it
supports. I was increasing the periods counter for inactive streams,
which confused the ALSA core.

Forget about this one, I'll repost a new series in a second.

Thanks,
Daniel
