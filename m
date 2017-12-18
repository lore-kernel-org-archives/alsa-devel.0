From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: Re: Mixer regression with usb soundcard
Date: Tue, 19 Dec 2017 01:59:38 +0900
Message-ID: <CAL6iAa+eX_3fs2bQp-SquuU6PAOGqeBfjmkYhraz=99CTKUEpg@mail.gmail.com>
References: <0f95a1cc-c438-ca4e-cc5f-d311e33a496e@gmail.com>
 <20171218134444.GA18133@kroah.com> <s5hy3m0dtw0.wl-tiwai@suse.de>
 <bd3f1487-d703-77b4-aca3-c6e15f0e18a8@gmail.com>
 <s5ha7ygdoqb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a1143e6faab01860560a04684"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f67.google.com (mail-it0-f67.google.com
 [209.85.214.67])
 by alsa0.perex.cz (Postfix) with ESMTP id E825226698E
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 17:59:41 +0100 (CET)
Received: by mail-it0-f67.google.com with SMTP id m11so5801873iti.1
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 08:59:41 -0800 (PST)
In-Reply-To: <s5ha7ygdoqb.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mauro Santos <registo.mailling@gmail.com>, alsa-devel@alsa-project.org, USB list <linux-usb@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

--001a1143e6faab01860560a04684
Content-Type: text/plain; charset="UTF-8"

Mauro,
thanks for the report and sorry for the make problem.

Could you try below debug patch? I add more debug code with Takashi's guideline.

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 84b9f9c..0233425 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -595,7 +595,7 @@ int snd_usb_mixer_add_control(struct
usb_mixer_elem_list *list,
        while (snd_ctl_find_id(mixer->chip->card, &kctl->id))
                kctl->id.index++;
        if ((err = snd_ctl_add(mixer->chip->card, kctl)) < 0) {
-               usb_audio_dbg(mixer->chip, "cannot add control (err = %d)\n",
+               usb_audio_err(mixer->chip, "[DEBUG] cannot add control
(err = %d)\n",
                              err);
                return err;
        }
@@ -2162,14 +2162,23 @@ static int parse_audio_selector_unit(struct
mixer_build *state, int unitid,

        nameid = uac_selector_unit_iSelector(desc);
        len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
+
+       usb_audio_err(state->chip, "[DEBUG] nameid:%d, len:%d\n", nameid, len);
+
        if (len)
                ;
-       else if (nameid)
+       else if (nameid) {
                len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
                                         sizeof(kctl->id.name));
-       else
+               usb_audio_err(state->chip, "[DEBUG] len:%d,
copy_string id.name:%s\n",
+                                       len, (len > 0) ? kctl->id.name : " ");
+       }
+       else {
                len = get_term_name(state, &state->oterm,
                                    kctl->id.name, sizeof(kctl->id.name), 0);
+               usb_audio_err(state->chip, "[DEBUG] len:%d, get_term_name:%s\n",
+                                       len, (len > 0) ? kctl->id.name : " ");
+       }

        if (!len) {
                strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
@@ -2182,7 +2191,7 @@ static int parse_audio_selector_unit(struct
mixer_build *state, int unitid,
                        append_ctl_name(kctl, " Playback Source");
        }

-       usb_audio_dbg(state->chip, "[%d] SU [%s] items = %d\n",
+       usb_audio_err(state->chip, "[%d] SU [%s] items = %d\n",
                    cval->head.id, kctl->id.name, desc->bNrInPins);
        return snd_usb_mixer_add_control(&cval->head, kctl);
 }


2017-12-19 0:45 GMT+09:00 Takashi Iwai <tiwai@suse.de>:
> On Mon, 18 Dec 2017 16:30:13 +0100,
> Mauro Santos wrote:
>>
>> On 18-12-2017 13:53, Takashi Iwai wrote:
>> > On Mon, 18 Dec 2017 14:44:44 +0100,
>> > Greg KH wrote:
>> >>
>> >> On Sun, Dec 17, 2017 at 06:56:05PM +0000, Mauro Santos wrote:
>> >>> I believe this is the right place to report this problem, but if it
>> >>> isn't please point me in the right direction.
>> >>
>> >> Adding the developer of that patch, and the sound maintainer and
>> >> developers to the thread.
>> >>
>> >>> I have noticed that after the update from kernel 4.14.5 to 4.14.6
>> >>> alsamixer does not show the usual volume controls for my usb soundcard.
>> >>>
>> >>> Reverting 3884d12e17ab770aa0f5d4bc65bfbfd006f417fa ALSA: usb-audio: Add
>> >>> check return value for usb_string() (from linux-stable) makes the
>> >>> controls come back again with kernel 4.14.6.
>> > (snip)
>> >>
>> >> This is odd, Takashi, I thought we fixed up the problem that if the
>> >> string was invalid, the code would continue to go on, it's not a "real"
>> >> error.  Did that not get marked for the stable trees?
>> >
>> > Yes, it was marked as stable, and it's odd that the revert of the
>> > given commit changes the behavior in that way.
>> >
>> > Mauro, could you double-check whether reverting the commit really does
>> > fix it as expected?  If yes, could you put some debug print at the
>> > part the patch touches, and check which unit id gives len=0 from
>> > snd_usb_copy_string_desc()?
>>
>> I'm sure reverting that patch makes things work as expected. I noticed
>> the problem after an update and that is the only thing I revert on top
>> of the kernel provided by the distro (Arch Linux).
>
> Did you revert only one patch, not both patches?
> Just to be sure.
>
>> Alsamixer works fine for the built in soundcard in my laptop, but the
>> mixer for the usb soundcard was not working so it's specific to usb and
>> only 2 patches touch the mixer.c file between 4.14.5 and 4.14.6. I've
>> tried reversing both, one at a time, and only reverting this one
>> restored the expected behavior.
>>
>> Regarding adding the debug print I'm going to need guidance. Without
>> reverting anything, would adding at line 2178 of sound/usb/mixer.c the
>> following be enough?
>>
>> printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
>>
>> It would then look like this (minus the line wrapping):
>> len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
>> printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
>> if (len)
>
> Well, at that point, there should be no difference.
> The difference is after that, so what I'd like to see is something
> like:
>
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -2175,14 +2175,18 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
>
>         nameid = uac_selector_unit_iSelector(desc);
>         len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
> +       pr_info("XXX id=%d, check_mapped_name=%d\n", id, len);
>         if (len)
>                 ;
> -       else if (nameid)
> +       else if (nameid) {
>                 len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
>                                          sizeof(kctl->id.name));
> -       else
> +               pr_info("XXX id=%d, copy_string=%d\n", len);
> +       } else {
>                 len = get_term_name(state, &state->oterm,
>                                     kctl->id.name, sizeof(kctl->id.name), 0);
> +               pr_info("XXX id=%d, get_term_name=%d\n", len);
> +       }
>
>         if (!len) {
>                 strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
>
>
> If you see copy_string=0, it means that your hardware reports a bogus
> entry, and the driver does it correctly.  If ignoring that error
> really restores the old behavior back, it essentially means that it
> worked casually in the past...

AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                11
        bNrInPins               2
        baSource( 0)           14
        baSource( 1)            5
        iSelector               0
        ^^^^^^^^^

>From the lsusb.txt, iSelector is '0' which means
uac_selector_unit_iSelector() return zero I think.

Thanks, jaejoong

>
>
> thanks,
>
> Takashi

--001a1143e6faab01860560a04684
Content-Type: text/x-patch; charset="US-ASCII"; name="usb_alsa_debug.patch"
Content-Disposition: attachment; filename="usb_alsa_debug.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jbcfn0tk0

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9taXhlci5jIGIvc291bmQvdXNiL21peGVyLmMKaW5kZXgg
ODRiOWY5Yy4uMDIzMzQyNSAxMDA2NDQKLS0tIGEvc291bmQvdXNiL21peGVyLmMKKysrIGIvc291
bmQvdXNiL21peGVyLmMKQEAgLTU5NSw3ICs1OTUsNyBAQCBpbnQgc25kX3VzYl9taXhlcl9hZGRf
Y29udHJvbChzdHJ1Y3QgdXNiX21peGVyX2VsZW1fbGlzdCAqbGlzdCwKIAl3aGlsZSAoc25kX2N0
bF9maW5kX2lkKG1peGVyLT5jaGlwLT5jYXJkLCAma2N0bC0+aWQpKQogCQlrY3RsLT5pZC5pbmRl
eCsrOwogCWlmICgoZXJyID0gc25kX2N0bF9hZGQobWl4ZXItPmNoaXAtPmNhcmQsIGtjdGwpKSA8
IDApIHsKLQkJdXNiX2F1ZGlvX2RiZyhtaXhlci0+Y2hpcCwgImNhbm5vdCBhZGQgY29udHJvbCAo
ZXJyID0gJWQpXG4iLAorCQl1c2JfYXVkaW9fZXJyKG1peGVyLT5jaGlwLCAiW0RFQlVHXSBjYW5u
b3QgYWRkIGNvbnRyb2wgKGVyciA9ICVkKVxuIiwKIAkJCSAgICAgIGVycik7CiAJCXJldHVybiBl
cnI7CiAJfQpAQCAtMjE2MiwxNCArMjE2MiwyMyBAQCBzdGF0aWMgaW50IHBhcnNlX2F1ZGlvX3Nl
bGVjdG9yX3VuaXQoc3RydWN0IG1peGVyX2J1aWxkICpzdGF0ZSwgaW50IHVuaXRpZCwKIAogCW5h
bWVpZCA9IHVhY19zZWxlY3Rvcl91bml0X2lTZWxlY3RvcihkZXNjKTsKIAlsZW4gPSBjaGVja19t
YXBwZWRfbmFtZShtYXAsIGtjdGwtPmlkLm5hbWUsIHNpemVvZihrY3RsLT5pZC5uYW1lKSk7CisK
Kwl1c2JfYXVkaW9fZXJyKHN0YXRlLT5jaGlwLCAiW0RFQlVHXSBuYW1laWQ6JWQsIGxlbjolZFxu
IiwgbmFtZWlkLCBsZW4pOwkKKwogCWlmIChsZW4pCiAJCTsKLQllbHNlIGlmIChuYW1laWQpCisJ
ZWxzZSBpZiAobmFtZWlkKSB7CiAJCWxlbiA9IHNuZF91c2JfY29weV9zdHJpbmdfZGVzYyhzdGF0
ZSwgbmFtZWlkLCBrY3RsLT5pZC5uYW1lLAogCQkJCQkgc2l6ZW9mKGtjdGwtPmlkLm5hbWUpKTsK
LQllbHNlCisJCXVzYl9hdWRpb19lcnIoc3RhdGUtPmNoaXAsICJbREVCVUddIGxlbjolZCwgY29w
eV9zdHJpbmcgaWQubmFtZTolc1xuIiwKKwkJCQkJbGVuLCAobGVuID4gMCkgPyBrY3RsLT5pZC5u
YW1lIDogIiAiKTsKKwl9CisJZWxzZSB7CiAJCWxlbiA9IGdldF90ZXJtX25hbWUoc3RhdGUsICZz
dGF0ZS0+b3Rlcm0sCiAJCQkJICAgIGtjdGwtPmlkLm5hbWUsIHNpemVvZihrY3RsLT5pZC5uYW1l
KSwgMCk7CisJCXVzYl9hdWRpb19lcnIoc3RhdGUtPmNoaXAsICJbREVCVUddIGxlbjolZCwgZ2V0
X3Rlcm1fbmFtZTolc1xuIiwKKwkJCQkJbGVuLCAobGVuID4gMCkgPyBrY3RsLT5pZC5uYW1lIDog
IiAiKTsKKwl9CiAKIAlpZiAoIWxlbikgewogCQlzdHJsY3B5KGtjdGwtPmlkLm5hbWUsICJVU0Ii
LCBzaXplb2Yoa2N0bC0+aWQubmFtZSkpOwpAQCAtMjE4Miw3ICsyMTkxLDcgQEAgc3RhdGljIGlu
dCBwYXJzZV9hdWRpb19zZWxlY3Rvcl91bml0KHN0cnVjdCBtaXhlcl9idWlsZCAqc3RhdGUsIGlu
dCB1bml0aWQsCiAJCQlhcHBlbmRfY3RsX25hbWUoa2N0bCwgIiBQbGF5YmFjayBTb3VyY2UiKTsK
IAl9CiAKLQl1c2JfYXVkaW9fZGJnKHN0YXRlLT5jaGlwLCAiWyVkXSBTVSBbJXNdIGl0ZW1zID0g
JWRcbiIsCisJdXNiX2F1ZGlvX2VycihzdGF0ZS0+Y2hpcCwgIlslZF0gU1UgWyVzXSBpdGVtcyA9
ICVkXG4iLAogCQkgICAgY3ZhbC0+aGVhZC5pZCwga2N0bC0+aWQubmFtZSwgZGVzYy0+Yk5ySW5Q
aW5zKTsKIAlyZXR1cm4gc25kX3VzYl9taXhlcl9hZGRfY29udHJvbCgmY3ZhbC0+aGVhZCwga2N0
bCk7CiB9Cg==
--001a1143e6faab01860560a04684
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a1143e6faab01860560a04684--
