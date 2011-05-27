From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH] thinkpad-acpi: Enable microphone mute LED
Date: Fri, 27 May 2011 14:22:26 -0400
Message-ID: <BANLkTimuXJchtdeV0BT3A=BTvihOFShhwA@mail.gmail.com>
References: <8dc2b2140c2794291811cd38f51f9dc7596f482c.1306266017.git.luto@mit.edu>
 <20110527162844.GA16769@srcf.ucam.org> <BANLkTint5_Vcm5rWKHL_j5XsVmcAu8X7pw@mail.gmail.com>
 <20110527164855.GA17443@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110527164855.GA17443@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 27, 2011 at 12:48 PM, Matthew Garrett <mjg59@srcf.ucam.org>=
 wrote:
> On Fri, May 27, 2011 at 12:39:10PM -0400, Andrew Lutomirski wrote:
>
>> I don't have docs so I don't really know. =A0But the mute LED does n=
ot
>> appear to be controllable from the LED interface and when mute is li=
t
>> there's no sound regardless of what ALSA thinks. =A0When I light the
>> micmute light, I can still record sound just fine.
>>
>> The mic mute button does nothing on Windows unless the special drive=
r
>> is installed, and that driver seems to mute the Windows mixer, so I
>> think there's nothing special other than a little userspace helper
>> going on.
>
> Hm. That makes things kind of tricky. While it's easy to just expose =
the
> LED, really we want to do it in such a way that userspace knows which
> LEDs it should be toggling while setting the microphone mute.

One thought: call the thing laptop::micmute and teach userspace to
look for an led with that name.

Do any of the ALSA or PulseAudio people have any preferences?

--Andy
