From: Simon Schampijer <Simon.Schampijer@ircam.fr>
Subject: Re: Firewire 410
Date: 09 Mar 2004 19:44:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078857898.19902.39.camel@licorne.ircam.fr>
References: <200403091832.i29IWEPO027305@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403091832.i29IWEPO027305@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Le mar 09/03/2004 =C3=A0 19:32, Paul Davis a =C3=A9crit :
> >At 05 Mar 2004 11:23:35 +0100,
> >Simon Schampijer wrote:
> >>=20
> >> Hello,
> >> I've got a Maudio Firewire 410.
> >> Are you going to make also drivers
> >> for this one ?
> >
> >so far, no ALSA developer works on it.
> >
> >>  Or are there Problems with
> >> Maudio or firewire???
> >
> >unfortunately, no hardware, no datasheet, no time...
>=20
> when i talked with m-audio at NAMM, they claim that their firewire
> interface(s) will be "class compliant". on os-x, for example, there is
> no m-audio firewire driver, just one for the relevant standard for
> audio/midi over 1394. FWIW, Event/Echo and Apogee both said the same
> thing.
>=20
Hi,
I have tried to use the m-audio with the iec61883 jack driver.
After doing some test, I have found that I can have some noise only
after an hot reboot of my powerbook (Mac OS X to Yellowdog Linux) with
the card plugged.

The strange thing is with hot reboot the card does not appear in
/proc/bus/firewire (I haven't the laptop here to check).
With a cold boot or an unplug/plug the card appears in
/proc/bus/firewire but I haven't succesfully made any noise with this
card.

So perhaps there is a firmware uploading in Mac OS X like the RME
Multiface.

Tell me if you need more informations.

Thanks a lot for your help,

best regards,
Simon.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
