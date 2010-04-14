From: Gregory T Flynn <gflynn1@binghamton.edu>
Subject: Re: no soundcards detected on MCP51 rev a
Date: Wed, 14 Apr 2010 13:44:13 -0400
Message-ID: <m2ub98465221004141044ub0cb4628zbebdc7a0a4e02524@mail.gmail.com>
References: <i2qb98465221004131406ze558772bq74e2ffac68e1f12a@mail.gmail.com>
	<r2m604760771004131619p2ac8d6fasb387dccb325a55ae@mail.gmail.com>
	<v2rb98465221004131834o14d1d48brba3a39da322e2011@mail.gmail.com>
	<y2rb98465221004140547m50808d75q5a896bea789b655e@mail.gmail.com>
	<s5hvdbuvx2n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 35BEE1037FB
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 19:44:14 +0200 (CEST)
Received: by vws1 with SMTP id 1so160470vws.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2010 10:44:14 -0700 (PDT)
In-Reply-To: <s5hvdbuvx2n.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

the options in the laptop's BIOS are rather sparse and nothing about
Sound card enable/disable

The soundcard works in Windows 7 and Ubuntu 8.04/8.10/9.04 Live USB images

results from probe_mask:

//options snd-hda-intel probe_mask=3D1 and for probe_mask=3D2

nuckin:~$ dmesg | grep hda
hda_intel: Disable MSI for Nvidia chipset
ALSA hda_intel.c:2518: chipset global capabilities =3D 0x770
ALSA hda_intel.c:909: codec_mask =3D 0xff
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:712: azx_get_response timeout, switching to polling
mode: last cmd=3D0x000f0000
ALSA hda_intel.c:1420: Codec #0 probe error; disabling it...
ALSA hda_intel.c:1447: no codecs initialized

//options snd-hda-intel probe_mask=3D3
nuckin:~$ dmesg | grep hda
hda_intel: Disable MSI for Nvidia chipset
ALSA hda_intel.c:2518: chipset global capabilities =3D 0x770
ALSA hda_intel.c:909: codec_mask =3D 0xff
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:712: azx_get_response timeout, switching to polling
mode: last cmd=3D0x000f0000
ALSA hda_intel.c:1420: Codec #0 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #1 probe error; disabling it...
ALSA hda_intel.c:1447: no codecs initialized

//probe_mask=3D4
nuckin:~$ dmesg | grep hda
hda_intel: Disable MSI for Nvidia chipset
ALSA hda_intel.c:2518: chipset global capabilities =3D 0x770
ALSA hda_intel.c:909: codec_mask =3D 0xff
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x200f0000
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x200f0000
ALSA hda_intel.c:712: azx_get_response timeout, switching to polling
mode: last cmd=3D0x200f0000
ALSA hda_intel.c:1420: Codec #2 probe error; disabling it...
ALSA hda_intel.c:1447: no codecs initialized

//probe_mask=3D5
nuckin:~$ dmesg | grep hda
hda_intel: Disable MSI for Nvidia chipset
ALSA hda_intel.c:2518: chipset global capabilities =3D 0x770
ALSA hda_intel.c:909: codec_mask =3D 0xff
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:712: azx_get_response timeout, switching to polling
mode: last cmd=3D0x000f0000
ALSA hda_intel.c:1420: Codec #0 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #2 probe error; disabling it...
ALSA hda_intel.c:1447: no codecs initialized

//probe_mask=3D6
nuckin:~$ dmesg | grep hda
hda_intel: Disable MSI for Nvidia chipset
ALSA hda_intel.c:2518: chipset global capabilities =3D 0x770
ALSA hda_intel.c:909: codec_mask =3D 0xff
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x100f0000
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x100f0000
ALSA hda_intel.c:712: azx_get_response timeout, switching to polling
mode: last cmd=3D0x100f0000
ALSA hda_intel.c:1420: Codec #1 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #2 probe error; disabling it...
ALSA hda_intel.c:1447: no codecs initialized

//probe_mask=3D7
nuckin:~$ dmesg | grep hda
hda_intel: Disable MSI for Nvidia chipset
ALSA hda_intel.c:2518: chipset global capabilities =3D 0x770
ALSA hda_intel.c:909: codec_mask =3D 0xff
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x000f0000
ALSA hda_intel.c:712: azx_get_response timeout, switching to polling
mode: last cmd=3D0x000f0000
ALSA hda_intel.c:1420: Codec #0 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #1 probe error; disabling it...
ALSA hda_intel.c:1420: Codec #2 probe error; disabling it...
ALSA hda_intel.c:1447: no codecs initialized

//probe_mask=3D8
nuckin:~$ dmesg | grep hda
hda_intel: Disable MSI for Nvidia chipset
ALSA hda_intel.c:2518: chipset global capabilities =3D 0x770
ALSA hda_intel.c:909: codec_mask =3D 0xff
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x300f0000
ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
once: last cmd=3D0x300f0000
ALSA hda_intel.c:712: azx_get_response timeout, switching to polling
mode: last cmd=3D0x300f0000
ALSA hda_intel.c:1420: Codec #3 probe error; disabling it...
ALSA hda_intel.c:1447: no codecs initialized


On Wed, Apr 14, 2010 at 12:05 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 14 Apr 2010 08:47:04 -0400,
> Gregory T Flynn wrote:
>>
>> No dice, configured with '--with-debug=3Dverbose':
>>
>> nuckin:~$ dmesg | grep hda
>> hda_intel: Disable MSI for Nvidia chipset
>> ALSA hda_intel.c:2518: chipset global capabilities =3D 0x770
>> ALSA hda_intel.c:909: codec_mask =3D 0xff
>> ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
>> once: last cmd=3D0x000f0000
>> ALSA hda_intel.c:702: azx_get_response timeout, polling the codec
>> once: last cmd=3D0x000f0000
>> ALSA hda_intel.c:712: azx_get_response timeout, switching to polling
>> mode: last cmd=3D0x000f0000
>> ALSA hda_intel.c:1420: Codec #0 probe error; disabling it...
>> ALSA hda_intel.c:1420: Codec #1 probe error; disabling it...
>> ALSA hda_intel.c:1420: Codec #2 probe error; disabling it...
>> ALSA hda_intel.c:1420: Codec #3 probe error; disabling it...
>> ALSA hda_intel.c:1420: Codec #4 probe error; disabling it...
>> ALSA hda_intel.c:1420: Codec #5 probe error; disabling it...
>> ALSA hda_intel.c:1420: Codec #6 probe error; disabling it...
>> ALSA hda_intel.c:1420: Codec #7 probe error; disabling it...
>
> Is the onboard sound enabled on BIOS?
>
> Also, try to add probe_mask=3D1 option to snd-hda-intel module.
> If this still doesn't work, try probe_mask=3D2, then probe_mask=3D4, and
> probe_mask=3D8. =A0If none of them works, then it's likely a hardware
> issue.
>
>
> Takashi
>



-- =

- Greg Flynn
