From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/4] ALSA: firewire-lib: unify handlers for
 outgoing packet
Date: Fri, 24 May 2019 15:48:06 +0900
Message-ID: <20190524064805.GB25133@workstation>
References: <20190523151440.5127-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D358F89625
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 08:48:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190523151440.5127-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Iwai-san,

I cannot regenerate the conflict you mentioned[1] in my local:

On Fri, May 24, 2019 at 12:14:36AM +0900, Takashi Sakamoto wrote:
> Takashi Sakamoto (4):
>   ALSA: firewire-lib: split helper function to generate CIP header
>   ALSA: firewire-lib: unify packet handler for IT context
>   ALSA: firewire-lib: code refactoring to queueing packets
>   ALSA: firewire-lib: use 8 byte packet header for IT context to
>     separate CIP header from CIP payload
> 
>  sound/firewire/amdtp-stream.c | 150 ++++++++++++++++------------------
>  sound/firewire/amdtp-stream.h |   3 -
>  2 files changed, 69 insertions(+), 84 deletions(-)

I can successfully applied these patches onto either e4e07c6cdca8 ('ALSA:
hdspm: Fix single speed ADAT capture and playback with RME HDSPe AIO')[2] or
947b437e1263 ('ALSA: firewire-lib: unify packet handler for IR context')[3]
in fetched your tree.

Would I request you to try again?

[1][alsa-devel] [PATCH 0/6] ALSA: firewire-lib: unify handlers for incoming packet
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-May/149742.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=for-next&id=e4e07c6cdca8a837ab40363fc8002cf62965a628
[3] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=for-next&id=947b437e1263c81bb5d30a84f1a4a35dbb9f6b78

Thanks


Takashi Sakamoto
