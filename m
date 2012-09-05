From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [RFC] Channel mapping API (take 2)
Date: Wed, 05 Sep 2012 09:38:26 +0300
Message-ID: <1346827106.3629.40.camel@laptop>
References: <s5hhard23jb.wl%tiwai@suse.de> <1346824812.3629.29.camel@laptop>
 <s5hligpj8mv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0DD932652F8
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 08:38:29 +0200 (CEST)
In-Reply-To: <s5hligpj8mv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-09-05 at 08:17 +0200, Takashi Iwai wrote:
> Well, this raises a question "What is mono".
> If this is supposed to be a channel position, then we should add the
> definition.  But is it really so?  If it's a mono stream mixed from
> front left and front right, isn't it a front center?

If it's a playback stream and alsa knows that it will be routed to a
center speaker on a surround system, then yes, it should be front
center. But if the audio ends up in a lone speaker, mixing left and
right doesn't really result in a center position.

I think mono means pretty much "single channel without defined
position", for which SND_CHMAP_UNKNOWN could be a useful choice, except
that I think PulseAudio will end up ignoring channels with
SND_CHMAP_UNKNOWN, because there's no sane definition for how channel
remapping should be done for such channels. But maybe the single channel
case could be treated as an exception - a single channel with
SND_CHMAP_UNKNOWN could be treated as a mono device, for which
downmixing (or upmixing in case of capture) is well defined.

-- 
Tanu
