From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Support for SND_PCM_IOPLUG_FLAG_LISTED
Date: Wed, 30 Mar 2005 10:30:41 +0200
Message-ID: <1112171441.9016.246.camel@pegasus>
References: <1112169052.9016.229.camel@pegasus>
	 <Pine.LNX.4.58.0503300957250.1757@pnote.perex-int.cz>
	 <1112170324.9016.240.camel@pegasus>
	 <Pine.LNX.4.58.0503301018460.1757@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0503301018460.1757@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

> > in the case of the Bluetooth A2DP and Headset plugins, these will look
> > like virtual soundcards and thus we know that they should be listed all
> > the time. So this flag simply says "list me always" no matter what a
> > config file says. I actually discussed this with Takashi some time ago
> > and there should be thread about it in the mailing list archive.
> 
> Yep, but the current alsa-lib configuration scheme is different. There
> must be a definition in a configuration file (for example in global
> /usr/share/alsa/alsa.conf) with PCM specification pointing to specific
> plugins (no matter if it's the physical or virtual card). It's better to 
> avoid probing the plugins to give us such flags, because we can specify 
> this in the global configuration file directly.

that is right. We need an entry in the config file to specify the
BD_ADDR of the headphone or headset anyway. However we need at least
some kind of way to list a plugin. Otherwise some stupid programs will
not allow you to select this audio source.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
