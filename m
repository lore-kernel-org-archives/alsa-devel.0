From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA intel, wired headset w/mic, jack mic detect
Date: Thu, 1 Mar 2012 07:43:53 +0800
Message-ID: <CAN8ccib90y8m0KLTYKe7Jz5sXVZFY=D7aUwm8vog3aZvZPHH0Q@mail.gmail.com>
References: <87ehtlwen3.fsf@ti.com> <4F472D4F.3000904@canonical.com>
	<CALyTGODsDRToe7efiHoVecvQ2JAYVj+G1Rv+upf2tBDDjPpzCg@mail.gmail.com>
	<CAN8cciZm2s-1Y69cohepoNNYsyBq4qQzyvbkXF2K4aDspfVtGQ@mail.gmail.com>
	<87zkc1cvaa.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 096D0104056
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2012 00:43:54 +0100 (CET)
Received: by wiax18 with SMTP id x18so1567513wia.38
	for <alsa-devel@alsa-project.org>; Wed, 29 Feb 2012 15:43:53 -0800 (PST)
In-Reply-To: <87zkc1cvaa.fsf@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/3/1, Kevin Hilman <khilman@ti.com>:
> Raymond Yau <superquad.vortex2@gmail.com> writes:
>
>> Does your headset/mic has a TRRS (Tip, ring, ring, sleeve) connector
>> instead of TRS (Tip, ring, sleeve) connector ?
>
> Yes.  It's TRRS.
>
> But below, I tried with a normal stero headset (no mic) which has a TRS
> connector too.
>
>> You can use David's hda-jack-sense-test to find out any jack sense at
>> the node of External mic when you plug the headset , if not , you may
>> need to modify unsol event of  headphone to select the external mic ,
>> internal mic.
>
> Here are the results of hda-jack-sense-test
>
> Nothing plugged in:
>
> # hda-jack-sense-test -a
> Pin 0x09 (Green HP Out): present = No
> Pin 0x0a (Not connected): present = No
> Pin 0x0b (Internal Speaker): present = No
> Pin 0x0c (Not connected): present = No
> Pin 0x0d (Internal Mic): present = No
> Pin 0x0e (Not connected): present = No
> Pin 0x0f (Not connected): present = No
> Pin 0x10 (Not connected): present = No
> Pin 0x12 (Not connected): present = No
> Pin 0x15 (Not connected): present = No
>
> With regular stereo headphones with (*no* mic, TRS):
>
> # hda-jack-sense-test -a
> Pin 0x09 (Green HP Out): present = Yes
> Pin 0x0a (Not connected): present = No
> Pin 0x0b (Internal Speaker): present = No
> Pin 0x0c (Not connected): present = No
> Pin 0x0d (Internal Mic): present = No
> Pin 0x0e (Not connected): present = No
> Pin 0x0f (Not connected): present = No
> Pin 0x10 (Not connected): present = No
> Pin 0x12 (Not connected): present = No
> Pin 0x15 (Not connected): present = No
>
> Finally, plugging the headset w/mic (TRRS):
>
> root@eze:~# hda-jack-sense-test -a
> Pin 0x09 (Green HP Out): present = Yes
> Pin 0x0a (Not connected): present = No
> Pin 0x0b (Internal Speaker): present = No
> Pin 0x0c (Not connected): present = No
> Pin 0x0d (Internal Mic): present = No
> Pin 0x0e (Not connected): present = No
> Pin 0x0f (Not connected): present = No
> Pin 0x10 (Not connected): present = No
> Pin 0x12 (Not connected): present = No
> Pin 0x15 (Not connected): present = No
>
> As you can see, there's no detected difference between the TRS and TRRS
> headsets, which is the root of the problem.

can you post the output of alsa-info.sh ?

In the codec info, do you find  Misc bit of pin defaults of the node
[jack] Mic at Ext is set ? (i.e. Misc = NO_PRESENCE ) ?

you need to add the mic select code to the unsolicited event of hp
automute speaker

    present =  snd_hda_jack_detect(codec, 0x9) ;
    if (present)
          select ext mic
   else
          select int mic


>
> Since this is a MacBookAir, it dual-boots OSX, and the detection works
> just fine using the same headset under OSX.
