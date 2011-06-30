From: Diego Jacobi <jacobidiego@gmail.com>
Subject: Re: SBx00 Azalia ALC663 Working but MIC goes away
Date: Thu, 30 Jun 2011 00:15:06 -0300
Message-ID: <BANLkTi=syX6D334HCLrZN-_KUcjz9bCoTQ@mail.gmail.com>
References: <BANLkTinxBJ0bqd6PV6buXu_2ZfQKJmy6+A@mail.gmail.com>
	<BANLkTim1k6NzuryDE2_FENTNm1veUja+OQ@mail.gmail.com>
	<BANLkTi=ARHV819LS+JSR2spuj9Qri2_T2g@mail.gmail.com>
	<s5hk4c6yswi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DF02103915
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 05:15:26 +0200 (CEST)
Received: by fxh2 with SMTP id 2so2057961fxh.9
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2011 20:15:26 -0700 (PDT)
In-Reply-To: <s5hk4c6yswi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Takashi and Paul for your help.

It worked.

All the Front panel is working perfectly now.
Only my internal MIC is not working at all, but i dont care for it.

I had to follow the instructions from here:

http://en.opensuse.org/SDB:Alsa-update#OSS_Kernel_Section_-_If_you_have_NOT=
_updated_kernel_with_security_fixes_GO_HERE_to_this_OSS_section

I didnt knew my kernel was updated, or didnt remembered and the
instructions provided are not very clear, too repetitive for almost
the same thing.

For the records:

search for the kernel-default in the software installer aplication,
and see under versions, if the repository is the OSS or the Updates.
If the second one, then do:

# zypper ar http://download.opensuse.org/repositories/multimedia:/audio:/KM=
P/openSUSE_11.4_Update/
multimedia

# zypper install alsa-driver-kmp-default

# zypper rr multimedia

check if it is correctly installed with:

# modinfo snd-hda-intel | grep filename

filename:
/lib/modules/2.6.37.6-0.5-default/updates/alsa/pci/hda/snd-hda-intel.ko


Note: The update name of the repo, and the updates folder in the
kernel modules directory.

I dont know why we need to remove the repo, or if the updated driver
will be automatically updated on newer kernels or not.
But this update solved my issues.

Cheers.
I am unsubscribing now.

Diego


2011/6/28 Takashi Iwai <tiwai@suse.de>:
> At Tue, 28 Jun 2011 10:33:50 -0300,
> Diego Jacobi wrote:
>>
>> I already sended this mail to this list ... many times .. but it gets
>> bounced or wait for moderation. I find this annoying.
>> I am attaching the files compressed now.
>
> Thanks, but please don't cross-post both to alsa-devel and alsa-user.
>
>> I tested the solution mentioned by Takashi.
>> I have installed alsa-driver-kmp-default and restarted, but i found
>> =A0the same behavior so, i didnt make more alsa-info files.
>> However, i dont know what is "the right repository",
>
> Did you read the Wiki page there? =A0There are detailed descriptions
> there...
>
>> i choosed "multimedia:audio:KMP/openSUSE_11.4"
>> and also tested "multimedia:audio:KMP/openSUSE_11.4_Update" which
>> provided the same file.
>
> No, they definitely provide different files. =A0If you are using the
> updated 11.4 kernel, use openSUSE_11.4_Update repo, in general.
>
>> The file is installed in
>> linux-i1zx:/home/diego # modinfo snd-hda-intel | grep filename
>> filename:
>> /lib/modules/2.6.37.6-0.5-default/kernel/sound/pci/hda/snd-hda-intel.ko
>
> So the KMP module is *not* used there, thus further test results are
> useless, unfortunately.
>
>
> Takashi
>
