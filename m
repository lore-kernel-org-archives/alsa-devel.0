From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Mon, 16 Jun 2003 08:03:16 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Rscp-00056Q-00@sc8-sf-list1.sourceforge.net>
References: <3EED78E2.1050503@folkwang-hochschule.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 16 Jun 2003 09:59:30 +0200."
             <3EED78E2.1050503@folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>maybe i should consider dropping 14-bit resolution (the crappy faders on 
>the peavey hardly manage 127 distinct positions) and just use the MSB 
>part of the 14bit controller. ardour does perform lowpass filtering of 
>controller values, right ?

it doesn't filter the values directly, but the various things that use
them do interpolate. for example, if you bind to a gain fader, there
is no smoothing of the changes in terms of what is sent to the core,
but the core will interpolate to avoid zipper noise. this is so that
the interpolation is centralized, and we don't have to care where gain
changes (for example) come from.

when bound to plugin parameters, its really up to the plugin
author. most of steve's set interpolate where necessary.

--p



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
