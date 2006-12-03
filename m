From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: RE :  [PATCH 1.0.13 1/2] M-Audio USB
Date: Sun, 03 Dec 2006 12:49:06 +0100
Message-ID: <20061203124906.uqfxupazcc4444wc@webmail.supelec.fr>
References: <004801c70fe1$038e8ac0$161ce4a0@supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <004801c70fe1$038e8ac0$161ce4a0@supelec.fr>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>> -----Message d'origine-----
>> De : alsa-devel-bounces@lists.sourceforge.net
>> [mailto:alsa-devel-bounces@lists.sourceforge.net] De la part
>> de Pavel Polischouk
>> Envoy=E9 : vendredi 24 novembre 2006 05:36
>> =C0 : alsa-devel@lists.sourceforge.net
>> Objet : [Alsa-devel] [PATCH 1.0.13 1/2] M-Audio USB
>>
>>
>> This patch adds the following capabilities to usbaudio.c:
>> - Merges support for M-Audio FastTrack USB
>> - Adds proper support for M-Audio Quattro USB
>> - Adds hot-reload support for all Audiophile, FastTrack and Quattro.
>
> This sounds great and I've had a quick look at the patches which look ok =
for
> me (at least it shouldn't break anything ;-) ).
>
>> This works quite well on Quattro;
>> Thibault, could you please verify that it works for Audiophile?

Sorry for the delay but I had to re-install my linux system from scratch...

Here is my test report:

Summary
=3D=3D=3D=3D=3D=3D=3D

With this patch one can now switch Sample depth/rate modes without  =

having to turn the device off and then on again.

However, it does not correct the corrupted initialization state that  =

occur when the device is turned on before the snd-usb-audio module is  =

initialized with a valid device_setup parameter.

Tests
=3D=3D=3D=3D=3D

A- This test shows that the device must still be correctly initialized  =

at first use

* turn on the device without no specific snd-usb-audio parameters  =

(equivalent to device_setup =3D0x00)
* the sound captured from the Analog interface is corrupted (as  =

described in  =

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1801)
* unregister the snd-usb-audio interface
* register the snd-usb-audio interface with device_setup=3D0x09
* the sound captured from the Analog interface is still corrupted
* turning the device off, then on again gets back to a working analog  =

capture in
terface

B- This test shows that once correctly initialized, it is now possible  =

to switch modes without having to turn off the device

* the device is turned on after having initialized the snd-usb-audio  =

driver with a valid device_setup parameter (for instance 24bits with  =

no digital Input)
   # modprobe -r snd-usb-audio
   # modprobe snd-usb-audio device_setup=3D0x09

* It is then possible to switch mode without having to turn off the  =

device. For instance swicthing from 24bits to 16 bits (without Digital  =

Input) with the following commands make the analog capture interface  =

work in 16bits mode.
   # modprobe -r snd-usb-audio
   # modprobe snd-usb-audio device_setup=3D0x01

As far as the documentation is concerned, shouldn't be better to keep  =

an Audiophile-USB.txt file with only the "Updated documentation on  =

this device can now be found in the M-Audio.txt file" sentence?
This could be useful for people finding references to the  =

Audiopphile-USB.txt file in mailing lists, Alsa bug-tracker, ...

Regards,
Thibault


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
