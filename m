From: David Douglas <one51s@yahoo.com>
Subject: Re: spdif/iec958 outputs at VT1708S not recognized
Date: Wed, 29 Apr 2009 15:19:06 +0000 (UTC)
Message-ID: <loom.20090429T150759-280@post.gmane.org>
References: <gt9gvo$ocq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6988C24496
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 17:20:03 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LzBZr-0004VE-4N
	for alsa-devel@alsa-project.org; Wed, 29 Apr 2009 15:20:03 +0000
Received: from mnch-5d87371b.pool.einsundeins.de ([93.135.55.27])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 15:20:03 +0000
Received: from one51s by mnch-5d87371b.pool.einsundeins.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 15:20:03 +0000
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

Peter Niemayer <niemayer <at> isg.de> writes:
> I recently installed an Asus M4N78 mainboard, that uses a
> nVidia GeForce 8300 chipset and a VT1708S soundchip.
>
> I had to short circuit the pin definition
> in vt1708S_parse_auto_config() to get the digital outputs
> to work:
> 
>          spec->multiout.max_channels = spec->multiout.num_dacs * 2;
> 
> -       if (spec->autocfg.dig_out_pin)
> +       // test fails for Asus M4N78 if (spec->autocfg.dig_out_pin)
>                  spec->multiout.dig_out_nid = VT1708S_DIGOUT_NID;
> 
>          spec->extra_dig_out_nid = 0x15;


Hi Peter,

I'm a relative Linux newbie trying to get away from Windows.  But longtime
computer geek.  I have an issue with my Asus M4A78 (same as yours but ATI
graphics), that the LFE channel works in speaker-test but has no output from
applications (even when they should output 5.1, like a DVD in VLC).

I believe that some layer, maybe even the hw, is remixing to 5 (minus the .1)
without being asked, as even CD sound plays over all five speakers.  And there
is no gui configuration program I can find to specify such a remixing (which I
am sure the soundcard is capable of).

Currently I am trying an upgrade (via script from ubuntu forums) to the latest
Alsa, from .18 to .19.  If that doesn't resolve (and I don't expect it to): I am
curious if you got 5.1 working properly with your soundcard.  Also the SPDIF
would be an option for me, can I ask the location of that code you mentioned? 
(If it's a config file and you wouldn't mind posting yours, would be fantastic).

I have been under the impression that the 1708S is not explicitly supported by
Alsa, because it's not yet listed in the Alsa-project homepage list  :-/

Many thanks,
Dave
