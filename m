From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: [RFC] hda/realtek filtered headphone output
Date: Thu, 23 Aug 2018 16:26:20 +0200
Message-ID: <42FE9BC5-EFF2-42DB-9FBD-EF57E7851DB0@exactcode.de>
References: <495FE36E-E1BF-4C71-A8CB-73DB5841912B@exactcode.de>
 <s5hk1uqenyl.wl-tiwai@suse.de>
 <702a7247-dd92-e801-efd7-7f807e344fe7@exactcode.e>
 <B2EB6F8F-12E4-44FE-874C-708480591007@exactcode.de>
 <s5hr2ipclhx.wl-tiwai@suse.de>
 <3A636EF5-E0B3-473E-9DC5-3B50D429091D@exactcode.de>
 <s5hefepcgj0.wl-tiwai@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 4156B26773B
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2018 16:26:37 +0200 (CEST)
In-Reply-To: <s5hefepcgj0.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 23 Aug 2018, at 16:18, Takashi Iwai <tiwai@suse.de> wrote:

> [ corrected to the right ML ]
> =

> On Thu, 23 Aug 2018 14:37:39 +0200,
> Ren=E9 Rebe wrote:
>> =

>> Hi,
>> =

>> On 23 Aug 2018, at 14:31, Takashi Iwai <tiwai@suse.de> wrote:
>> =

>>> On Thu, 23 Aug 2018 13:10:39 +0200,
>>> Ren=E9 Rebe wrote:
>>>> =

>>>> Hi Takashi,
>>>> =

>>>> I uploaded the requested log but did not hear back.
>>>> The limited headphone frequency response (aka high-pass) is still an i=
ssue with 4.18.
>>>> I rebased the patch:
>>>> =

>>>> 	https://svn.exactcode.de/t2/trunk/package/base/linux/hda-realtek.patch
>>>> =

>>>> This affects more devices (e.g. Dell XPS 13, ThinkPads) any maybe many=
 more which I do not have at hand.
>>>> =

>>>> Further guidance how to proceed with this issue to get it fixed upstre=
am is welcome.
>>> =

>>> As mentioned, a better way is to define the preferred mapping table.
>>> Take a look at alc274_fixup_bind_dacs() as an example
>> =

>> Did you had a chance to look at the log I uploaded to get an idea if it =
is possible to improve this auto parser to figure out the connection?
> =

> Did you take a look at the function?  It's pretty straightforward, you
> can specify the mapping you'd need there.

Yes, I understand. But given all 5 or so laptops I had with this codec need=
ed this override, I suspect many more of those will be affected (I currentl=
y only have 3 of those). I may find out if I get a new ThinkPad later this =
year (if they still use that codec).

Thus it may be favourable to fix the auto parser as I think you mentioned e=
arlier. If possible, this may avoid adding more override quirks, of which w=
e may need many.

	Ren=E9

> Takashi
> =

>> =

>> 	Ren=E9
>> =

>>> Takashi
>>> =

>>>> =

>>>> 	Ren=E9
>>>> =

>>>> On 06 Mar 2018, at 16:07, Ren=E9 Rebe <rene@exactcode.de> wrote:
>>>> =

>>>>> Hi Takashi,
>>>>> =

>>>>> On 03/05/2018 12:55 PM, Takashi Iwai wrote:
>>>>>> On Sat, 03 Mar 2018 13:06:49 +0100,
>>>>>> Ren=E9 Rebe wrote:
>>>>>>> =

>>>>>>> Hi all,
>>>>>>> =

>>>>>>> testing some new laptops, I noticed the headphone frequency respons=
e was lacking
>>>>>>> bass. First I noticed this in the Lenovo T470s, and later I found t=
his also be the case
>>>>>>> on Surface Pro 2 and 3. The Dell XPS13 may also be affected, but I =
had to return it
>>>>>>> before I found out the solution on the other machines:
>>>>>>> =

>>>>>>> 	https://www.youtube.com/watch?v=3Da1YkPtfC4LI
>>>>>>> =

>>>>>>> I had not yet sent the patch because a) I was too busy and b) I wan=
ted to review this further.
>>>>>>> =

>>>>>>> As the other day I got a Lenovo ideapad 720s to test with exactly t=
he same issue, here is the
>>>>>>> current hacked patch:
>>>>>>> =

>>>>>>> 	https://svn.exactcode.de/t2/trunk/package/base/linux/surface-audio=
.patch
>>>>>>> =

>>>>>>> However, given that all newer realtek codecs that came on my desk a=
re affected,
>>>>>>> maybe there is something wrong with the hda_auto_parser.c - I did n=
ot yet fully grasp
>>>>>>> all the logic of that.
>>>>>>> =

>>>>>>> As you can see in the patch and video (=85) the problem is the sign=
al routing of NID 0x15
>>>>>>> or 0x21 (depending whether it is an older, or newer codec). This is=
 the headphone out,
>>>>>>> and as far as I can see the auto_parser assigned the index 0 pcm ou=
tput (NID 0x0c)
>>>>>>> which result in this filtered frequency response, likely intended f=
or the laptop=92s speakers?
>>>>>>> Using the next NID (I guess that was 0xd?) results in a full freque=
ncy response and at
>>>>>>> least to my ears is immediately hearable and obvious.
>>>>>>> =

>>>>>>> Without this fixed routing the headphone sounds like a PC speaker i=
n a coke can.
>>>>>>> =

>>>>>>> So the question for the authors and HDA experts: Can this be fixed =
in the auto_parser,
>>>>>>> or is my patch (which btw. has to small unrelated cleanups) modulo =
potentially some
>>>>>>> renaming of the enum and function, now that more than the Surface i=
s affected, the
>>>>>>> way to go? If this can be fixed more generally I would be happy to =
hear!
>>>>>> Could you give the output of alsa-info.sh?  We need to check the
>>>>>> details of the codec topology.
>>>>> =

>>>>> To avoid sending the huge output to the list, I pressed the upload bu=
tton, and it gave me this Url:
>>>>> =

>>>>> =

>>>>> 	http://www.alsa-project.org/db/?f=3Dc68cad9c06aa999f017f1e43b52448d7=
78d2903f
>>>>> =

>>>>> This is with the linked patch, if you want to see it without the chan=
ge, I need to re-build my kernel again :-/
>>>>> =

>>>>>> In general, the right approach is to fix at parsing the routing, not
>>>>>> fiddling with the codec routing dynamically at initialization.
>>>>>> Currently the easy fix would be to provide the fixed DAC connection
>>>>>> list.  Maybe we can enhance the generic parser to receive some hints
>>>>>> for DAC selection.  The routes are determined by calculating "badnes=
s"
>>>>>> values per route, so in theory, we can give some badness values
>>>>>> depending on the target pin type (headphone, speaker, etc).
>>>>> =

>>>>> Let me know if I should try some alternative solution, ...
>>>>> =

>>>>> 	Ren=E9
>>>>> =

>>>>> -- =

>>>>> Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
>>>>> https://exactcode.com | https://t2sde.org | https://rene.rebe.de
>>>> =

>>>> -- =

>>>> ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
>>>> http://exactcode.com | http://exactscan.com | http://ocrkit.com | http=
://t2-project.org | http://rene.rebe.de
>>>> =

>> =

>> -- =

>> ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
>> http://exactcode.com | http://exactscan.com | http://ocrkit.com | http:/=
/t2-project.org | http://rene.rebe.de
>> =


-- =

 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de
