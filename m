From: Daniel Mack <zonque@gmail.com>
Subject: Re: `hda-intel: spurious response` several times in
 output of `dmesg`
Date: Wed, 31 Aug 2011 12:37:28 +0200
Message-ID: <CACTFLANPdSzg9KMhjdgn_=kuQZq+EnwA2cw0t+QT1RoWQ=nwCA@mail.gmail.com>
References: <1314185760.3628.30.camel@mattotaupa>
	<1314284537.26121.6.camel@mattotaupa>
	<1314785943.3769.30.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C88A103832
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 12:37:30 +0200 (CEST)
Received: by ywt32 with SMTP id 32so427620ywt.38
	for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2011 03:37:29 -0700 (PDT)
In-Reply-To: <1314785943.3769.30.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 31, 2011 at 12:19 PM, Paul Menzel
<paulepanter@users.sourceforge.net> wrote:
> Dear ALSA folks,
>
>
> Am Donnerstag, den 25.08.2011, 17:01 +0200 schrieb Paul Menzel:
>
> [=85]
>
>> I just want to add that I also see these messages with Linux kernel
>> 3.0.2 and say seem to be related to suspend and resume.
>>
>> The values seem to differ though every time.
>>
>> =A0 =A0 =A0 =A0 [ 1130.984969] hda-intel: spurious response 0x0:0x0, las=
t cmd=3D0x620000
>> =A0 =A0 =A0 =A0 [ 1130.984990] hda-intel: spurious response 0x1003c:0x0,=
 last cmd=3D0x620000
>> =A0 =A0 =A0 =A0 [ 1130.985011] hda-intel: spurious response 0x0:0x0, las=
t cmd=3D0x620000
>> =A0 =A0 =A0 =A0 [ 1130.985032] hda-intel: spurious response 0x10034:0x0,=
 last cmd=3D0x620000
>> =A0 =A0 =A0 =A0 [ 1130.985053] hda-intel: spurious response 0x0:0x0, las=
t cmd=3D0x620000
>>
>> =A0 =A0 =A0 =A0 [ =85 another suspend/resume =85 ]
>>
>> =A0 =A0 =A0 =A0 [ 2726.277102] hda-intel: spurious response 0x0:0x0, las=
t cmd=3D0x1e70700
>> =A0 =A0 =A0 =A0 [ 2726.277123] hda-intel: spurious response 0x0:0x0, las=
t cmd=3D0x1e70700
>> =A0 =A0 =A0 =A0 [ 2726.277144] hda-intel: spurious response 0x0:0x0, las=
t cmd=3D0x1e70700
>> =A0 =A0 =A0 =A0 [ 2726.277165] hda-intel: spurious response 0xb:0x0, las=
t cmd=3D0x1e70700
>>
>> Please find the output of `alsa-info.sh` [1] with this Linux version at
>> the end.
>
> who is the correct person to address these things to?

Takashi is maintaining this driver, but he is on vacation right now.
I'm sure he'll answer once he's back :)


Daniel
