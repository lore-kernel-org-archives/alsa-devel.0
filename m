From: "Thibault LE MEUR" <Thibault.LeMeur@supelec.fr>
Subject: RE : Patch usb-audio: I need guidelines
Date: Mon, 27 Feb 2006 12:11:25 +0100
Message-ID: <02db01c63b8e$90356110$a578e4a0@supelec.fr>
References: <s5h8xs0vbxq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from laposte.supelec.fr (laposte.supelec.fr [160.228.120.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CFE74192
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 12:11:36 +0100 (MET)
In-Reply-To: <s5h8xs0vbxq.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> Reading the above, I feel creating a new driver would be=20
> cleaner rather than adding tons of workarounds for special=20
> cases.  It could use most of functions in usb*.c.

Yes that could be a solution but 99% of the usbaudio.c code is fine for =
the
device, and I think little has to be done in order to get it work =
better. So
I think it would be better not to "fork" and customize this driver.

> I don't know what change you need in parse_audio_endpoints(),=20

In fact the m-audio audiophile usb has several usb interfaces each with
several Altsettings but some Altsettings are mutually exclusive.

Let me be more specific:
* Usb Interface 2 is the Analog Out audio function
* Usb Interface 3 is the Digital Out audio function
* Usb Interface 4 is the Analog In audio function
* Usb Interface 5 is the Digital In audio function
Usb Interfaces 2,3 and 4 has Altsettings 1,2,3,4,5 and Usb Intercace 5 =
only
has Altsetting 1,2,4:
* AltSetting  1 is used in 24bits 96KHz mode only
* AltSettings 3 and 5 (Synch and Adaptive mode) are used in 24bits/48KHz =
and
16bits/48KHz mode respectively _if_and_only_if_ Digital Input is _not_ =
used
* AltSettings 2 and 4 (ASync mode) are used in 24bits/48KHz and =
16bits/48KHz
mode respectively _if_and_only_if_ Digital Input is used and an SPDIF =
source
is connected to it
   --> Not respecting this constraint may result in a byte alignment =
error
for the Analog Input stream see bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1801.

Currently, the ALSA driver sets all the Interfaces/Altsettings at =
"probing
time", and then chooses the correct interface/altsettings "on-demand".

My first patch only "hides" Altsettings that do not correspond to the
"device_setup" module parameter I introduced (because I have no other =
way to
know if the user is planning to use Digital Input or not).
  - the "device_setup" contains bits that say what the user is willing =
to
do: sample Resolution/Rate, which interface to enable (including Digital
Input activation or not)...

> but if it's complicated, it'd be better to make a change more=20

I don't thinks it's that tricky a couple of lines checking bit of
device_setup and just skipping some Interface/AltSettings =
initializations.

> generic. For example, we can add a hook as the argument to=20
> this function.  It's a function pointer which is called in=20
> the place where many USB_ID checks are for overriding with=20
> device-speicific values.

Yes, that's possible. I could create a quirk function
"parse_audio_endpoints_audiophile_quirk" and call it from
parse_audio_endpoints. I don't know if adding it as a function pointer
parameter to parse_audio_endpoints is interresting: it would be usefull =
only
if several other devices need quirks at the exact same point in the
function... But why not...

I'm also wondering if patching the "Interface/AltSetting" selection =
process
instead of the parse_audio_endpoint process would be cleaner: but I'm =
afraid
that the audiophile usb device is touchy and doesn't like the whole
Interfaces/Altsettings to have been initialized at first (and especially =
the
one that do not correspond to the Digital-Input state).

By the way, I still have an issue when trying to unregister the
snd-usb-audio module then probe it again with correct device_setup =
value: it
seems that my device is not reinitialized completely (even if I added
interfaces resets, set clear on endpoints and even a set configuration =
at
reprobing time [just testing patches]). I always need to turn off and =
then
on again the device so that the correct initlization is taken into =
account.

* Do you know a way of completely reset a usb device without having to =
turn
it off/on ?

Thanks for your comments and support.

Regards,
Thibault




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
