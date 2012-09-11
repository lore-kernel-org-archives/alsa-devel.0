From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Channel map API patches: to be 3.7 or not to be?
Date: Tue, 11 Sep 2012 14:19:49 +0200
Message-ID: <504F2C65.1090204@ladisch.de>
References: <s5hk3w1g4e2.wl%tiwai@suse.de>
 <CAN8cciYtoH91sFjwes+aTAjO+4z8CCMdOYgM4kdWbGNr3iuheQ@mail.gmail.com>
 <s5hbohdezpc.wl%tiwai@suse.de> <s5hehm8rc2s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B697A2602C4
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 14:19:51 +0200 (CEST)
In-Reply-To: <s5hehm8rc2s.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> BTW, this reminds me of an open question:
>   is it useful to add SND_CHMAP_MONO, or is it just redundant?
>
> It's nothing but indicating a mono channel without any channel
> position, so I supposed SND_CHMAP_UNKNOWN being sufficient.  OTOH,
> SND_CHMAP_MONO would give a clear sign of mono streams while
> SND_CHMAP_UNKNOWN could be used for any other exceptional purposes.

What would it be used for?

Labeling surround channels is necessary for reordering them or for doing
up/downmixing.  A "mono" channel, however, does not appear to have any
semantic difference from a single "unknown" channel.


Regards,
Clemens
