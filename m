From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Re: Tascam US-X2Y MIDI  is AWOL?
Date: Wed, 15 Jun 2005 12:29:55 +0100 (WEST)
Message-ID: <40221.192.168.1.5.1118834995.squirrel@www.rncbc.org>
References: <40505.192.168.1.5.1118793043.squirrel@www.rncbc.org>
    <200506150232.29912.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200506150232.29912.annabellesgarden@yahoo.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Martin Langer <martin-langer@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Am Mittwoch, 15. Juni 2005 01:50 schrieb Rui Nuno Capela:
>>
>> I've tested and re-tested all over again that somehow, somewhen I've
>> lost the MIDI I/O capability on my US-224. PCM audio is working neatly=
,
>> and the jackd usx2y "rawusb" backend is doing just fine, ever since
>> using alsa 1.0.8+ and/or 2.6.11+ kernels.
>>
>> Problem is, a few days ago, I've came to try again the MIDI I/O, like
>> plugging a hardware synth keyboard, and to my horror it didn't work at
>> all. Also tried to send something out via the ALSA sequencer client
>> port "TASCAM US-X2Y MIDI 1", and nothing happens. MIDI I/O LEDs remain
>> dark, dead. Nada.
>>
>
> Hi Rui
>
> its most possibly a bug that has been fixed in cvs some weeks ago.
> Please retry with alsa cvs.
> If that doesn't help, wake me up again immediately ;-)
>
> best regards,
> Karsten
>

OK. Just updated to alsa-driver-1.0.9b and things started to work out.

Thanks for your time.
--=20
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
