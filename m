From: Kevin Atkinson <kevina@gnu.org>
Subject: Re: Throughts on getting ALC892 working better (was
 Re: Help With Getting Line-in monitoring working)
Date: Tue, 6 Sep 2011 04:06:07 -0600 (MDT)
Message-ID: <alpine.BSF.2.00.1109060330460.61207@bas.flux.utah.edu>
References: <alpine.BSF.2.00.1109050127250.10767@bas.flux.utah.edu>
	<CAN8cciZS0wxW+MJgERzSYBW4_JKen13UEjwT-SQ10OV9WOWKpQ@mail.gmail.com>
	<alpine.BSF.2.00.1109050238310.10767@bas.flux.utah.edu>
	<CAN8ccia85ehbCDTQ_fh_W16mWQeROJN_40Zc5LAxhJVL1jmxfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="151192476-1658397258-1315303567=:61207"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bas.flux.utah.edu (bas.flux.utah.edu [155.98.60.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D690C24633
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 12:06:11 +0200 (CEST)
Received: from bas.flux.utah.edu (localhost [127.0.0.1])
	by bas.flux.utah.edu (8.14.3/8.14.3) with ESMTP id p86A68t7017403
	for <alsa-devel@alsa-project.org>; Tue, 6 Sep 2011 04:06:08 -0600 (MDT)
	(envelope-from kevina@bas.flux.utah.edu)
In-Reply-To: <CAN8ccia85ehbCDTQ_fh_W16mWQeROJN_40Zc5LAxhJVL1jmxfQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--151192476-1658397258-1315303567=:61207
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 6 Sep 2011, Raymond Yau wrote:

> 2011/9/6 Kevin Atkinson <kevin@atkinson.dhs.org>:
>
>
> How did you get "snd: bad kfree" in the system log ?

No idea.  I am using alsa-driver.git, kernel incompatibility?

>> I spent several hours going over the data sheet (ver 1.3, you can find i=
t at
>> http://www.realtek.com/downloads/downloadsView.aspx?Langid=3D1&PNid=3D24=
&PFid=3D28&Level=3D5&Conn=3D4&ProdID=3D284&DownTypeID=3D1&GetDown=3Dfalse&D=
ownloads=3Dtrue
>
>>
>> Apparently there is no hardware master control and the master and PCM sl=
ider
>> must be implemented in software.
>
>
>>
>> So, after the change you suggest below the mixer are mapped better in th=
e
>> newer drivers. =A0But things can be still be improved. =A0More below.
>>
>
>> Also to get line-in pass-through working via headphone out please unmute=
 the
>> second set of Amp-in vals of pin 0x26.
>>
>>> Node 0x26 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>> =A0Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>> =A0Amp-In vals: =A0[0x00 0x00] [0x80 0x80]
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^^^^^^^^^^^ set =
these to 0x00
>>>
>>> =A0Connection: 2
>>> =A0 =A00x25 0x0b
>>
>
>
> The ALC892 provides ten DAC channels that simultaneously support 7.1
> channel sound playback, plus 2 channels of independent stereo sound
> output (multiple streaming) through the front panel stereo outputs.
>
>
> you can create playback device 2 for the front panel headphone by adding
>
> spec->alt_dac_nid =3D 0x25;

I'm sorry I know nothing of the alsa code, but this doesn't seam like it=20
will do what we want.  What is this doing?  Basically I want the driver to=
=20
unmute the input from 0x0b for mixer 0x26, like it doesn't on all the=20
other internal mixers that have 0x0b going into it.

>> Apparently all analog inputs are mixed together using 0x0B and then the
>> output is sent to a bunch of other audio mixers, but these mixers don't
>> really control the volume, they just have a separate mute for the PCM an=
d
>> analog input. =A0That being said, it probably also makes sense to mute a=
nalog
>> audio (coming from 0x0B) on all but pins 0x26 (headphone) and 0x0C (fron=
t)
>> by default.
>
> The hardest thing is how to add the controls for this alc892
>
> http://thread.gmane.org/gmane.linux.alsa.devel/88324

I think we are talking past each other here....

>> On an even lesser note, it would be really nice if ALSA could expose the
>> full capacity of the hardware without having an unwieldy number of mixer
>> controls. =A0For example each of the 5 output mixers have a separate PCM=
 and
>> analog pass-though mute control, it would be nice to expose this. =A0Als=
o,
>> each of the 8 analog pins can be repurposed as either input or output, s=
ome
>> of them have a headphone amp, some of them have a mic boost, it would be
>> nice if all this could all be exposed. =A0However, I can see how exposin=
g all
>> this will lead to a lot of confusing mixer settings.
>>
> does any user really want to pass the stereo signal from line in to
> "center/lfe" ?

I did say "On an even lesser note", my point is the hardware can do it,=20
the driver should be able to expose the functionality somehow.  I don't=20
really care through.


Anyway the point is that on my machine using the latest code from the=20
alsa-driver.git all the mixer setups are working well after I make the=20
two additional changes to the initial setup everything seams to work.

If it helps I can resend the /proc/* output after I manually tweak the=20
setting so that things work correctly for me.

I don't have time right now to figure out how to get these changes into=20
the code, but if someone can give me a patch to try or a strong hint on=20
what needs to change I am willing to try it out.

At this point I don't have time to try the latest kernel code.

I guess the point of this post is to serve as a data points on what work=20
on my hardware with the alc892 which is the ASUS P7H55-M motherboard.=20
The alc892 matches perfectly with what are in the official data sheet,=20
except that some of the pins are not hooked up to anything (BEEP-IN,=20
CD-IN, S/PDIF-IN)


--151192476-1658397258-1315303567=:61207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--151192476-1658397258-1315303567=:61207--
