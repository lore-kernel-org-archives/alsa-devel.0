From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: Problem with VIA VT1708S and git versions of
	alsa-driver.
Date: Wed, 26 Jan 2011 21:04:24 +0200
Message-ID: <AANLkTimiwTcnCnGECN8jpzY2VaMTmpcHBx-qmFDmwxSY@mail.gmail.com>
References: <AANLkTikaYCybUxW7dE3tizYZztT8pVo6Jeg-mh=e0NqZ@mail.gmail.com>
	<AANLkTi=UTy8tdLqL-90UJOXtU=Ks1+ZZrGV2nCbw=xjD@mail.gmail.com>
	<AANLkTinYcRqMwH2FSUjXiOxZg4x09q673FL9m15YvXEa@mail.gmail.com>
	<AANLkTik8HayTEADWn74PJ0NgjGunamsSAZpy_GanuZo3@mail.gmail.com>
	<AANLkTimz3iiXPhEarEUY1Gw5GxrTuv+UXgKKZS3ObzuS@mail.gmail.com>
	<AANLkTi=S20cpKy-CObvKB-OLDKbQ7FBhFrbnd448B+sO@mail.gmail.com>
	<AANLkTikyjZvD+ptCcgBrN2av-jQmKWOekbzvfXYAdpOV@mail.gmail.com>
	<AANLkTim_A5m2MryxmkEHtcc3gNFWTaRW8J3=dZC6wd67@mail.gmail.com>
	<AANLkTinUWD9Oq2iAbn_nc5E+M=y4yXx4u0Eff9jYSGyk@mail.gmail.com>
	<AANLkTimcAUn=+1B3=LJbD7dBBZ3NvaeX_q+_sHP6QhB3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B0231037EA
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 20:04:47 +0100 (CET)
Received: by vxb40 with SMTP id 40so42109vxb.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 11:04:45 -0800 (PST)
In-Reply-To: <AANLkTimcAUn=+1B3=LJbD7dBBZ3NvaeX_q+_sHP6QhB3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Oct 11, 2010 at 1:09 AM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> 2010/10/11 Mark Goldstein <goldstein.mark@gmail.com>
>
>> I noticed one visible change: Input Source had "Rear Mic" instead of "Mi=
c".
>>
>>
> spec->private_imux[1] is un-initialised before calling create_hp_imux()
> however there is no node with connection list which can be used as input =
mix
> for "independent HP" control
>
> How about "Mic Boost" ?
>
> if "Mic" is changed to "Rear Mic" , "Mic Boost Capture Volume" should also
> be changed to "Rear Mic Boost Capture Volume "
>
>
> static struct snd_kcontrol_new vt1708S_capture_mixer[] =3D {
>
> =A0 =A0 =A0 =A0 HDA_CODEC_VOLUME("Capture Volume", 0x13, 0x0, HDA_INPUT),
> =A0 =A0 =A0 =A0 HDA_CODEC_MUTE("Capture Switch", 0x13, 0x0, HDA_INPUT),
> =A0 =A0 =A0 =A0 HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x14, 0x0, HDA_=
INPUT),
> =A0 =A0 =A0 =A0 HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x14, 0x0, HDA_IN=
PUT),
> =A0 =A0 =A0 =A0 HDA_CODEC_VOLUME("Mic Boost Capture Volume", 0x1A, 0x0, H=
DA_INPUT),
> =A0 =A0 =A0 =A0 HDA_CODEC_VOLUME("Front Mic Boost Capture Volume", 0x1E, =
0x0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HDA_INPUT),

I've renewed my experiments after long break (sorry, had to do other
stuff and since released version 1.0.23 worked for me, I reverted to
that version).

I still have not tried hda-emulator, but I made some progress.

1) I compiled the git version (snapshot from Jan 20) for OpenSUSE 11.1
with test kernel 2.6.32.28.
I saw the same behavior as before:
- Line control does nothing;
- Front Mic control actually changes volume of Line In;
- Neither Front nor Rear Mic work at all; (Answering to Raymond's
question regarding Mic Boost - I have "Rear Mic" control, but Mic
Boost).

2) I decided to compare patch.via.c from version 1.0.23 that works for
me and git version.
It appears to me that the clue could be found in the function
vt1708S_auto_create_analog_input_ctls. The one in 1.0.23 uses explicit
control indexes, while the function from git version calls
vt_auto_create_analog_input_ctls, passing it the array of indexes:
static hda_nid_t pin_idxs[] =3D { 0x1f, 0x1a, 0x1b, 0x1e, 0, 0xff };

Comparing the indexes used in  vt1708S_auto_create_analog_input_ctls
with those used for other codec and with version from 1.0.23, I
started suspecting that the order of indexes is wrong. I changed the
array like this:
static hda_nid_t pin_idxs[] =3D { 0, 0x1f, 0x1a, 0x1b, 0x1e, 0xff };
After re-compiling the version I've got much better behavior:
- Line control (index 1b) works correctly now;
- Front Mic control (index 0x1e) actually controls Rear Mic and this
Rear Mic works;
- Front mic still does not work;
- Rear Mic control (index 0x1a) seems not working and there is still
Mic Boost, not Rear Mic Boost.

Maybe someone who knows the code could look at this function and
suggest how to fix it?

Regards,
-- =

Mark Goldstein
