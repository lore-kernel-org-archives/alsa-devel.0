From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: usx2y jack driver
Date: Fri, 24 Sep 2004 23:31:04 +0100 (WEST)
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <32827.192.168.1.5.1096065064.squirrel@192.168.1.5>
References: <200409222228.38243.annabellesgarden@yahoo.de>
    <32810.192.168.1.5.1095897022.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <32810.192.168.1.5.1095897022.squirrel@192.168.1.5>
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

>Karsten Wiese wrote:
>>
>> this adds a hw_dep device to snd-usb-usx2y to communicate pcm in native
>> usb chuncs with userspace. it also adds a usx2y driver to jack, so you
>> can play with it.
>>
>> works fine here.
>> I can reliably use 128frames 2periods now on kernel 2.6.9-rc2-mm1-S1.
>> Without crackles of course. (On a 500MHz PIII with UHCI-usb. Problems
>> with OHCI may still be there, don't know.)
>>
>
> Amazing! I will check this out soon on my US-224. I'm a bit busy right
> now, so can't afford to trash my alsa/jack environment, at least for the
> time being.
>

That's right.

I've already worked out this new usx2y jack driver with my US-224 and the
results are really excellent! Kudos to Karten!

No crackles at all, while starting jackd -R -d usx2y -p 128 -n 2. A real
breakthrough achievement!

Real good stuff, considering that while on these settings with the stock
alsa jack driver my ears could not stand the annoyance of all the boiling
:) The minimum alsa settings were -p256 -n2, even barely crackling.

This has been just tested on my SUSE 9.1 box, P4 2.8GHz HT, happy now with
a 2.6.9-rc2-mm3-S6 SMP/HT (full VP), UHCI USB controller.

I'm so happy that even qjackctl has already experimental support for this
usx2y driver thing (qjackctl 0.2.11.9). You can check it out from CVS
(sf.net lag time applies here :)

I have also setup a web directory where I'll keep related packages files
(e.g. jack RPMS for SUSE 9.1 are in there).

It's here:

    http://www.rncbc.org/usx2y/

Please note that this will be only maintained while being experimental.

So here it goes, my lobbying but serious vote to include this usx2y driver
in the official JACK CVS tree.

>
> BTW, that OHCI issue is really still open and quite ugly (cf.
> alsa-driver bug #0000425). It makes my US-224 almost useless on my
> laptop :( Every time I try to open the pcm device I get a fatal kernel
> oops. Midi is ok however.
>
> I must remember you that this all used to work satisfactorily around
> alsa-driver-1.0.5a inclusive. IIRC it was that "no sleeping in ALSA's
> pcm START/STOP callback" patch (as of CVS circa July 12-13) that broke
> something, unfortunately I'm sure.
>
> If you find the patience/time to lead me on debugging this, I'll
> appreciate a lot.
>

I hadn't the time yet to test the new usx2y kernel and jack code on this
yet. This OHCI issue is probably still roaring its ugly head.

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
