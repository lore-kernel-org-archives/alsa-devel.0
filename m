From: David Olofson <david@olofson.net>
Subject: Re: jerks
Date: Mon, 12 Dec 2005 21:14:21 +0100
Message-ID: <200512122114.21933.david@olofson.net>
References: <1134063707.13439.37.camel@snuk.slsware.lan>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1134063707.13439.37.camel@snuk.slsware.lan>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 08 December 2005 18.41, Glenn English wrote:
[...]
> Every few seconds, at seemingly random times, everything freezes for
> ~50ms. Even the mouse. Sometimes. Reliable at the first card moved
> in Aisle Riot Solitaire and when Jack is running. Often when I'm
> typing email (chars don't get from the keyboard to the screen).
[...]

This reminds a bit of something I saw when I made some RTAI latency=20
tests on the Mini-ITX motherboards we're putting in our rheometers. I=20
would get random latency peaks of anything from a few hundred =B5s=20
through tens of ms.

Turns out the integrated ethernet implementation is a slightly broken,=20
and has the interface send interrupts to the CPU even if you disable=20
it in the BIOS! Linux "handles" it without freezing indefinitely, but=20
even RTAI hard RT kernel threads are locked out for a moment every=20
now and then.

Solution: I just installed the driver for the NIC!

We use ethernet for communicating with the instruments anyway, but as=20
this project haven't been enough of a PITA already, I just *had* to=20
test the RT performance *first*, just so I could discover this scare-=20
the-h*ll-out-of-control-engineers special feature... :-D


So, bottom line: Never trust "disabled" PCI devices.


//David Olofson - Programmer, Composer, Open Source Advocate

=2E- Audiality -----------------------------------------------.
|  Free/Open Source audio engine for games and multimedia.  |
| MIDI, modular synthesis, real time effects, scripting,... |
`-----------------------------------> http://audiality.org -'
   --- http://olofson.net --- http://www.reologica.se ---


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
