From: "Pamela K. Clift" <pclift@pianodisc.com>
Subject: adding volume to raw-midi device
Date: Fri, 27 Oct 2006 10:20:21 -0700
Message-ID: <4A9D3274C93BF5409FEAB520ADD94429172B2B@exchange01-srv.pianodisc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6F9EC.2E4EE070"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6F9EC.2E4EE070
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am starting this email again.  I know I had one response before but I =
can not get to it.  Most of our office building has burnt down to the =
ground.  It has taken a while to get things back up and for me to be =
able to get back to this.




I am new to alsa and I am trying to write a raw-midi device driver.  =
When I tried to add the volume control I could not compile the file =
anymore.  I am hoping someone can help me and see what I am missing.  I =
have looked in the Writing an Alsa Driver chapter 6 and I have looked at =
dummy.c .  I believe I am following what they say to do but when I =
compile the file I get many errors including "warning: "struct =
snd_ctl_elem_info declared inside parameter list"   I have at the top of =
my file #include <sound/control.h> along with the other includes I see =
in the sample files.  Below is the code I added.

static int snd_ld_volume_info(struct snd_kcontrol *kcontrol,
                 struct snd_ctl_elem_info *uinfo)
{
    uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
    uinfo->count =3D 1;
    uinfo->value.integer.min =3D 0;
    uinfo->value.integer.max =3D 127;
    return 0;
}
=20
static int snd_ld_volume_get(struct snd_kcontrol *kcontrol,
                struct snd_ctl_elem_value *ucontrol)
{
    struct snd_card_ld *ld =3D snd_kcontrol_chip(kcontrol);
    int addr =3D kcontrol->private_value;

    spin_lock_irq(&ld->mixer_lock);
    ucontrol->value.integer.value[0] =3D ld->mixer_volume[addr];
    spin_unlock_irq(&ld->mixer_lock);
    return 0;
}

static int snd_ld_volume_put(struct snd_kcontrol *kcontrol,
                struct snd_ctl_elem_value *ucontrol)
{
    struct snd_card_ld *ld =3D snd_kcontrol_chip(kcontrol);
    int changed =3D 0, addr =3D kcontrol->private_value;
    int value;

    value =3D ucontrol->value.integer.value[0];
    if (value < 0)
        value =3D 0;
    if (value > 127)
        value =3D 127;
    spin_lock_irq(&ld->mixer_lock);
    changed =3D ld->mixer_volume[addr] !=3D value;
    ld->mixer_volume[addr] =3D value;
    spin_unlock_irq(&ld->mixer_lock);
    return changed;
}

static struct snd_kcontrol_new snd_ld_volume =3D {
  .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,=20
  .name =3D "Master Playback Volume",=20
  .index =3D 0,
  .info =3D snd_ld_volume_info,
  .get =3D snd_ld_volume_get,=20
  .put =3D snd_ld_volume_put,
  .private_value =3D addr
};

static int __init snd_card_ld_new_mixer(struct snd_card_ld *ld)
{
  struct snd_card *card =3D ld->card;
  int err;

  snd_assert(ld !=3D NULL, return -EINVAL);
  spin_lock_init(&ld->mixer_lock);
  strcpy(card->mixername, "LD Mixer");

  if ((err =3D snd_ctl_add(card, snd_ctl_new1(&snd_ld_volume, ld)))
                                                                   < 0)
    return err;
  return 0;
}

static int __init snd_card_ld_probe(int dev)
{
  snd_card_t *card;
  struct snd_card_ld *ld;
  int err;

(many things, deleted here since I believe not relevent to problem)

  /* add mixer volume */
  if ((err =3D snd_card_ld_new_mixer(ld)) < 0)
    return err;

attached is the error output from trying to compile this.
 <<output2.txt>>=20

------_=_NextPart_001_01C6F9EC.2E4EE070
Content-Type: text/plain;
	name="output2.txt"
Content-Transfer-Encoding: base64
Content-Description: output2.txt
Content-Disposition: attachment;
	filename="output2.txt"

L3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzo5OTc6IHdhcm5p
bmc6ICJzdHJ1Y3Qgc25kX2N0bF9lbGVtX2luZm8iIGRlY2xhcmVkIGluc2lkZSBwYXJhbWV0ZXIg
bGlzdAovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5jOjk5Nzog
d2FybmluZzogaXRzIHNjb3BlIGlzIG9ubHkgdGhpcyBkZWZpbml0aW9uIG9yIGRlY2xhcmF0aW9u
LCB3aGljaCBpcyBwcm9iYWJseSBub3Qgd2hhdCB5b3Ugd2FudAovdXNyL3NyYy9hbHNhL2Fsc2Et
ZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5jOjk5Nzogd2FybmluZzogInN0cnVjdCBzbmRfa2Nv
bnRyb2wiIGRlY2xhcmVkIGluc2lkZSBwYXJhbWV0ZXIgbGlzdAovdXNyL3NyYy9hbHNhL2Fsc2Et
ZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5jOiBJbiBmdW5jdGlvbiBgc25kX2xkX3ZvbHVtZV9p
bmZvJzoKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzo5OTk6
IGVycm9yOiBkZXJlZmVyZW5jaW5nIHBvaW50ZXIgdG8gaW5jb21wbGV0ZSB0eXBlCi91c3Ivc3Jj
L2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVycy9jcGxkLmM6MTAwMDogZXJyb3I6IGRlcmVm
ZXJlbmNpbmcgcG9pbnRlciB0byBpbmNvbXBsZXRlIHR5cGUKL3Vzci9zcmMvYWxzYS9hbHNhLWRy
aXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzoxMDAxOiBlcnJvcjogZGVyZWZlcmVuY2luZyBwb2lu
dGVyIHRvIGluY29tcGxldGUgdHlwZQovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44L2Ry
aXZlcnMvY3BsZC5jOjEwMDI6IGVycm9yOiBkZXJlZmVyZW5jaW5nIHBvaW50ZXIgdG8gaW5jb21w
bGV0ZSB0eXBlCi91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVycy9jcGxkLmM6
IEF0IHRvcCBsZXZlbDoKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2Nw
bGQuYzoxMDA3OiB3YXJuaW5nOiAic3RydWN0IHNuZF9jdGxfZWxlbV92YWx1ZSIgZGVjbGFyZWQg
aW5zaWRlIHBhcmFtZXRlciBsaXN0Ci91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJp
dmVycy9jcGxkLmM6MTAwNzogd2FybmluZzogInN0cnVjdCBzbmRfa2NvbnRyb2wiIGRlY2xhcmVk
IGluc2lkZSBwYXJhbWV0ZXIgbGlzdAovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44L2Ry
aXZlcnMvY3BsZC5jOiBJbiBmdW5jdGlvbiBgc25kX2xkX3ZvbHVtZV9nZXQnOgovdXNyL3NyYy9h
bHNhL2Fsc2EtZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5jOjEwMDk6IGVycm9yOiBkZXJlZmVy
ZW5jaW5nIHBvaW50ZXIgdG8gaW5jb21wbGV0ZSB0eXBlCi91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2
ZXItMS4wLjgvZHJpdmVycy9jcGxkLmM6MTAxMDogZXJyb3I6IGRlcmVmZXJlbmNpbmcgcG9pbnRl
ciB0byBpbmNvbXBsZXRlIHR5cGUKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2
ZXJzL2NwbGQuYzoxMDEzOiBlcnJvcjogZGVyZWZlcmVuY2luZyBwb2ludGVyIHRvIGluY29tcGxl
dGUgdHlwZQovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5jOiBB
dCB0b3AgbGV2ZWw6Ci91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVycy9jcGxk
LmM6MTAxOTogd2FybmluZzogInN0cnVjdCBzbmRfY3RsX2VsZW1fdmFsdWUiIGRlY2xhcmVkIGlu
c2lkZSBwYXJhbWV0ZXIgbGlzdAovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44L2RyaXZl
cnMvY3BsZC5jOjEwMTk6IHdhcm5pbmc6ICJzdHJ1Y3Qgc25kX2tjb250cm9sIiBkZWNsYXJlZCBp
bnNpZGUgcGFyYW1ldGVyIGxpc3QKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2
ZXJzL2NwbGQuYzogSW4gZnVuY3Rpb24gYHNuZF9sZF92b2x1bWVfcHV0JzoKL3Vzci9zcmMvYWxz
YS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzoxMDIxOiBlcnJvcjogZGVyZWZlcmVu
Y2luZyBwb2ludGVyIHRvIGluY29tcGxldGUgdHlwZQovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVy
LTEuMC44L2RyaXZlcnMvY3BsZC5jOjEwMjI6IGVycm9yOiBkZXJlZmVyZW5jaW5nIHBvaW50ZXIg
dG8gaW5jb21wbGV0ZSB0eXBlCi91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVy
cy9jcGxkLmM6MTAyNTogZXJyb3I6IGRlcmVmZXJlbmNpbmcgcG9pbnRlciB0byBpbmNvbXBsZXRl
IHR5cGUKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzogQXQg
dG9wIGxldmVsOgovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5j
OjEwMzc6IGVycm9yOiB2YXJpYWJsZSBgc25kX2xkX3ZvbHVtZScgaGFzIGluaXRpYWxpemVyIGJ1
dCBpbmNvbXBsZXRlIHR5cGUKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJz
L2NwbGQuYzoxMDM4OiBlcnJvcjogdW5rbm93biBmaWVsZCBgaWZhY2UnIHNwZWNpZmllZCBpbiBp
bml0aWFsaXplcgovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5j
OjEwMzg6IHdhcm5pbmc6IGV4Y2VzcyBlbGVtZW50cyBpbiBzdHJ1Y3QgaW5pdGlhbGl6ZXIKL3Vz
ci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzoxMDM4OiB3YXJuaW5n
OiAobmVhciBpbml0aWFsaXphdGlvbiBmb3IgYHNuZF9sZF92b2x1bWUnKQovdXNyL3NyYy9hbHNh
L2Fsc2EtZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5jOjEwMzk6IGVycm9yOiB1bmtub3duIGZp
ZWxkIGBuYW1lJyBzcGVjaWZpZWQgaW4gaW5pdGlhbGl6ZXIKL3Vzci9zcmMvYWxzYS9hbHNhLWRy
aXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzoxMDM5OiB3YXJuaW5nOiBleGNlc3MgZWxlbWVudHMg
aW4gc3RydWN0IGluaXRpYWxpemVyCi91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJp
dmVycy9jcGxkLmM6MTAzOTogd2FybmluZzogKG5lYXIgaW5pdGlhbGl6YXRpb24gZm9yIGBzbmRf
bGRfdm9sdW1lJykKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQu
YzoxMDQwOiBlcnJvcjogdW5rbm93biBmaWVsZCBgaW5kZXgnIHNwZWNpZmllZCBpbiBpbml0aWFs
aXplcgovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5jOjEwNDA6
IHdhcm5pbmc6IGV4Y2VzcyBlbGVtZW50cyBpbiBzdHJ1Y3QgaW5pdGlhbGl6ZXIKL3Vzci9zcmMv
YWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzoxMDQwOiB3YXJuaW5nOiAobmVh
ciBpbml0aWFsaXphdGlvbiBmb3IgYHNuZF9sZF92b2x1bWUnKQovdXNyL3NyYy9hbHNhL2Fsc2Et
ZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5jOjEwNDE6IGVycm9yOiB1bmtub3duIGZpZWxkIGBp
bmZvJyBzcGVjaWZpZWQgaW4gaW5pdGlhbGl6ZXIKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0x
LjAuOC9kcml2ZXJzL2NwbGQuYzoxMDQxOiB3YXJuaW5nOiBleGNlc3MgZWxlbWVudHMgaW4gc3Ry
dWN0IGluaXRpYWxpemVyCi91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVycy9j
cGxkLmM6MTA0MTogd2FybmluZzogKG5lYXIgaW5pdGlhbGl6YXRpb24gZm9yIGBzbmRfbGRfdm9s
dW1lJykKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzoxMDQy
OiBlcnJvcjogdW5rbm93biBmaWVsZCBgZ2V0JyBzcGVjaWZpZWQgaW4gaW5pdGlhbGl6ZXIKL3Vz
ci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzoxMDQyOiB3YXJuaW5n
OiBleGNlc3MgZWxlbWVudHMgaW4gc3RydWN0IGluaXRpYWxpemVyCi91c3Ivc3JjL2Fsc2EvYWxz
YS1kcml2ZXItMS4wLjgvZHJpdmVycy9jcGxkLmM6MTA0Mjogd2FybmluZzogKG5lYXIgaW5pdGlh
bGl6YXRpb24gZm9yIGBzbmRfbGRfdm9sdW1lJykKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0x
LjAuOC9kcml2ZXJzL2NwbGQuYzoxMDQzOiBlcnJvcjogdW5rbm93biBmaWVsZCBgcHV0JyBzcGVj
aWZpZWQgaW4gaW5pdGlhbGl6ZXIKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2
ZXJzL2NwbGQuYzoxMDQzOiB3YXJuaW5nOiBleGNlc3MgZWxlbWVudHMgaW4gc3RydWN0IGluaXRp
YWxpemVyCi91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVycy9jcGxkLmM6MTA0
Mzogd2FybmluZzogKG5lYXIgaW5pdGlhbGl6YXRpb24gZm9yIGBzbmRfbGRfdm9sdW1lJykKL3Vz
ci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzoxMDQ0OiBlcnJvcjog
dW5rbm93biBmaWVsZCBgcHJpdmF0ZV92YWx1ZScgc3BlY2lmaWVkIGluIGluaXRpYWxpemVyCi91
c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVycy9jcGxkLmM6MTA0NTogd2Fybmlu
ZzogZXhjZXNzIGVsZW1lbnRzIGluIHN0cnVjdCBpbml0aWFsaXplcgovdXNyL3NyYy9hbHNhL2Fs
c2EtZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5jOjEwNDU6IHdhcm5pbmc6IChuZWFyIGluaXRp
YWxpemF0aW9uIGZvciBgc25kX2xkX3ZvbHVtZScpCi91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXIt
MS4wLjgvZHJpdmVycy9jcGxkLmM6IEluIGZ1bmN0aW9uIGBzbmRfY2FyZF9sZF9uZXdfbWl4ZXIn
OgovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44L2RyaXZlcnMvY3BsZC5jOjEwNTQ6IGVy
cm9yOiBkZXJlZmVyZW5jaW5nIHBvaW50ZXIgdG8gaW5jb21wbGV0ZSB0eXBlCi91c3Ivc3JjL2Fs
c2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVycy9jcGxkLmM6MTA1Njogd2FybmluZzogcGFzc2lu
ZyBhcmcgMSBvZiBgc25kX2N0bF9uZXcxJyBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUK
L3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzogSW4gZnVuY3Rp
b24gYHNuZF9jYXJkX2NwbGRfcHJvYmUnOgovdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44
L2RyaXZlcnMvY3BsZC5jOjExMDI6IGVycm9yOiBgY3BsZCcgdW5kZWNsYXJlZCAoZmlyc3QgdXNl
IGluIHRoaXMgZnVuY3Rpb24pCi91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVy
cy9jcGxkLmM6MTEwMjogZXJyb3I6IChFYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBv
cnRlZCBvbmx5IG9uY2UKL3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2Nw
bGQuYzoxMTAyOiBlcnJvcjogZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbi4pCi91c3Iv
c3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVycy9jcGxkLmM6IEF0IHRvcCBsZXZlbDoK
L3Vzci9zcmMvYWxzYS9hbHNhLWRyaXZlci0xLjAuOC9kcml2ZXJzL2NwbGQuYzoxMDM3OiBlcnJv
cjogc3RvcmFnZSBzaXplIG9mIGBzbmRfbGRfdm9sdW1lJyBpc24ndCBrbm93bgptYWtlWzRdOiAq
KiogWy91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjgvZHJpdmVycy9jcGxkLm9dIEVycm9y
IDEKbWFrZVszXTogKioqIFsvdXNyL3NyYy9hbHNhL2Fsc2EtZHJpdmVyLTEuMC44L2RyaXZlcnNd
IEVycm9yIDIKbWFrZVsyXTogKioqIFtfbW9kdWxlXy91c3Ivc3JjL2Fsc2EvYWxzYS1kcml2ZXIt
MS4wLjhdIEVycm9yIDIKbWFrZVsxXTogKioqIFttb2R1bGVzXSBFcnJvciAyCm1ha2U6ICoqKiBb
Y29tcGlsZV0gRXJyb3IgMgo=

------_=_NextPart_001_01C6F9EC.2E4EE070
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------_=_NextPart_001_01C6F9EC.2E4EE070
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------_=_NextPart_001_01C6F9EC.2E4EE070--
