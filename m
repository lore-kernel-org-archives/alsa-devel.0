From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: Problem with VIA VT1708S and git versions of
	alsa-driver.
Date: Thu, 27 Jan 2011 13:26:34 +0200
Message-ID: <AANLkTimQ+evOVnG78UWPhCORKo2VvXyzVO8BhTrzSnVG@mail.gmail.com>
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
	<AANLkTimiwTcnCnGECN8jpzY2VaMTmpcHBx-qmFDmwxSY@mail.gmail.com>
	<AANLkTi=14Q53BtcafboP=qz2-9AEcnnE3UD+HTwoGtbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5590024685
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 12:26:58 +0100 (CET)
Received: by gxk21 with SMTP id 21so651956gxk.38
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 03:26:55 -0800 (PST)
In-Reply-To: <AANLkTi=14Q53BtcafboP=qz2-9AEcnnE3UD+HTwoGtbe@mail.gmail.com>
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

On Thu, Jan 27, 2011 at 11:09 AM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> 2011/1/27 Mark Goldstein <goldstein.mark@gmail.com>
>
>> Hi,
>>
>> I've renewed my experiments after long break (sorry, had to do other
>> stuff and since released version 1.0.23 worked for me, I reverted to
>> that version).
>>
>> I still have not tried hda-emulator, but I made some progress.
>>
>> 1) I compiled the git version (snapshot from Jan 20) for OpenSUSE 11.1
>> with test kernel 2.6.32.28.
>> I saw the same behavior as before:
>> - Line control does nothing;
>> - Front Mic control actually changes volume of Line In;
>> - Neither Front nor Rear Mic work at all; (Answering to Raymond's
>> question regarding Mic Boost - I have "Rear Mic" control, but Mic
>> Boost).
>>
>> 2) I decided to compare patch.via.c from version 1.0.23 that works for
>> me and git version.
>> It appears to me that the clue could be found in the function
>> vt1708S_auto_create_analog_input_ctls. The one in 1.0.23 uses explicit
>> control indexes, while the function from git version calls
>> vt_auto_create_analog_input_ctls, passing it the array of indexes:
>> static hda_nid_t pin_idxs[] =3D { 0x1f, 0x1a, 0x1b, 0x1e, 0, 0xff };
>>
>> Comparing the indexes used in =A0vt1708S_auto_create_analog_input_ctls
>> with those used for other codec and with version from 1.0.23, I
>> started suspecting that the order of indexes is wrong. I changed the
>> array like this:
>> static hda_nid_t pin_idxs[] =3D { 0, 0x1f, 0x1a, 0x1b, 0x1e, 0xff };
>> After re-compiling the version I've got much better behavior:
>> - Line control (index 1b) works correctly now;
>> - Front Mic control (index 0x1e) actually controls Rear Mic and this
>> Rear Mic works;
>> - Front mic still does not work;
>> - Rear Mic control (index 0x1a) seems not working and there is still
>> Mic Boost, not Rear Mic Boost.
>>
>>
> Do you mean that regiession is caused by this patch ?
>
> http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommitdiff;h=3Df3268=
512c3a5dea587cfe875b8bca98d9e164cd9;hp=3D73413b120d5d6eb6c98451bbc19acf43e0=
e300ae

Yes, looks very probable. Additional confirmation to this is that I
noticed the problem at the beginning of September after installing git
version; this patch is dated by Aug 30th.

> it seem vt_auto_create_analog_input_ctls() try to assign stereo mixer as =
the
> first item of the imux(s) node 0x17 and 0x1e
>
> assign those playback volume of those input pins in to stereo mixer for n=
ode
> 0x16
>
> but it should assign auto_pin_cfg_labels[] according to the imux node 0x17
> and 0x1e

Is the order of controls in hda_nid_t_pin_idxs fixed, or depends on
specific codec?

In any case, I will probably try to temporary replace the
vt1708S_auto_create_analog_input_ctls by the one from 1.0.23 and see
if this will fix the issue.

Thanks,
-- =

Mark Goldstein
