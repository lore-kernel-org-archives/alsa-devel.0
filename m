From: Kevin Atkinson <kevina@gnu.org>
Subject: Throughts on getting ALC892 working better (was Re:
 Help With Getting Line-in monitoring working)
Date: Mon, 5 Sep 2011 16:45:09 -0600 (MDT)
Message-ID: <alpine.BSF.2.00.1109051644170.61207@bas.flux.utah.edu>
References: <alpine.BSF.2.00.1109050127250.10767@bas.flux.utah.edu>
	<CAN8cciZS0wxW+MJgERzSYBW4_JKen13UEjwT-SQ10OV9WOWKpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	boundary="151192476-1774241423-1315211992=:10767"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bas.flux.utah.edu (bas.flux.utah.edu [155.98.60.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D1D324565
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 00:45:10 +0200 (CEST)
Received: from bas.flux.utah.edu (localhost [127.0.0.1])
	by bas.flux.utah.edu (8.14.3/8.14.3) with ESMTP id p85Mj9ko071751
	for <alsa-devel@alsa-project.org>; Mon, 5 Sep 2011 16:45:09 -0600 (MDT)
	(envelope-from kevina@bas.flux.utah.edu)
In-Reply-To: <CAN8cciZS0wxW+MJgERzSYBW4_JKen13UEjwT-SQ10OV9WOWKpQ@mail.gmail.com>
Content-ID: <alpine.BSF.2.00.1109051644171.61207@bas.flux.utah.edu>
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

--151192476-1774241423-1315211992=:10767
Content-Type: TEXT/PLAIN; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.BSF.2.00.1109050240101.10767@bas.flux.utah.edu>

[I wasn't sure if this post was directed at me or Takashi Iwai.]

I spent several hours going over the data sheet (ver 1.3, you can find it=
=20
at=20
http://www.realtek.com/downloads/downloadsView.aspx?Langid=3D1&PNid=3D24&PF=
id=3D28&Level=3D5&Conn=3D4&ProdID=3D284&DownTypeID=3D1&GetDown=3Dfalse&Down=
loads=3Dtrue=20
or just Google it if you don't already have it) and in particular the=20
Block Diagram on page 5.  And, things are finally making sense to me.

Apparently there is no hardware master control and the master and PCM=20
slider must be implemented in software.

So, after the change you suggest below the mixer are mapped better in the=
=20
newer drivers.  But things can be still be improved.  More below.

On Mon, 5 Sep 2011, Raymond Yau wrote:

> 2011/9/5 Kevin Atkinson <kevina@gnu.org>:
>> Hi,
>>
>> I need some help getting my cards line-in monitoring working. =A0That is
>> analog pass-through from line-in to headphone out.
>>
>> I am using Ubuntu 10.04 with Linux kernel Linux Intel 2.6.38-10 (Ubuntu
>> package). =A0I am using on-board audio with HDA-Intel with the Realtek A=
LC892
>> codec.
>>
>> With the stock Ubuntu kernel (lets call this setup "stable") I can't get
>> line-in monitoring working (note however I can record from line in, I ju=
st
>> can't get the analog pass-through working). =A0However, when I install t=
he
>> latest ALSA drivers (lets call this setup "soso") (recompiled a source
>> package from the Ubuntu-audio-dev ppa, head 7c48f32b). I can get Line-in
>> monitoring but the mixer controls are all mixed up. =A0The Line-in contr=
ol
>> controls the Line-in volume, but the master control has no effect. =A0Al=
so,
>> the PCM control has no effect on PCM volume and the front control contro=
ls
>> the output to the headphone but in order to mute the headphone
>> I still need to use the headphone mute. =A0The mixer work correctly with=
 the
>> stable setup.
>>
>> Thus I am lead to the conclusion that the latest ALSA drivers are doing
>> something right with line-in but getting a lot of other things wrong.
>>
>
> connect node 0x1b  HP to 0x02 instead of 0x26, you will unable to use
> the headphone playback volume at 0x25

This doesn't make sense,  I think you meant connect 0x1b to 0x26 like it=20
was in the older drivers.  At least for me, my headphone mixer is working=
=20
correctly after making this change (with the newer driver).

> Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> +  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
> +    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
>   Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> @@ -436,11 +444,11 @@
>     Conn =3D 1/8, Color =3D Green
>     DefAssociation =3D 0x2, Sequence =3D 0x0
>   Pin-ctls: 0xc0: OUT HP VREF_HIZ
> -  Unsolicited: tag=3D00, enabled=3D0
> +  Unsolicited: tag=3D04, enabled=3D1
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=3DD0, actual=3DD0
>   Connection: 5
> -     0x0c 0x0d 0x0e 0x0f 0x26*
> +     0x0c* 0x0d 0x0e 0x0f 0x26

Also to get line-in pass-through working via headphone out please unmute=20
the second set of Amp-in vals of pin 0x26.

> Node 0x26 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>  Amp-In vals:  [0x00 0x00] [0x80 0x80]
                               ^^^^^^^^^^^ set these to 0x00
>  Connection: 2
>     0x25 0x0b

Apparently all analog inputs are mixed together using 0x0B and then the=20
output is sent to a bunch of other audio mixers, but these mixers don't=20
really control the volume, they just have a separate mute for the PCM and=
=20
analog input.  That being said, it probably also makes sense to mute=20
analog audio (coming from 0x0B) on all but pins 0x26 (headphone) and 0x0C=
=20
(front) by default.

The fact that the master (or individual output controls for that matter)=20
doesn't control the analog pass-through volume is unfortunate, but I can=20
live with.  At least with the newer drivers the mute also mute the analog=
=20
pass-through which was not the case with the old drivers.


Speaking of mixer settings, for pins that are configured to output and=20
have the "HP" capacity, please expose this widget control somehow on the=20
mixer.  I am not sure I would call it call it an amp toggle because what=20
it really does is switch between line-out and headphone-out.  This is=20
important because when I first tried the card I wasn't sure what the=20
front Headphone out and the back Front out where configured as (I knew=20
they could be both from the motherboard manual).  A switch will give me=20
confidence that they are configured correctly.  In addition, this is=20
something users should be able to control without having to know the=20
intricacies of the Intel HDA spec and using hda-analyze.


On a lesser note the mixer settings for recording are really don't really=
=20
correspond to how to hardware is set up.  According to the diagram there ar=
e=20
two separate PCM recorders and each of them can take input from the analog=
=20
mixer (0x0B) or they can bypass the mixer by unmuting any of the analog=20
inputs (controlled by mixer 22h and 23h), then after that there is another=
=20
volume control which controls the combined input (0x09 0x08).

The current mixer only allows one to select source for each PCM recorders=
=20
and does not give the option to use the analog mixer (0x0B) which might=20
make sense if you want to record from two mics.


On an even lesser note, it would be really nice if ALSA could expose the=20
full capacity of the hardware without having an unwieldy number of mixer=20
controls.  For example each of the 5 output mixers have a separate PCM and=
=20
analog pass-though mute control, it would be nice to expose this.  Also,=20
each of the 8 analog pins can be repurposed as either input or output,=20
some of them have a headphone amp, some of them have a mic boost, it would=
=20
be nice if all this could all be exposed.  However, I can see how exposing=
=20
all this will lead to a lot of confusing mixer settings.

Short of that, it would be nice if it would be possible to reconfigure=20
mixer hookups and add new mixers.  For example if I repurpose the one of=20
the output pins for an additional line-in it would like to be able to=20
control the volume for it and select it for recording.  I can see how to=20
reconfigure the HDA-Intel setting via /sys/class/sound but I can not see=20
how to control the mixer configuration.  In can reconfigure the card using=
=20
hda_analyzer but it is very non-obvious how to get the codec to=20
re-configuration based on those settings (and possible expose some=20
additional mixer settings, if say one of the output pins becomes an input=
=20
pin).  Nor is it obvious how to make those settings persistent.  An option=
=20
for hda_analyzer to expose the difference in a way that can be used by=20
/sys/class/sound and/or via the Early Patching option would be helpful.
--151192476-1774241423-1315211992=:10767
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--151192476-1774241423-1315211992=:10767--
