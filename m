From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Support for SND_PCM_IOPLUG_FLAG_LISTED
Date: Wed, 30 Mar 2005 10:05:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0503300957250.1757@pnote.perex-int.cz>
References: <1112169052.9016.229.camel@pegasus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1112169052.9016.229.camel@pegasus>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Mar 2005, Marcel Holtmann wrote:

> Hi guys,
> 
> actually the SND_PCM_IOPLUG_FLAG_LISTED is available inside the PCM IO
> plugin stuff, but the core seems not to care about it. Is it possible to
> include support for that before the final 1.0.9 release?

The API giving list of available device names is still not available and
it does not seem to me a good idea to add it now. Hopefully, it will be
included to 1.0.10.

Also, I don't understand too much the presence of this flag, because this
behaviour (listed / not listed) should be described in configuration files 
not in plugins. Takashi, could you give me a light for this?

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
