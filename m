From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: External PCM plugin SDK
Date: Wed, 9 Feb 2005 16:25:57 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0502091622080.1891@pnote.perex-int.cz>
References: <s5hd5vau4c3.wl@alsa2.suse.de> <1107958458.13863.43.camel@pegasus>
 <s5hvf91stls.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <s5hvf91stls.wl@alsa2.suse.de>
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
Cc: Marcel Holtmann <marcel@holtmann.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Feb 2005, Takashi Iwai wrote:

> > We also talked about making these IO plugins visible when ALSA is
> > listing its hardware devices. Is this possible now?
> 
> No, it's still in planning.
> We'll need to define a usable API first...

Yes, I'll try to prepare something. The general question is, if we should
describe variable parameters (like card number, device number etc. with 
this API) or if we put only (probably very long list) of available strings 
(device specifications) to applications.

Both ways have own problems (parsing of parameter description) and
the second case might cause that the list will be completely unuseable for
GUI apps.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
