From: Dan Christensen <jdc@uwo.ca>
Subject: Re: wrong channel mappings for HDMI audio
Date: Fri, 12 Nov 2010 19:26:11 -0500
Message-ID: <87hbfmkr18.fsf@uwo.ca>
References: <87fwv8puuo.fsf@uwo.ca> <4CDDBA8C.30600@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FE82103916
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 01:26:28 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PH3wm-000652-Ex
	for alsa-devel@alsa-project.org; Sat, 13 Nov 2010 01:26:24 +0100
Received: from bas3-london14-1096778080.dsl.bell.ca ([65.95.129.96])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 01:26:24 +0100
Received: from jdc by bas3-london14-1096778080.dsl.bell.ca with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 01:26:24 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Anssi Hannula <anssi.hannula@iki.fi> writes:

> This is a known issue, the NVIDIA MCP79/7A HDMI hardware has incorrect
> channel mapping.
>
> I reported this several months ago as "Wrong channel order with
> multichannel HDMI on MCP7A":
> http://www.spinics.net/lists/alsa-devel/msg35948.html
> (there are some earlier reports from 2009 as well)

Great, thanks for confirming it's not just me.

> I'm using this workaround at the moment:
>  pcm.!hdmi {
>      type             route
>      slave.pcm "cards.HDA-Intel.pcm.hdmi.0:CARD=NVidia,AES0=0x4,AES1=0x82,AES2=0x0,AES3=0x2"
>      ttable.0.0 1
>      ttable.1.1 1
>      ttable.2.4 1
>      ttable.3.5 1
>      ttable.4.2 1
>      ttable.5.3 1
>      ttable.6.6 1
>      ttable.7.7 1
>  }

I can confirm that this fixes things for me.

> (not a perfect workaround as I'm hardcoding AESx instead of using the
> ones provided as arguments, but at least you get the idea)

I don't understand this comment, but hopefully if I just put the above
in my asound.conf, all should be fine, right?

> As for the preferred solution to this problem, as far as I understand,
> that would be for the driver to have some ioctl that would provide
> alsa-lib information about the unusual channel mapping, and alsa-lib
> could then remap the channels using a channel remapping plugin.

Alternatively, can the fix just be hardcoded for this audio card?

Dan
