From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: Re: Mixer regression with usb soundcard
Date: Tue, 19 Dec 2017 02:50:50 +0900
Message-ID: <CAL6iAaJVwWRpdGMXKTRYBN8gTD9vUS5C7cjN6SBsN1UBMxYcPw@mail.gmail.com>
References: <0f95a1cc-c438-ca4e-cc5f-d311e33a496e@gmail.com>
 <20171218134444.GA18133@kroah.com> <s5hy3m0dtw0.wl-tiwai@suse.de>
 <bd3f1487-d703-77b4-aca3-c6e15f0e18a8@gmail.com>
 <s5ha7ygdoqb.wl-tiwai@suse.de>
 <9dff0299-5621-2670-50b6-ee1851bb40f4@gmail.com>
 <s5htvwoc63f.wl-tiwai@suse.de>
 <CAL6iAaJVVVow45P=+whSnog+THH0CqW7ZdAYmegbd7byqCFUxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="94eb2c0b86aeb55dff0560a0fdd2"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F990267544
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 18:50:52 +0100 (CET)
Received: by mail-io0-f196.google.com with SMTP id o2so10677630ioe.8
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 09:50:52 -0800 (PST)
In-Reply-To: <CAL6iAaJVVVow45P=+whSnog+THH0CqW7ZdAYmegbd7byqCFUxg@mail.gmail.com>
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

--94eb2c0b86aeb55dff0560a0fdd2
Content-Type: text/plain; charset="UTF-8"

Mauro,

Could you please try debug patch(I also attach the patch file)?

And can you share your usb audio dac? Is this same device with yours?
https://hifimediy.com/index.php?route=product/product&product_id=83

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 84b9f9c..6200aa2 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -595,7 +595,7 @@ int snd_usb_mixer_add_control(struct
usb_mixer_elem_list *list,
  while (snd_ctl_find_id(mixer->chip->card, &kctl->id))
  kctl->id.index++;
  if ((err = snd_ctl_add(mixer->chip->card, kctl)) < 0) {
- usb_audio_dbg(mixer->chip, "cannot add control (err = %d)\n",
+ usb_audio_err(mixer->chip, "[DEBUG] cannot add control (err = %d)\n",
        err);
  return err;
  }
@@ -656,10 +656,14 @@ static int get_term_name(struct mixer_build
*state, struct usb_audio_term *iterm
  unsigned char *name, int maxlen, int term_only)
 {
  struct iterm_name_combo *names;
+ int len;

- if (iterm->name)
- return snd_usb_copy_string_desc(state, iterm->name,
+ if (iterm->name) {
+ len = snd_usb_copy_string_desc(state, iterm->name,
  name, maxlen);
+ usb_audio_err(state->chip, "[DEBUG] len:%d, iterm->name:%d\n", len,
iterm->name);
+ return len;
+ }

  /* virtual type - not a real terminal */
  if (iterm->type >> 16) {
@@ -2162,14 +2166,23 @@ static int parse_audio_selector_unit(struct
mixer_build *state, int unitid,

  nameid = uac_selector_unit_iSelector(desc);
  len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
+
+ usb_audio_err(state->chip, "[DEBUG] nameid:%d, len:%d\n", nameid, len);
+
  if (len)
  ;
- else if (nameid)
+ else if (nameid) {
  len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
  sizeof(kctl->id.name));
- else
+ usb_audio_err(state->chip, "[DEBUG] len:%d, copy_string id.name:%s\n",
+ len, (len > 0) ? kctl->id.name : " ");
+ }
+ else {
  len = get_term_name(state, &state->oterm,
      kctl->id.name, sizeof(kctl->id.name), 0);
+ usb_audio_err(state->chip, "[DEBUG] len:%d, get_term_name:%s\n",
+ len, (len > 0) ? kctl->id.name : " ");
+ }

  if (!len) {
  strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
@@ -2182,7 +2195,7 @@ static int parse_audio_selector_unit(struct
mixer_build *state, int unitid,
  append_ctl_name(kctl, " Playback Source");
  }

- usb_audio_dbg(state->chip, "[%d] SU [%s] items = %d\n",
+ usb_audio_err(state->chip, "[%d] SU [%s] items = %d\n",
      cval->head.id, kctl->id.name, desc->bNrInPins);
  return snd_usb_mixer_add_control(&cval->head, kctl);
 }


2017-12-19 2:19 GMT+09:00 Jaejoong Kim <climbbb.kim@gmail.com>:
> 2017-12-19 2:13 GMT+09:00 Takashi Iwai <tiwai@suse.de>:
>> On Mon, 18 Dec 2017 18:05:18 +0100,
>> Mauro Santos wrote:
>>>
>>> On 18-12-2017 15:45, Takashi Iwai wrote:
>>> > On Mon, 18 Dec 2017 16:30:13 +0100,
>>> > Mauro Santos wrote:
>>> >>
>>> >> On 18-12-2017 13:53, Takashi Iwai wrote:
>>> >>> On Mon, 18 Dec 2017 14:44:44 +0100,
>>> >>> Greg KH wrote:
>>> >>>>
>>> >>>> On Sun, Dec 17, 2017 at 06:56:05PM +0000, Mauro Santos wrote:
>>> >>>>> I believe this is the right place to report this problem, but if it
>>> >>>>> isn't please point me in the right direction.
>>> >>>>
>>> >>>> Adding the developer of that patch, and the sound maintainer and
>>> >>>> developers to the thread.
>>> >>>>
>>> >>>>> I have noticed that after the update from kernel 4.14.5 to 4.14.6
>>> >>>>> alsamixer does not show the usual volume controls for my usb soundcard.
>>> >>>>>
>>> >>>>> Reverting 3884d12e17ab770aa0f5d4bc65bfbfd006f417fa ALSA: usb-audio: Add
>>> >>>>> check return value for usb_string() (from linux-stable) makes the
>>> >>>>> controls come back again with kernel 4.14.6.
>>> >>> (snip)
>>> >>>>
>>> >>>> This is odd, Takashi, I thought we fixed up the problem that if the
>>> >>>> string was invalid, the code would continue to go on, it's not a "real"
>>> >>>> error.  Did that not get marked for the stable trees?
>>> >>>
>>> >>> Yes, it was marked as stable, and it's odd that the revert of the
>>> >>> given commit changes the behavior in that way.
>>> >>>
>>> >>> Mauro, could you double-check whether reverting the commit really does
>>> >>> fix it as expected?  If yes, could you put some debug print at the
>>> >>> part the patch touches, and check which unit id gives len=0 from
>>> >>> snd_usb_copy_string_desc()?
>>> >>
>>> >> I'm sure reverting that patch makes things work as expected. I noticed
>>> >> the problem after an update and that is the only thing I revert on top
>>> >> of the kernel provided by the distro (Arch Linux).
>>> >
>>> > Did you revert only one patch, not both patches?
>>> > Just to be sure.
>>>
>>> I have reverted only one patch.
>>>
>>> >> Alsamixer works fine for the built in soundcard in my laptop, but the
>>> >> mixer for the usb soundcard was not working so it's specific to usb and
>>> >> only 2 patches touch the mixer.c file between 4.14.5 and 4.14.6. I've
>>> >> tried reversing both, one at a time, and only reverting this one
>>> >> restored the expected behavior.
>>> >>
>>> >> Regarding adding the debug print I'm going to need guidance. Without
>>> >> reverting anything, would adding at line 2178 of sound/usb/mixer.c the
>>> >> following be enough?
>>> >>
>>> >> printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
>>> >>
>>> >> It would then look like this (minus the line wrapping):
>>> >> len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
>>> >> printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
>>> >> if (len)
>>> >
>>> > Well, at that point, there should be no difference.
>>> > The difference is after that, so what I'd like to see is something
>>> > like:
>>> >
>>> > --- a/sound/usb/mixer.c
>>> > +++ b/sound/usb/mixer.c
>>> > @@ -2175,14 +2175,18 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
>>> >
>>> >     nameid = uac_selector_unit_iSelector(desc);
>>> >     len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
>>> > +   pr_info("XXX id=%d, check_mapped_name=%d\n", id, len);
>>> >     if (len)
>>> >             ;
>>> > -   else if (nameid)
>>> > +   else if (nameid) {
>>> >             len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
>>> >                                      sizeof(kctl->id.name));
>>> > -   else
>>> > +           pr_info("XXX id=%d, copy_string=%d\n", len);
>>> > +   } else {
>>> >             len = get_term_name(state, &state->oterm,
>>> >                                 kctl->id.name, sizeof(kctl->id.name), 0);
>>> > +           pr_info("XXX id=%d, get_term_name=%d\n", len);
>>> > +   }
>>> >
>>> >     if (!len) {
>>> >             strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
>>> >
>>> >
>>> > If you see copy_string=0, it means that your hardware reports a bogus
>>> > entry, and the driver does it correctly.  If ignoring that error
>>> > really restores the old behavior back, it essentially means that it
>>> > worked casually in the past...
>>>
>>> I have applied your patch on top of 4.14.7 without reverting anything
>>> and I was planning to reply only after I had some result but building
>>> failed (without any errors strangely).
>>>
>>> I took a second look at your patch and I have a (maybe silly/naive)
>>> question, don't the second and third pr_info calls need an extra
>>> argument? There are two %d in the string but only one variable (len).
>>
>> Yeah, sure, of course you need them :)
>> I haven't tested the patch, but just to give you an idea.
>> Sorry if you wasted your time due to that.
>
> OK. I will make a debug patch with you last debug code.
>
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -656,10 +656,14 @@ static int get_term_name(struct mixer_build
> *state, struct usb_audio_term *iterm
>                          unsigned char *name, int maxlen, int term_only)
>  {
>         struct iterm_name_combo *names;
> +       int len;
>
> -       if (iterm->name)
> -               return snd_usb_copy_string_desc(state, iterm->name,
> +       if (iterm->name) {
> +               len = snd_usb_copy_string_desc(state, iterm->name,
>                                                 name, maxlen);
> +               if (len)
> +                       return len;
> +       }

This is your potential patch not debug. To verify your potential fix,
I add more debug code in get_term_name().
I am going to bed. It's 2:46AM..

>
> I will come back soon.
>
>>
>>
>> Takashi

--94eb2c0b86aeb55dff0560a0fdd2
Content-Type: text/x-patch; charset="US-ASCII"; name="debug.patch"
Content-Disposition: attachment; filename="debug.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jbchn8710

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9taXhlci5jIGIvc291bmQvdXNiL21peGVyLmMKaW5kZXgg
ODRiOWY5Yy4uNjIwMGFhMiAxMDA2NDQKLS0tIGEvc291bmQvdXNiL21peGVyLmMKKysrIGIvc291
bmQvdXNiL21peGVyLmMKQEAgLTU5NSw3ICs1OTUsNyBAQCBpbnQgc25kX3VzYl9taXhlcl9hZGRf
Y29udHJvbChzdHJ1Y3QgdXNiX21peGVyX2VsZW1fbGlzdCAqbGlzdCwKIAl3aGlsZSAoc25kX2N0
bF9maW5kX2lkKG1peGVyLT5jaGlwLT5jYXJkLCAma2N0bC0+aWQpKQogCQlrY3RsLT5pZC5pbmRl
eCsrOwogCWlmICgoZXJyID0gc25kX2N0bF9hZGQobWl4ZXItPmNoaXAtPmNhcmQsIGtjdGwpKSA8
IDApIHsKLQkJdXNiX2F1ZGlvX2RiZyhtaXhlci0+Y2hpcCwgImNhbm5vdCBhZGQgY29udHJvbCAo
ZXJyID0gJWQpXG4iLAorCQl1c2JfYXVkaW9fZXJyKG1peGVyLT5jaGlwLCAiW0RFQlVHXSBjYW5u
b3QgYWRkIGNvbnRyb2wgKGVyciA9ICVkKVxuIiwKIAkJCSAgICAgIGVycik7CiAJCXJldHVybiBl
cnI7CiAJfQpAQCAtNjU2LDEwICs2NTYsMTQgQEAgc3RhdGljIGludCBnZXRfdGVybV9uYW1lKHN0
cnVjdCBtaXhlcl9idWlsZCAqc3RhdGUsIHN0cnVjdCB1c2JfYXVkaW9fdGVybSAqaXRlcm0KIAkJ
CSB1bnNpZ25lZCBjaGFyICpuYW1lLCBpbnQgbWF4bGVuLCBpbnQgdGVybV9vbmx5KQogewogCXN0
cnVjdCBpdGVybV9uYW1lX2NvbWJvICpuYW1lczsKKwlpbnQgbGVuOwogCi0JaWYgKGl0ZXJtLT5u
YW1lKQotCQlyZXR1cm4gc25kX3VzYl9jb3B5X3N0cmluZ19kZXNjKHN0YXRlLCBpdGVybS0+bmFt
ZSwKKwlpZiAoaXRlcm0tPm5hbWUpIHsKKwkJbGVuID0gc25kX3VzYl9jb3B5X3N0cmluZ19kZXNj
KHN0YXRlLCBpdGVybS0+bmFtZSwKIAkJCQkJCW5hbWUsIG1heGxlbik7CisJCXVzYl9hdWRpb19l
cnIoc3RhdGUtPmNoaXAsICJbREVCVUddIGxlbjolZCwgaXRlcm0tPm5hbWU6JWRcbiIsIGxlbiwg
aXRlcm0tPm5hbWUpOworCQlyZXR1cm4gbGVuOworCX0KIAogCS8qIHZpcnR1YWwgdHlwZSAtIG5v
dCBhIHJlYWwgdGVybWluYWwgKi8KIAlpZiAoaXRlcm0tPnR5cGUgPj4gMTYpIHsKQEAgLTIxNjIs
MTQgKzIxNjYsMjMgQEAgc3RhdGljIGludCBwYXJzZV9hdWRpb19zZWxlY3Rvcl91bml0KHN0cnVj
dCBtaXhlcl9idWlsZCAqc3RhdGUsIGludCB1bml0aWQsCiAKIAluYW1laWQgPSB1YWNfc2VsZWN0
b3JfdW5pdF9pU2VsZWN0b3IoZGVzYyk7CiAJbGVuID0gY2hlY2tfbWFwcGVkX25hbWUobWFwLCBr
Y3RsLT5pZC5uYW1lLCBzaXplb2Yoa2N0bC0+aWQubmFtZSkpOworCisJdXNiX2F1ZGlvX2Vycihz
dGF0ZS0+Y2hpcCwgIltERUJVR10gbmFtZWlkOiVkLCBsZW46JWRcbiIsIG5hbWVpZCwgbGVuKTsJ
CisKIAlpZiAobGVuKQogCQk7Ci0JZWxzZSBpZiAobmFtZWlkKQorCWVsc2UgaWYgKG5hbWVpZCkg
ewogCQlsZW4gPSBzbmRfdXNiX2NvcHlfc3RyaW5nX2Rlc2Moc3RhdGUsIG5hbWVpZCwga2N0bC0+
aWQubmFtZSwKIAkJCQkJIHNpemVvZihrY3RsLT5pZC5uYW1lKSk7Ci0JZWxzZQorCQl1c2JfYXVk
aW9fZXJyKHN0YXRlLT5jaGlwLCAiW0RFQlVHXSBsZW46JWQsIGNvcHlfc3RyaW5nIGlkLm5hbWU6
JXNcbiIsCisJCQkJCWxlbiwgKGxlbiA+IDApID8ga2N0bC0+aWQubmFtZSA6ICIgIik7CisJfQor
CWVsc2UgewogCQlsZW4gPSBnZXRfdGVybV9uYW1lKHN0YXRlLCAmc3RhdGUtPm90ZXJtLAogCQkJ
CSAgICBrY3RsLT5pZC5uYW1lLCBzaXplb2Yoa2N0bC0+aWQubmFtZSksIDApOworCQl1c2JfYXVk
aW9fZXJyKHN0YXRlLT5jaGlwLCAiW0RFQlVHXSBsZW46JWQsIGdldF90ZXJtX25hbWU6JXNcbiIs
CisJCQkJCWxlbiwgKGxlbiA+IDApID8ga2N0bC0+aWQubmFtZSA6ICIgIik7CisJfQogCiAJaWYg
KCFsZW4pIHsKIAkJc3RybGNweShrY3RsLT5pZC5uYW1lLCAiVVNCIiwgc2l6ZW9mKGtjdGwtPmlk
Lm5hbWUpKTsKQEAgLTIxODIsNyArMjE5NSw3IEBAIHN0YXRpYyBpbnQgcGFyc2VfYXVkaW9fc2Vs
ZWN0b3JfdW5pdChzdHJ1Y3QgbWl4ZXJfYnVpbGQgKnN0YXRlLCBpbnQgdW5pdGlkLAogCQkJYXBw
ZW5kX2N0bF9uYW1lKGtjdGwsICIgUGxheWJhY2sgU291cmNlIik7CiAJfQogCi0JdXNiX2F1ZGlv
X2RiZyhzdGF0ZS0+Y2hpcCwgIlslZF0gU1UgWyVzXSBpdGVtcyA9ICVkXG4iLAorCXVzYl9hdWRp
b19lcnIoc3RhdGUtPmNoaXAsICJbJWRdIFNVIFslc10gaXRlbXMgPSAlZFxuIiwKIAkJICAgIGN2
YWwtPmhlYWQuaWQsIGtjdGwtPmlkLm5hbWUsIGRlc2MtPmJOckluUGlucyk7CiAJcmV0dXJuIHNu
ZF91c2JfbWl4ZXJfYWRkX2NvbnRyb2woJmN2YWwtPmhlYWQsIGtjdGwpOwogfQo=
--94eb2c0b86aeb55dff0560a0fdd2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--94eb2c0b86aeb55dff0560a0fdd2--
