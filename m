From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: Hammerfall (hdsp) initialization problem
Date: Tue, 27 Jul 2004 12:07:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090944426.4065.10.camel@modemcable182.55-70-69.mc.videotron.ca>
References: <1090607568.17750.7.camel@modemcable182.55-70-69.mc.videotron.ca>
 <20040724100520.26b4ac8f@laptop>
 <1090734488.3156.2.camel@modemcable182.55-70-69.mc.videotron.ca>
 <1090754189.15178.8.camel@localhost> <s5hbri15zpj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hbri15zpj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thomas Charbonnel <thomas@undata.org>, Tim Blechmann <TimBlechmann@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> The problem is that you have to know the PCI pointer to call
> dma_alloc_coherent() correctly beforehand.  Otherwise you'll get on=
ly
> ZONE_DMA under 16MB region.

Still, there must be *something* that can be done, no? What are other
OSs doing about that? I mean, the card manual doesn't say "if you ins=
ert
this card after boot, it won't work", so I don't see why ALSA
fundamentally couldn't support hot-plugging cards.

=09Jean-Marc

--=20
Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Universit=E9 de Sherbrooke




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
