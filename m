From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: userspace pcm/midi for firewire based cards
Date: Tue, 16 Nov 2004 08:47:55 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411160837260.755-100000@studcom.urz.uni-halle.de>
References: <4198FC54.7000309@esat.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4198FC54.7000309@esat.kuleuven.ac.be>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pieter Palmers <ppalmers@esat.kuleuven.ac.be>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pieter Palmers wrote:
> I'm working on the development of DM1000 based firewire based devices
> (ESI QuataFire 610, M-Audio FireWire devices, ...).
> The question that arises is: userspace driver or kernel driver.
> Personally I favor the userspace driver, because we can use the FW libs
> that are already present for some of the stuff. On the other hand it
> seems to me that programming a kernel driver would be ?easier? than
> implementing a plugin.

Probably not, both plugins and kernel drivers implement more or less
the same stuff.

> If I'm right, that would require providing all interfaces/
> capabilities the alsa-lib middle layer provides.

No, the PCM plugin interface isn't that big.  Look at the plugins in
the alsa-lib/src/pcm directory (pcm_null.c is very simple).

> what about the latency/realtime behaviour of the two options?

You get the function calls made by the applications, the latency
depends on what your plugin does with the data.  I'd guess the
bottleneck would be the userspace firewire library.

> Is there an equivalent plugin mechanism for MIDI stuff?

rawmidi devices are implemented as plugins (currently, there are "hw"
and "virtual" plugins).  Or you could implement a sequencer client
(see <http://www.informatik.uni-halle.de/~ladischc/usbmidid_old.html>
for an (obsolete) userspace USB MIDI driver).


Best regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
