From: =?iso-8859-2?B?QWRhbSBUbGGza2E=?= <atlka@pg.gda.pl>
Subject: Re: Dmix and non SND_PCM_TYPE_HW slaves
Date: Wed, 16 Nov 2005 19:03:54 +0100
Message-ID: <op.s0chssfcq5yxc3@merlin>
References: <OFB5C60420.D5C0FB76-ON652570BA.00273D48-652570BA.00273D59@flextronicssoftware.com> <Pine.LNX.4.61.0511150835390.9148@tm8103.perex-int.cz> <s5hek5ixlat.wl%tiwai@suse.de> <Pine.LNX.4.61.0511161523230.9655@tm8103.perex-int.cz> <s5h64qshcjq.wl%tiwai@suse.de> <Pine.LNX.4.61.0511161614090.9655@tm8103.perex-int.cz> <s5h4q6chb0n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q6chb0n.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Dnia 16-11-2005 o 16:23:36 Takashi Iwai <tiwai@suse.de> napisa=B3:

> At Wed, 16 Nov 2005 16:14:31 +0100 (CET),
> Jaroslav Kysela wrote:
>>
>> On Wed, 16 Nov 2005, Takashi Iwai wrote:
>>
>> > At Wed, 16 Nov 2005 15:24:26 +0100 (CET),
>> > Jaroslav Kysela wrote:
>> > >
>> > > On Tue, 15 Nov 2005, Takashi Iwai wrote:
>> > >
>> > > > At Tue, 15 Nov 2005 08:39:06 +0100 (CET),
>> > > > Jaroslav wrote:
>> > > > >
>> > > > > On Tue, 15 Nov 2005 sameer.kittur@flextronicssoftware.com wrot=
e:
>> > > > >
>> > > > > > Hi all,
>> > > > > >
>> > > > > >     Is there a reason why Dmix cannot use a non =20
>> SND_PCM_TYPE_HW slave? Is
>> > > > > > there no way to re-direct the Dmix output to another plugin =
=20
>> or an
>> > > > > > external I/O or a filter plugin?
>> > > > >
>> > > > > It's impossible without massive changes to the dmix code and =20
>> structure.
>> > > > > Dmix uses too much driver specific things like the PCM timer, =
=20
>> passing PCM
>> > > > > device file-descriptor among applications etc. Also, the =20
>> latency can be
>> > > > > much worse when the dmix plugin will use only SHM ring buffer =
=20
>> or so.
>> > > >
>> > > > Actually, it's difficult to apply the current dmix model to a
>> > > > (user-space) driver without DMA like bluez.  We need to gather t=
he
>> > > > data from all clients and send only once to the hardware in such=
 a
>> > > > case.  So, the solution with a sound server looks most =20
>> appropriate.
>> > >
>> > > It's not so difficult, but extra double buffering will be added =20
>> between
>> > > producer and consumer, so the latency increases min. twice.
>> >
>> > Hmm, but still this doesn't work well.  Remember that the data chunk
>> > once tranferred cannot be modified any longer.  Hence, to get a low
>> > latency, the buffer must be sent just before the active update.
>> > In the best case, we may have only 2 periods in practice.
>> >
>> > This would work if a server process runs in a high task priority, bu=
t
>> > not for the models with parallel accessses like dmix.
>>
>> I meant a daemon with RT priority which will "emulate" DMA.
>
> I see.  Then, surely it's not difficult :)

Maybe but again problem may rise if we have more RT apps in the system.
If kernel treats all RT apps same way we will have problems anyway.
Only true solution is doing this in the kernel so it knows which latency
is needed and can woke up proper app in the proper time.

Sorry to say that but under high load and while big apps rescheduling is =
=20
done
ALSA is doing rather poorly. Without kernel support it can't be resolved
and current approach leads to dead end IMHO.

Regards
--=20
Adam Tla=B3ka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
