From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sound: hdmi: avoid dereferencing
	uninitialized 'jack' pointer
Date: Tue, 16 Feb 2016 17:09:43 +0100
Message-ID: <2573932.AU4HSxN0NE@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5hbn7g7izt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BE002606C3
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 17:09:59 +0100 (CET)
In-Reply-To: <s5hbn7g7izt.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Han Lu <han.lu@intel.com>, Libin Yang <libin.yang@linux.intel.com>, Thierry Reding <treding@nvidia.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 16 February 2016 16:49:42 Takashi Iwai wrote:
> 
> Thanks for the patch.  But I think it's cleaner to fix Kconfig.
> 
> Thinking more of it, maybe splitting jack stuff as a separate module
> and does reverse-select to CONFIG_INPUT would be better.  Then its
> users can select simply SND_JACK, and everything would fit.
> 
> 

Adding 'select INPUT' is rather nasty, I think that can lead to circular
dependencies, and would likely upset users of small embedded systems
that want to use audio but don't want to use input.

Generally speaking, I would recommend never using 'select' on a user
visible Kconfig symbol.

Another option might would be to change snd_jack_new() to return
an error if that SND_JACK is disabled, and then require all users
to handle the error gracefully, i.e. not fail the probe() function
but just not use the jack.

	Arnd
