From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sound: hdmi: avoid dereferencing
	uninitialized 'jack' pointer
Date: Wed, 24 Feb 2016 17:39:02 +0100
Message-ID: <2576612.maDBOzAeKt@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <3238725.1iS2dg6EkI@wuerfel> <s5hziuqcby1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by alsa0.perex.cz (Postfix) with ESMTP id D34102606F6
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 17:39:27 +0100 (CET)
In-Reply-To: <s5hziuqcby1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Han Lu <han.lu@intel.com>, Libin Yang <libin.yang@linux.intel.com>, Thierry Reding <treding@nvidia.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 24 February 2016 17:25:42 Takashi Iwai wrote:
> 
> Thanks for catching this.  Yes, your fix is correct.  This must have
> been a wrong pick up when converting from the standalone hda jack to
> unified jack stuff.
> 
> Could you send a proper patch for inclusion?

Ok, done.

	Arnd
