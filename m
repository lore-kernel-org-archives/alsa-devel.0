From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: ALSA changes in 2.6.23-rc6 for Intel HDA
Date: Thu, 13 Sep 2007 21:36:18 +0300
Message-ID: <200709132136.18387.maximlevitsky@gmail.com>
References: <9e4733910709110958h5756a50fi7540fe9d654d1557@mail.gmail.com>
	<200709131916.47518.maximlevitsky@gmail.com>
	<9e4733910709131015y7c1d4238ue4ee97ef5bff1e29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id ECC062437A
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 20:37:46 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so88074ana
	for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2007 11:37:45 -0700 (PDT)
In-Reply-To: <9e4733910709131015y7c1d4238ue4ee97ef5bff1e29@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 13 September 2007 20:15:00 Jon Smirl wrote:

those controls are fine:
> =A0=A0=A0=A0=A0=A0=A0=A0control.2 {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.access 'read writ=
e'
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.type INTEGER
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.count 2
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.range '0 - 4'
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0iface MIXER
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0name 'InMux Capture Volum=
e'
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0value.0 0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0value.1 0
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0control.3 {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.access 'read writ=
e'
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.type INTEGER
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.count 2
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.range '0 - 14'
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0iface MIXER
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0name 'InVol Capture Volum=
e'
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0value.0 0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0value.1 0
> =A0=A0=A0=A0=A0=A0=A0=A0}
They control amplification of sound that enters input lines. 0 means just p=
ass it as is
I rarely increase them

this should be enabled, if you want to record from device:
>=A0=A0=A0=A0=A0=A0=A0=A0control.4 {
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.access 'read write'
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.type BOOLEAN
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.count 2
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0iface MIXER
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0name 'ADCMux Capture Switc=
h'
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0value.0 false
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0value.1 false
>=A0=A0=A0=A0=A0=A0=A0=A0}


from my expirence (I also own STAC9227 btw), this is normal, and I even set=
 this to 100%
>=A0=A0=A0=A0=A0=A0=A0=A0control.5 {
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.access 'read write'
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.type INTEGER
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.count 2
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment.range '0 - 127'
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0iface MIXER
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0name 'Front Playback Volum=
e'
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0value.0 75
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0value.1 75
>=A0=A0=A0=A0=A0=A0=A0}


It looks like what you have now, is exactly what I always had
Maybe hardware is capable of louder sound, although I have studied the data=
sheet, and I havent seen that

Can you tell me exact version of kernel that allowed you to set higher volu=
me,
and can you test whenever you actually can set louder volumes on that kerne=
l, maybe it has a bug

Btw, I have sent quite a lot of patches for this driver, for example, you w=
ill have 'Master Volume' control,
and you will be able to record at same time from all three inputs, I added =
support for analog loopback.
and ADCMux is now called just 'Capture switch'



If you want to try, you can try ALSA 1.0.15rc2

Best regards,
	Maxim Levitsky
