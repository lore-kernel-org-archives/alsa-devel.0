From: <bbennetts@blueyonder.co.uk>
Subject: RE: Known PCM bug in ymfpci on Tecra 8100
Date: Tue, 13 Jul 2004 18:39:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5B596E67A1B90F48A466D8DF19E1F49703713CED@ECOWV06M.Telewest.Internal>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>=20
>> >>=20
>> >> Hi,
>> >>=20
>> >> Has anyone had any joy fixing this problem?  If not is there =
anything I >can do=20
>> >> to help?  I am willing to attempt debugging if someone will point =
me at >a=20
>> >> 'dummy's guide' to attaching a debugger to ALSA.=20
>> >>=20
>> >> Sorry if this was a dumb question, I can see the bug is known but =
>couldn't=20
>> >> find any open bug in the bug tracker.
>> >
>> >What kind of bug?  If you don't find one on BTS, please enter it.
>> >
>> >
>> >thanks,
>> >
>> >Takashi
>>=20
>> Hmm, in the ymfpci description it has :
>>=20
>>   Known bugs
>>=20
>>   - pcm playback is not audible on toshiba tecra8100.=20
>
>Ah, that one...
>
>> I _do_ get sound, unfortunately its just crackly static noise:-(
>>=20
>> I shall raise it as a bug.
>
>Yes, please.
>It's likely the lack of some register initiailzation, since OSS ymfpci
>and the old ALSA 0.5.x ymfpci seem working.  The question is which
>register affects this.
>
>
>Takashi

Raised : 384

I'm happy to have a bash at debugging it, although I have never done any =
driver dev so there may be an amount of hand holding required.  =
Alternatively I can provide whatever outputs you want.

Cheers, Bry.


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
