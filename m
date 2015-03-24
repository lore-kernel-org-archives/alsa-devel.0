From: "Kalvas, Taneli" <taneli.v.m.kalvas@jyu.fi>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Tue, 24 Mar 2015 06:42:14 +0000
Message-ID: <6A72E9C91650BD49A6D9B305755BC04C42D8CE0F@mbs1.ad.jyu.fi>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>,
 <54FD5D4C.3040204@ladisch.de>
 <6A72E9C91650BD49A6D9B305755BC04C42D8067A@mbs1.ad.jyu.fi>,
 <54FE14F4.9070704@ladisch.de>
 <6A72E9C91650BD49A6D9B305755BC04C42D80787@mbs1.ad.jyu.fi>,
 <54FEA526.10708@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from posti6.jyu.fi (posti6.jyu.fi [130.234.4.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 33F9A2625C4
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 07:42:17 +0100 (CET)
In-Reply-To: <54FEA526.10708@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am back with the Miditech MidiFace 4x4 issue. I communicated back and for=
th for the last two weeks with the customer support of Miditech The full co=
mmunication is attached below. The long story made short:

1. I showed them that the device fails long SysEx transfers both in Linux a=
nd in Windows (using MIDI-OX software) if the writing to device isn't delay=
ed.
2. I told them that the MicroKORG synthesizer patch editor is unable to com=
municate through their device.
3. They are blaming the MicroKORG software and/or the Windows MIDI driver. =
No explanation was given for the results achieved with MIDI-OX or for the r=
esults in Linux.
4. They say there is no problems in the hardware, but still they say that t=
o fix the problem they should make a separate Windows driver for their hard=
ware.

>From the last email I got the impression that they are not going to do anyt=
hing ("Here is the final answer..."). I will still try to push them a bit, =
but I believe making a customized Linux kernel driver is the only way.

What is the policy with external contributions for the snd-usb-audio/midi? =
I haven't fiddled with linux kernel before, but I might try to produce some=
thing. Do you have any pointers on where to start or should I just start re=
ading through the code. From my first session with the usb documents ("USB =
MIDI Devices 1.0") and the kernel code I could not find the flow-control fo=
r the midi interface buffer in either one. Is the flow control described so=
mewhere in the code and/or documents in a more general level? General purpo=
se usb driver?

Taneli



The communication with Miditech:
----------------

Miditech Support GMX [miditech@gmx.net]
[Reply All]
 =

Monday, March 23, 2015 9:30 PM
Hi again,
here is the final answer from our taiwanese engineer:

It is not the problem of Midiface 4x4.
It is problem of windows driver's buffer size setting.
There is not any buffer size setting in Midiface 4x4 hardware.
It is the windows driver's problem, it needs to set the buffer size or use
the default size to the windows driver first.
MicroKORG uses his own driver, it may set the buffer size to 1024 or above
before.
So we have nothing to do with the Midiface 4x4 now.
To fix the problem, we need to design our own driver for Midiface 4x4, which
we don't have it yet, instead of using the common windows driver.

Hope this will help you,
Best regards,
Miditech Support
Miditech Support GMX [miditech@gmx.net]
[Reply All]
 =

Thursday, March 19, 2015 9:14 PM
Hello again,
thanks for your information. Now i can visualise more, what you are doing
:-)

Maybe this problem has something to do with the transmission speed. I know
that Sysex problems are mostly caused by the transfer speed.
Also I know, that the Midisport series interfaces are perfect for Sysex
transfers and nearly work everytime well. But they are much more expensive =
than our interfaces.

But do you know another "class compliant" interface, which works for this?

Maybe the Microkorg editor itself especially has a problem with our
Midiface, or with class compliant devices.

Best regards,
Miditech Support
Kalvas, Taneli
[Reply All]
L=E4hetetyt
Thursday, March 19, 2015 2:34 PM
Hi!

What I am trying to achieve with the SysEx transmission is editing, saving =
and loading of the synthesizer patches. The dedicated editor software / lib=
rarian allows to edit  the patches on a PC and transfer the patch to the sy=
nthesizer, while editing making the work flow fluent. Each transfer is 294 =
bytes and therefore does not work. If I use MIDI-OX with delay functionalit=
y necessary to get the hardware working, I can not edit the patches on a PC=
. I can only save and load.

I personally don't have other interfaces, but I borrowed a M-audio Midispor=
t 2x2 and it worked with the MicroKORG editor software as expected.

For everything else than the SysEx transfers, the Midiface device works as =
expected. It works in Windows and in Linux, where I use the Rosegarden sequ=
encer.

Taneli

--
Taneli Kalvas
Ph.D., Researcher
Department of Physics, room FL114
P.O. Box 35 (YFL)
40014 University of Jyv=E4skyl=E4, Finland
Mobile: +358-44-314-1602
Fax:    +358-14-617-411
Email:  taneli.kalvas@jyu.fi
Miditech Support GMX [miditech@gmx.net]
[Reply All]
 =

Thursday, March 19, 2015 9:39 AM
Hello again,
I send you issue again to our developers in Taiwan and hope to get a
statement of them soon.

I have some questions left please: What do you do with this Sysex
transmission "in practical"?

Do you try to make a MIDI dump from your Microkorg into a Sequenzer to save
the user settings?
Or a similar reason, what are you doing?

I do not really understand what you want to do in practical. Did you try
another class compliant MIDI interface?
What type? Did it work different? What MIDI music software do you use? Linux
based systems and music software?

Best regards,
Miditech Support
Kalvas, Taneli
[Reply All]
L=E4hetetyt
Thursday, March 19, 2015 9:17 AM
Hi!

I hope they could reproduce my test with the MIDI-OX. I bought my unit onli=
ne from Thomann in Germany and my 30 day returns period has already passed.=
 I also have a strong belief that the unit is not defect. It is highly impr=
obable that the firmware would be broken like that on a single unit.

Taneli

--
Taneli Kalvas
Ph.D., Researcher
Department of Physics, room FL114
P.O. Box 35 (YFL)
40014 University of Jyv=E4skyl=E4, Finland
Mobile: +358-44-314-1602
Fax:    +358-14-617-411
Email:  taneli.kalvas@jyu.fi
Miditech Support GMX [miditech@gmx.net]
[Reply All]
 =

Wednesday, March 18, 2015 9:18 PM
Sorry,
I did not get any additional reaction from our taiwanese developers. But of
course, they cannot test the compatibilty to every music and MIDI hardware =
which is available.

Because you are the first customer with Sysex Problems with the Midiface
4x4, is there a possibility to change it at your music shop and try another=
 one. Maybe only your unit is
defect.

Best regards,
Miditech Support
Kalvas, Taneli
[Reply All]
L=E4hetetyt
Wednesday, March 18, 2015 2:16 PM
Hi!

I would like inquire if any progress has been made with the issue I pointed=
 out.

Best regards,
Taneli Kalvas

--
Taneli Kalvas
Ph.D., Researcher
Department of Physics, room FL114
P.O. Box 35 (YFL)
40014 University of Jyv=E4skyl=E4, Finland
Mobile: +358-44-314-1602
Fax:    +358-14-617-411
Email:  taneli.kalvas@jyu.fi
Kalvas, Taneli
[Reply All]
L=E4hetetyt
Wednesday, March 11, 2015 7:59 PM
Hi!

I wasn't aware of the MIDI-OX software. Thank you for pointing that out. It=
 is possible to do exactly the same tests in MIDI-OX that I did in Linux.

In the first scenario I transport 144 bytes of Sysex data through the Midif=
ace 4x4. Everything works as expected. I have also shown the transport opti=
ons of the software and you can see that the buffer size used by the progra=
m is 128. Everything works because all of the data fits in the buffer in th=
e Midiface hardware. This scenario is shown in scen1_works.png.

In the second scenario I tried to transport 512 bytes of data. MIDI-OX brea=
ks this into four blocks and feeds them through the Windows driver to the M=
idiface 4x4, which causes overwriting of the hardware buffer I suspect. The=
 data becomes corrupted and some data is lost due to the overwriting. This =
is shown in scen2_fails.png. The MIDI-OX software contains an option to slo=
w down the transport of data. I modified the second scenario by adding 50 m=
s delay after each 128 byte block. This is more than 320 us*128 =3D 41 ms a=
nd therefore the hardware has enough time to empty its internal buffer befo=
re new data arrives. This is shown in scen2_works.png. This delaying is exa=
ctly the same thing that I did in Linux as I explained before.

This does not prove that the hardware works according to specification. Mos=
t software do not have such delaying functionality because it shouldn't be =
needed. MIDI-OX is specialized software in this sense. For example the Micr=
oKORG patch editor I am trying to use does not have it. It relies on the Wi=
ndows driver and the hardware to perform according to specification and pro=
vide flow-control information without relying on timing on the user space s=
oftware. I have confirmed that the MicroKORG patch editor works correctly w=
ith different class-compliant hardware on the same computer. The problem se=
ems to be therefore in the Midiface hardware.

My guess is that there is a bug in the mechanism which provides information=
 for the operating system driver about the output buffer fill level status =
in the Midiface hardware. I hope you can pinpoint the problem and make an u=
pdate on the firmware.

Best regards,
Taneli Kalvas

--
Taneli Kalvas
Ph.D., Researcher
Department of Physics, room FL114
P.O. Box 35 (YFL)
40014 University of Jyv=E4skyl=E4, Finland
Mobile: +358-44-314-1602
Fax:    +358-14-617-411
Email:  taneli.kalvas@jyu.fi
Miditech Support GMX [miditech@gmx.net]
[Reply All]
 =

Wednesday, March 11, 2015 9:01 AM
Hello,
our engineer in Taiwan tested the MIdiface 4x4 successful with a Sysex data
larger than 256 bytes. thats what he wrote yesterday:

My guys tested MIDIFACE 4x4 and found no problem. Please see attached
picture. Can you please ask customer to provide more information like
MIDI-OX screen like we did? Thanks

With Best Regards

Maybe you can try this again and also make a MIDI OX Screenshot of your
failure?

Best regards,
Miditech Support
Miditech Support GMX [miditech@gmx.net]
[Reply All]
 =

Tuesday, March 10, 2015 7:47 PM
Hello and thanks for your explanations.
We gave it to our taiwaneese engineers, if they find a problem or solution,
maybe we can fix this with a firmware update for the Midiface 4x4.

Best regards,
Miditech Support
Kalvas, Taneli
[Reply All]
L=E4hetetyt
Tuesday, March 10, 2015 10:59 AM
Hello!

I am trying to communicate with a MicroKORG synthesizer. The complete data =
dump for this synth is roughly 32 kbytes. I tried the MicroKORG editor firs=
t under Windows, but after experiencing problems I switched to Linux, which=
 provides better programming utilities for studying the problems with the c=
ommunication.

For my studies I connected the output of port 1 to input of port 2 on the h=
ardware and had two programs running. One sending out data and one listenin=
g on the other port. For data less than 256 bytes everything works as it sh=
ould. With larger data sizes part of the data disappears and the sequence g=
ets mangled (data is corrupted). By looking at the data received it looks l=
ike if the ring buffer in the device gets overwritten before the bytes get =
through the MIDI out port.

After this I made another test: I modified the program to write to the midi=
 output port in N=3D128 byte blocks and added a 352*N mikrosecond delay aft=
er each block. This delay allows time for the Midiface hardware to empty it=
s buffer before new data if written in. I believe this test shows that the =
device works otherwise as it should, but it fails to inform the usb/midi dr=
iver of the computer about the filled up buffer.

Unfortunately I am only able to do this delaying in my own software and the=
refore I can not fix the problem with hardware when it is being used by oth=
er programs.

Best regards,
Taneli Kalvas

--
Taneli Kalvas
Ph.D., Researcher
Department of Physics, room FL114
P.O. Box 35 (YFL)
40014 University of Jyv=E4skyl=E4, Finland
Mobile: +358-44-314-1602
Fax:    +358-14-617-411
Email:  taneli.kalvas@jyu.fi
Miditech Support GMX [miditech@gmx.net]
[Reply All]
 =

Tuesday, March 10, 2015 10:37 AM
Hello,
what Sysex file do you try to send? And with which sequenzer/software?
How can you check how the handling of a Sysex file larger 245 bytes is?

Best regards,
Miditech Support
Kalvas, Taneli
[Reply] [Reply All] [Forward]
Actions
To:
 info@miditech.de =

L=E4hetetyt
Tuesday, March 10, 2015 1:06 AM
Dear Sir/Madam,

I bought a Midiface 4x4 and have been trying to use the interface to transf=
er SysEx patches to/from a synthesizer. The transfer did not work and there=
fore I started investigating the reasons. In the end I found that the reaso=
n for transfer failure was a faulty device firmware, which does not check a=
gainst filling up the device buffer of the output port. For SysEx patch wri=
tes larger than 256 bytes the new data overwrites the device buffer before =
the overwritten bytes were sent.

1. In my opinion the device does not qualify as "class compliant" midi-usb =
interface as it is being marketed.
2. I would like to know if there exists an updated firmware driver for the =
device to fix this issue.

The usb serial name for the device is MIDIPLUS / MIDI4x4 / MIDIPLUS-BC-1A0B=
-07DA0908-MIDI4x4. The device is branded as "Miditech Midiface 4x4". The de=
vice revision number reported by the usb driver is 1.01

Best regards,
Taneli Kalvas

-- =

Taneli Kalvas
Ph.D., Researcher
Department of Physics, room FL114
P.O. Box 35 (YFL)
40014 University of Jyv=E4skyl=E4, Finland
Mobile: +358-44-314-1602
Fax:    +358-14-617-411
Email:  taneli.kalvas@jyu.fi
