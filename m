From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: ATI IXP Modem driver
Date: Mon, 12 Jul 2004 19:54:50 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040712195450.04494434@sashak.lan>
References: <1083465072.1639.8.camel@server.gowanlea.net>
	<20040503163657.668357a9@sashak.lan>
	<1087962001.4844.0.camel@server.gowanlea.net>
	<20040711191833.462a0b4b@sashak.lan>
	<s5hr7rhcztt.wl@alsa2.suse.de>
	<20040712162839.2c58e1c3@sashak.lan>
	<s5hd631cq5v.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd631cq5v.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: unixtricks@btinternet.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Jul 2004 15:26:36 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> 
> > > I believe the best way would be to provide "modem" pcm for each
> > > driver, so that the user-space app can access uniformly without
> > > caring the device number, conversion, etc.
> > 
> > Exactly, this would be best solution. But how to do it? Permanent
> > configuration? Changes in PCM layer?
> 
> Adding a system config file such as
> /usr/share/alsa/cards/ATIIXP-MODEM.conf.
> Simiarly, we can add the definition in ICH-MODEM.conf and
> NFORCE-MODEM.conf

Great, so simple.

> (any other known working modem drivers?)

Not yet (hope it will).

Best Regards,
Sasha.



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
