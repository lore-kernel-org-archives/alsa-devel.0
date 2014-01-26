From: Ionica Bizau <bizauionica@yahoo.com>
Subject: Re: External sound card issue
Date: Sun, 26 Jan 2014 09:35:39 -0800 (PST)
Message-ID: <1390757739.44066.YahooMailNeo@web162302.mail.bf1.yahoo.com>
References: <CAEiHY5j=K874m_Jk7ws4eOqts855oSHqY0HUrp_A5WwxFoDr=Q@mail.gmail.com>	<52DD1A66.9050909@ladisch.de>
 <CAN8cciYR_9Le-tX-CLBjfnYQ1+CuexKzxpxberVkkV6jR_c50A@mail.gmail.com>
 <1390398693.24097.YahooMailNeo@web162304.mail.bf1.yahoo.com>
Reply-To: Ionica Bizau <bizauionica@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm46-vm5.bullet.mail.bf1.yahoo.com
 (nm46-vm5.bullet.mail.bf1.yahoo.com [216.109.115.108])
 by alsa0.perex.cz (Postfix) with ESMTP id A573E2617A5
 for <alsa-devel@alsa-project.org>; Sun, 26 Jan 2014 18:35:40 +0100 (CET)
In-Reply-To: <1390398693.24097.YahooMailNeo@web162304.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Ionica Bizau <bizauionica@gmail.com>
List-Id: alsa-devel@alsa-project.org

Please tell me if this is possible to be fixed...
I really need this information.

If yes, in how many days...?
This is very important for me...




On Wednesday, January 22, 2014 3:51 PM, Ionica Bizau <bizauionica@yahoo.com=
> wrote:
 =

Hi Clemens and Raymond,

First of all please tell me if this can be fixed. I can be patient and wait=
 until you fix it but if it's not possible I will return the external audio=
 card to the shop.

Here you see the alsa information: http://www.alsa-project.org/db/?f=3D869e=
c0f1ade49a17bc50e9f62a1e8881f7b4cf91


(just uploaded it)

Below you have the commands and their output:

ionicabizau@laptop:~$ amixer -c1 controls
numid=3D7,iface=3DMIXER,name=3D'PCM Capture Source'
numid=3D5,iface=3DMIXER,name=3D'PCM Capture Switch'
numid=3D6,iface=3DMIXER,name=3D'PCM Capture Switch',index=3D1
numid=3D4,iface=3DMIXER,name=3D'IEC958 In Playback Switch'
numid=3D3,iface=3DMIXER,name=3D'Input Gain Pad Control'
numid=3D1,iface=3DMIXER,name=3D'Speaker Playback Switch'
numid=3D2,iface=3DMIXER,name=3D'Speaker Playback Volume'
ionicabizau@laptop:~$ amixer -c1 cget name=3D'PCM Capture Source'
numid=3D7,iface=3DMIXER,name=3D'PCM Capture Source'
=A0 ; type=3DENUMERATED,access=3Drw------,values=3D1,items=3D2
=A0 ; Item #0 'Unit 22'
=A0 ; Item #1 'Unit 22'
amixer: Control hw:1 element read error: Broken pipe

ionicabizau@laptop:~$ amixer -c1 cget name=3D'PCM Capture Switch'
numid=3D5,iface=3DMIXER,name=3D'PCM Capture
 Switch'
=A0 ; type=3DBOOLEAN,access=3Drw------,values=3D1
=A0 : values=3Don
ionicabizau@laptop:~$ amixer -c1 cget name=3D'PCM Capture Switch'
numid=3D5,iface=3DMIXER,name=3D'PCM Capture Switch'
=A0 ; type=3DBOOLEAN,access=3Drw------,values=3D1
=A0 : values=3Don
ionicabizau@laptop:~$ amixer -c1 cget name=3D'IEC958 In Playback Switch'
numid=3D4,iface=3DMIXER,name=3D'IEC958 In Playback Switch'
=A0 ; type=3DBOOLEAN,access=3Drw------,values=3D1
=A0 : values=3Doff
ionicabizau@laptop:~$ amixer -c1 cget name=3D'Input Gain Pad Control'
numid=3D3,iface=3DMIXER,name=3D'Input Gain Pad Control'
=A0 ; type=3DBOOLEAN,access=3Drw------,values=3D2
=A0 : values=3Doff,off
ionicabizau@laptop:~$ amixer -c1 cget name=3D'Speaker Playback Switch'
numid=3D1,iface=3DMIXER,name=3D'Speaker Playback Switch'
=A0 ; type=3DBOOLEAN,access=3Drw------,values=3D1
=A0 : values=3Don
ionicabizau@laptop:~$ amixer -c1 cget name=3D'Speaker Playback
 Volume'
numid=3D2,iface=3DMIXER,name=3D'Speaker Playback Volume'
=A0 ; type=3DINTEGER,access=3Drw---R--,values=3D8,min=3D0,max=3D127,step=3D0
=A0 : values=3D107,107,107,107,107,107,107,107
=A0 | dBminmax-min=3D-127.00dB,max=3D0.00dB






On Monday, January 20, 2014 3:01 PM, Raymond Yau <superquad.vortex2@gmail.c=
om> wrote:
 =






2014/1/20 Clemens Ladisch <clemens@ladisch.de>

Ionica Bizau wrote:
>> I have just bought an external sound card: Asus Xonar U7
>>
>
>> =A0 =A0 cannot load mixer controls: Broken pipe
>
>This looks like a bug in the device's firmware.
>
>Can you at least read the list of controls ("amixer -c1 controls")?
>Are there some controls that you are able to access (try
>"amixer -c1 cget name=3D'xxx'" for each one)?
>
>
alsactl store -f abc.txt
alsactl: get_control:256: Cannot read control '2,0,0,PCM Capture Source,0':=
 Broken =


[  398.119996] cannot get ctl value: req =3D 0x81, wValue =3D 0x0, wIndex =
=3D 0x1400, type =3D 3


seem fail to read the capture source control


state.Device {
=A0control.1 {
=A0=A0iface PCM
=A0=A0name 'Playback Channel Map'
=A0=A0value.0 0
=A0=A0value.1 0
=A0=A0comment {
=A0=A0=A0access read
=A0=A0=A0type INTEGER
=A0=A0=A0count 2
=A0=A0=A0range '0 - 36'
=A0=A0}
=A0}
=A0control.2 {
=A0=A0iface PCM
=A0=A0device 1
=A0=A0name 'Playback Channel Map'
=A0=A0value.0 0
=A0=A0value.1 0
=A0=A0comment {
=A0=A0=A0access read
=A0=A0=A0type INTEGER
=A0=A0=A0count 2
=A0=A0=A0range '0 - 36'
=A0=A0}
=A0}
=A0control.3 {
=A0=A0iface MIXER
=A0=A0name 'PCM Playback Switch'
=A0=A0value true
=A0=A0comment {
=A0=A0=A0access 'read write'
=A0=A0=A0type BOOLEAN
=A0=A0=A0count 1
=A0=A0}
=A0}
=A0control.4 {
=A0=A0iface MIXER
=A0=A0name 'PCM Playback Switch'
=A0=A0index 1
=A0=A0value true
=A0=A0comment {
=A0=A0=A0access 'read write'
=A0=A0=A0type BOOLEAN
=A0=A0=A0count 1
=A0=A0}
=A0}
=A0control.5 {
=A0=A0iface MIXER
=A0=A0name 'PCM Playback Volume'
=A0=A0value.0 107
=A0=A0value.1 107
=A0=A0value.2 107
=A0=A0value.3 107
=A0=A0value.4 107
=A0=A0value.5 107
=A0=A0value.6 107
=A0=A0value.7 107
=A0=A0comment {
=A0=A0=A0access 'read write'
=A0=A0=A0type INTEGER
=A0=A0=A0count 8
=A0=A0=A0range '0 - 127'
=A0=A0=A0dbmin -12700
=A0=A0=A0dbmax 0
=A0=A0=A0dbvalue.0 -2000
=A0=A0=A0dbvalue.1 -2000
=A0=A0=A0dbvalue.2 -2000
=A0=A0=A0dbvalue.3 -2000
=A0=A0=A0dbvalue.4 -2000
=A0=A0=A0dbvalue.5 -2000
=A0=A0=A0dbvalue.6 -2000
=A0=A0=A0dbvalue.7 -2000
=A0=A0}
=A0}
=A0control.6 {
=A0=A0iface MIXER
=A0=A0name 'Mic Capture Switch'
=A0=A0value true
=A0=A0comment {
=A0=A0=A0access 'read write'
=A0=A0=A0type BOOLEAN
=A0=A0=A0count 1
=A0=A0}
=A0}
=A0control.7 {
=A0=A0iface MIXER
=A0=A0name 'Line Capture Switch'
=A0=A0value true
=A0=A0comment {
=A0=A0=A0access 'read write'
=A0=A0=A0type BOOLEAN
=A0=A0=A0count 1
=A0=A0}
=A0}
=A0control.8 {
=A0=A0iface MIXER
=A0=A0name 'PCM Capture Source'
=A0=A0value Mic
=A0=A0comment {
=A0=A0=A0access 'read write'
=A0=A0=A0type ENUMERATED
=A0=A0=A0count 1
=A0=A0=A0item.0 Mic
=A0=A0=A0item.1 Line

=A0=A0}
=A0}
}
