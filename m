From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 2/3] ALSA: hda - Move in_pm accessors to
	HDA core
Date: Wed, 27 Jun 2018 10:38:40 +0100
Message-ID: <153009232054.8693.169642523536241126@mail.alporthouse.com>
References: <20180627091034.22724-1-tiwai@suse.de>
 <20180627091034.22724-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C73F267962
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 11:38:46 +0200 (CEST)
In-Reply-To: <20180627091034.22724-3-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Quoting Takashi Iwai (2018-06-27 10:10:33)
> The in_pm atomic in hdac_device is an important field used as a flag
> as well as a refcount for PM.  The existing snd_hdac_power_up/down
> helpers already refer to it in the HD-audio core code, while the code
> to actually setting the value (atomic_inc() / _dec()) is open-coded in
> HDA legacy side, which is hard to find.
> 
> This patch adds the helper functions to set/reset the in_pm counter to
> HDA core and use them in HDA legacy side, for making it clearer who /
> where the PM is managed.
> 
> There is no functional changes, just code refactoring.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Mechanical code change that helps explain what it is doing,
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
