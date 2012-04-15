From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [RFC/PATCH] control_external: Add ability to
	specify TLV data.
Date: Sun, 15 Apr 2012 16:59:12 -0700
Message-ID: <CAEUnVG4cY3-DthPZw+foncvX9kM_C6=anxdiORN6EbR8XiRunQ@mail.gmail.com>
References: <1334457386-31647-1-git-send-email-dgreid@chromium.org>
	<s5haa2dp0qw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F1F62499E
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 01:59:33 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so3450329wgb.20
	for <alsa-devel@alsa-project.org>; Sun, 15 Apr 2012 16:59:32 -0700 (PDT)
In-Reply-To: <s5haa2dp0qw.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 15, 2012 at 6:45 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 14 Apr 2012 19:36:26 -0700,
> Dylan Reid wrote:
>>
>> Allow external control plugins to provide TLV data. =A0This allows
>> user-space pcms to specify dB ranges for controls.
>>
>> This follows the same model as the ALSA drivers for accessing the
>> data. =A0The code is based on that implementation. =A0The control can
>> provide static data or a callback. =A0The data is accessed or modified
>> in the new snd_ctl_ext_elem_tlv callback.
>>
>> Rev bump the protocol version to enable checking if an external
>> control supports TLV.
>>
>> Signed-off-by: Dylan Reid <dgreid@chromium.org>
>> ---
>> =A0include/control_external.h | =A0 17 +++++++++++++++-
>> =A0src/control/control_ext.c =A0| =A0 46 +++++++++++++++++++++++++++++++=
+++++++++++++
>> =A02 files changed, 62 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/control_external.h b/include/control_external.h
>> index 7c066cf..5392ea6 100644
>> --- a/include/control_external.h
>> +++ b/include/control_external.h
>> @@ -60,13 +60,16 @@ typedef struct snd_ctl_ext snd_ctl_ext_t;
>> =A0typedef struct snd_ctl_ext_callback snd_ctl_ext_callback_t;
>> =A0/** Key to access a control pointer */
>> =A0typedef unsigned long snd_ctl_ext_key_t;
>> +/** Callback to handle TLV commands. */
>> +typedef int (snd_ctl_ext_tlv_rw_t)(snd_ctl_ext_t *ext, snd_ctl_ext_key_=
t key, int op_flag, unsigned int numid,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d int *tlv, unsigned int tlv_size);
>>
>> =A0/*
>> =A0 * Protocol version
>> =A0 */
>> =A0#define SND_CTL_EXT_VERSION_MAJOR =A0 =A01 =A0 =A0 =A0 /**< Protocol =
major version */
>> =A0#define SND_CTL_EXT_VERSION_MINOR =A0 =A00 =A0 =A0 =A0 /**< Protocol =
minor version */
>> -#define SND_CTL_EXT_VERSION_TINY =A0 =A0 0 =A0 =A0 =A0 /**< Protocol ti=
ny version */
>> +#define SND_CTL_EXT_VERSION_TINY =A0 =A0 1 =A0 =A0 =A0 /**< Protocol ti=
ny version */
>> =A0/**
>> =A0 * external plugin protocol version
>> =A0 */
>> @@ -122,6 +125,13 @@ struct snd_ctl_ext {
>> =A0 =A0 =A0 =A0* control handle filled by #snd_ctl_ext_create()
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 snd_ctl_t *handle;
>> + =A0 =A0 /**
>> + =A0 =A0 =A0* optional TLV data for the control.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 union {
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_ctl_ext_tlv_rw_t *c;
>> + =A0 =A0 =A0 =A0 =A0 =A0 const unsigned int *p;
>> + =A0 =A0 } tlv;
>>
>> =A0 =A0 =A0 int nonblock; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /**< non-b=
lock mode; read-only */
>> =A0 =A0 =A0 int subscribed; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /**< events =
subscribed; read-only */
>> @@ -245,7 +255,12 @@ typedef enum snd_ctl_ext_access {
>> =A0 =A0 =A0 SND_CTL_EXT_ACCESS_WRITE =3D (1<<1),
>> =A0 =A0 =A0 SND_CTL_EXT_ACCESS_READWRITE =3D (3<<0),
>> =A0 =A0 =A0 SND_CTL_EXT_ACCESS_VOLATILE =3D (1<<2),
>> + =A0 =A0 SND_CTL_EXT_ACCESS_TLV_READ =3D (1<<4),
>> + =A0 =A0 SND_CTL_EXT_ACCESS_TLV_WRITE =3D (1<<5),
>> + =A0 =A0 SND_CTL_EXT_ACCESS_TLV_READWRITE =3D (3<<4),
>> + =A0 =A0 SND_CTL_EXT_ACCESS_TLV_COMMAND =3D (1<<6),
>> =A0 =A0 =A0 SND_CTL_EXT_ACCESS_INACTIVE =3D (1<<8),
>> + =A0 =A0 SND_CTL_EXT_ACCESS_TLV_CALLBACK =3D (1<<28),
>> =A0} snd_ctl_ext_access_t;
>>
>> =A0/**
>> diff --git a/src/control/control_ext.c b/src/control/control_ext.c
>> index e20d4f3..0a0b397 100644
>> --- a/src/control/control_ext.c
>> +++ b/src/control/control_ext.c
>> @@ -324,6 +324,51 @@ static int snd_ctl_ext_elem_unlock(snd_ctl_t *handl=
e ATTRIBUTE_UNUSED,
>> =A0 =A0 =A0 return -ENXIO;
>> =A0}
>>
>> +static int snd_ctl_ext_elem_tlv(snd_ctl_t *handle, int op_flag,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int n=
umid,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int *=
tlv, unsigned int tlv_size)
>> +{
>> + =A0 =A0 snd_ctl_ext_t *ext =3D handle->private_data;
>> + =A0 =A0 snd_ctl_ext_key_t key;
>> + =A0 =A0 int type, ret;
>> + =A0 =A0 unsigned int access, count, len;
>> + =A0 =A0 snd_ctl_elem_id_t id;
>> +
>> + =A0 =A0 /* we don't support TLV on protocol ver 1.0.0 or earlier */
>> + =A0 =A0 if (ext->version < SNDRV_PROTOCOL_VERSION(1, 0, 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
>
> Shouldn't this be "<=3D" ?
It certainly should.
>
> Other than that, I like the implementation, looks pretty
> straightforward.

Thanks for taking the time to look at it, fixed version on the way.

-dg
>
>
> thanks,
>
> Takashi
>
>
>> +
>> + =A0 =A0 snd_ctl_elem_id_clear(&id);
>> + =A0 =A0 if (numid > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ext->callback->elem_list(ext, numid - 1, &id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 id.numid =3D numid;
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 id.numid =3D 0;
>> + =A0 =A0 key =3D ext->callback->find_elem(ext, &id);
>> +
>> + =A0 =A0 if (key =3D=3D SND_CTL_EXT_KEY_NOT_FOUND)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
>> + =A0 =A0 ret =3D ext->callback->get_attribute(ext, key, &type, &access,=
 &count);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> +
>> + =A0 =A0 if ((op_flag =3D=3D 0 && (access & SND_CTL_EXT_ACCESS_TLV_READ=
) =3D=3D 0) ||
>> + =A0 =A0 =A0 =A0 (op_flag > 0 && (access & SND_CTL_EXT_ACCESS_TLV_WRITE=
) =3D=3D 0) ||
>> + =A0 =A0 =A0 =A0 (op_flag < 0 && (access & SND_CTL_EXT_ACCESS_TLV_COMMA=
ND) =3D=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
>> + =A0 =A0 if (access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ext->tlv.c(ext, key, op_flag, numid, tl=
v, tlv_size);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (op_flag)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 len =3D ext->tlv.p[1] + 2 * sizeof(unsigned in=
t);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (tlv_size < len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(tlv, ext->tlv.p, len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> +}
>> +
>> =A0static int snd_ctl_ext_next_device(snd_ctl_t *handle ATTRIBUTE_UNUSED,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *=
device ATTRIBUTE_UNUSED)
>> =A0{
>> @@ -429,6 +474,7 @@ static const snd_ctl_ops_t snd_ctl_ext_ops =3D {
>> =A0 =A0 =A0 .element_write =3D snd_ctl_ext_elem_write,
>> =A0 =A0 =A0 .element_lock =3D snd_ctl_ext_elem_lock,
>> =A0 =A0 =A0 .element_unlock =3D snd_ctl_ext_elem_unlock,
>> + =A0 =A0 .element_tlv =3D snd_ctl_ext_elem_tlv,
>> =A0 =A0 =A0 .hwdep_next_device =3D snd_ctl_ext_next_device,
>> =A0 =A0 =A0 .hwdep_info =3D snd_ctl_ext_hwdep_info,
>> =A0 =A0 =A0 .pcm_next_device =3D snd_ctl_ext_next_device,
>> --
>> 1.7.9.rc0
>>
