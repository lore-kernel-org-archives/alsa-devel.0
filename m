From: Ron Cococcia <ron.cococcia@request.com>
Subject: Re: intel8x0 dual codec issue
Date: Thu, 24 Feb 2005 17:10:53 -0500
Message-ID: <421E50ED.2000906@request.com>
References: <4208437B.3080207@request.com>	<s5h8y5w1g2b.wl@alsa2.suse.de>	<420BB2FC.6070502@request.com> <s5hoeerz9dv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hoeerz9dv.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

<snip>

> Given that overriding codecs with NCR becomes popular, it might be
> nice to have a module option to specify the codecs as bitmask.
> The below is a quick hack.

I finally got a chance to try out the patch.  It oopsed, but it was one
small change to make it work.  In intel8x0.c, in snd_intel8x0_hw_params,
near the bottom it tries to "Force SPDIF setting", but on codec[0],
instead of codec[chip->first_codec].  I made that small change and it
hasn't crashed yet.

One noticeable difference is in the mixer control.  All controls in the
mixer (alsamixer) are "Master 1", "PCM 1" (which is OK, I was seeing
this before, and it would also have "Master" for the primary codec).
The difference is that, besides having a "PCM 1" control, there is also
a "PCM" control.  amixer scontrols shows:

Simple mixer control 'Master',1
Simple mixer control 'Master Mono',1
Simple mixer control 'Headphone',1
Simple mixer control '3D Control - Center',1
Simple mixer control '3D Control - Depth',1
Simple mixer control '3D Control - Switch',1
Simple mixer control 'PCM',0
Simple mixer control 'PCM',1
Simple mixer control 'Line',1
Simple mixer control 'CD',1
Simple mixer control 'Mic Boost (+20dB)',1
Simple mixer control 'Mic Select',1
Simple mixer control 'Mic',1
Simple mixer control 'Video',1
Simple mixer control 'Phone',1
Simple mixer control 'IEC958',1
Simple mixer control 'PC Speaker',1
Simple mixer control 'Aux',1
Simple mixer control 'Mono Output Select',1
Simple mixer control 'Capture',1
Simple mixer control 'Mix',1
Simple mixer control 'Mix Mono',1
Simple mixer control 'External Amplifier',1

The "PCM" control limits are 0-255, where the "PCM 1" limits are 0-31
(normal).  Adjusting both affects the output levels.

Unfortunately, I am not versed well enough to figure out what is 
happening with this.  Any hint as to where I might look 
(pci/ac97/ac97_codec.c or similar)?

Thanks,
Ron



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
