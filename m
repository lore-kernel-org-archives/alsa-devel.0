From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC][PATCH v2 00/13] speakers: Add support for
 capture/playback of PCM/MIDI
Date: Sun, 12 Jan 2014 13:35:08 +0100
Message-ID: <20140112133508.6894fe70@stein>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
 <52D01586.10806@ladisch.de> <s5hsisvx21s.wl%tiwai@suse.de>
 <52D01D47.4030004@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 26C1A261A7F
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 13:35:14 +0100 (CET)
In-Reply-To: <52D01D47.4030004@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jan 11 Takashi Sakamoto wrote:
> (Jan 11 2014 00:57), Takashi Iwai wrote:
>  > Yeah, module names aren't that important.  And you can put
>  > MODULE_ALIAS("snd-firewire-speakers"), if any.
> 
> OK. I decide to rename the driver to 'snd-oxfw, and add the alias.

I agree that it should be renamed, and 'snd-oxfw' looks good to me.  The
module alias wouldn't even be strictly necessary for a driver like this
(probably not present in initrd images etc.), but it doesn't hurt to
include it.

The constants which patch 13/13 adds to include/uapi/sound/{asound,firewire}.h
should of course be named accordingly then.
-- 
Stefan Richter
-=====-====- ---= -==--
http://arcgraph.de/sr/
