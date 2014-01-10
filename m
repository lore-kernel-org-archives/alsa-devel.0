From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH v2 00/13] speakers: Add support for
 capture/playback of PCM/MIDI
Date: Fri, 10 Jan 2014 16:45:10 +0100
Message-ID: <52D01586.10806@ladisch.de>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 13F65265505
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:45:14 +0100 (CET)
In-Reply-To: <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> In previous series of patch, I showed an idea to add a new driver for
> OXFW970/971. This driver can support some recording equipments.
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/070705.html
>
> ALSA already has a driver, firewire-speakers for these chipsets. But it
> supports PCM playback only. The devices need support for capture/playback of
> PCM/MIDI.
>
> According to maintainer's advice, I'll add these functionality to
> firewire-speakers.

That driver is called "firewire-speakers" because it is for playback-
only devices.

But there is exactly one known user, so I'd guess it would be okay
to rename it.


(And I really have to review all these patches some day ...)


Regards,
Clemens
