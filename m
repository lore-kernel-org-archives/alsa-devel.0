From: Hui Peng <benquike@gmail.com>
Subject: Re: [PATCH] Fix a stack buffer overflow bug
	check_input_term
Date: Thu, 15 Aug 2019 14:11:50 -0400
Message-ID: <c6b11a34-3bd9-f1d7-cd27-4ddcd210a7cc@gmail.com>
References: <20190815043554.16623-1-benquike@gmail.com>
 <s5htvaj9cre.wl-tiwai@suse.de> <s5hk1beapab.wl-tiwai@suse.de>
 <CAKpmkkWCaLOctG44fD=arD-=oogRVCSxe5rz2UNUAms5q=2pYw@mail.gmail.com>
 <s5h7e7e9vn0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------93B7766F64C12B7D19BE0D7E"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBA28F8011F
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 20:11:53 +0200 (CEST)
Received: by mail-io1-xd41.google.com with SMTP id j6so964540ioa.5
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 11:11:53 -0700 (PDT)
In-Reply-To: <s5h7e7e9vn0.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mathias Payer <mathias.payer@nebelwelt.net>, security@kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------93B7766F64C12B7D19BE0D7E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi, Takashi:

The new patch is confirmed (I made it to return -EINVAL if a endless
recursive call is detected).
Can you have a look.

Thanks.

On 8/15/19 1:38 PM, Takashi Iwai wrote:
> On Thu, 15 Aug 2019 19:19:10 +0200,
> Hui Peng wrote:
>> Hi, Takashi:
>>
>> One point I want to be clear: if an endless recursive loop is
detected, should
>> we return 0, or a negative error code? 
> An error might be more appropriate, but it's no big deal, as you'll
> likely hit other errors sooner or later at parsing further :)
>
>
> thanks,
>
> Takashi
>
>> On Thu, Aug 15, 2019 at 2:58 AM Takashi Iwai wrote:
>>
>> On Thu, 15 Aug 2019 08:13:57 +0200,
>> Takashi Iwai wrote:
>> >
>> > On Thu, 15 Aug 2019 06:35:49 +0200,
>> > Hui Peng wrote:
>> > >
>> > > `check_input_term` recursively calls itself with input
>> > > from device side (e.g., uac_input_terminal_descriptor.bCSourceID)
>> > > as argument (id). In `check_input_term`, if `check_input_term`
>> > > is called with the same `id` argument as the caller, it triggers
>> > > endless recursive call, resulting kernel space stack overflow.
>> > >
>> > > This patch fixes the bug by adding a bitmap to `struct mixer_build`
>> > > to keep track of the checked ids by `check_input_term` and stop
>> > > the execution if some id has been checked (similar to how
>> > > parse_audio_unit handles unitid argument).
>> > >
>> > > Reported-by: Hui Peng
>> > > Reported-by: Mathias Payer
>> > > Signed-off-by: Hui Peng
>> >
>> > The fix looks almost good, but we need to be careful about the
>> > bitmap check.  In theory, it's possible that multiple nodes point to
>> > the same input terminal, and your patch would break that scenario.
>> > For fixing that, we need to zero-clear the termbitmap at each first
>> > invocation of check_input_term(), something like below.
>> >
>> > Could you check whether this works?
>>
>> Thinking of this further, there is another possible infinite loop.
>> Namely, when the feature unit in the input terminal chain points to
>> itself as the source, it'll loop endlessly without the stack
>> overflow.
>>
>> So the check of the termbitmap should be inside the loop.
>> The revised patch is below.
>>
>> thanks,
>>
>> Takashi
>>
>> -- 8< --
>> From: Hui Peng
>> Subject: [PATCH] ALSA: usb-audio: Fix a stack buffer overflow bug
>>  check_input_term
>>
>> `check_input_term` recursively calls itself with input
>> from device side (e.g., uac_input_terminal_descriptor.bCSourceID)
>> as argument (id). In `check_input_term`, if `check_input_term`
>> is called with the same `id` argument as the caller, it triggers
>> endless recursive call, resulting kernel space stack overflow.
>>
>> This patch fixes the bug by adding a bitmap to `struct mixer_build`
>> to keep track of the checked ids by `check_input_term` and stop
>> the execution if some id has been checked (similar to how
>> parse_audio_unit handles unitid argument).
>>
>> [ The termbitmap needs to be cleared at each first check of the input
>>   terminal, so the function got split now.  Also, for catching another
>>   endless loop in the input terminal chain -- where the feature unit
>>   points to itself as its source -- the termbitmap check is moved
>>   inside the parser loop. -- tiwai ]
>>
>> Reported-by: Hui Peng
>> Reported-by: Mathias Payer
>> Signed-off-by: Hui Peng
>> Cc:
>> Signed-off-by: Takashi Iwai
>> ---
>>  sound/usb/mixer.c | 36 ++++++++++++++++++++++++++----------
>>  1 file changed, 26 insertions(+), 10 deletions(-)
>>
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index ea487378be17..aa8b046aa91f 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -68,6 +68,7 @@ struct mixer_build {
>>         unsigned char *buffer;
>>         unsigned int buflen;
>>         DECLARE_BITMAP(unitbitmap, MAX_ID_ELEMS);
>> +       DECLARE_BITMAP(termbitmap, MAX_ID_ELEMS);
>>         struct usb_audio_term oterm;
>>         const struct usbmix_name_map *map;
>>         const struct usbmix_selector_map *selector_map;
>> @@ -775,16 +776,23 @@ static int uac_mixer_unit_get_channels(struct
>> mixer_build *state,
>>   * parse the source unit recursively until it reaches to a terminal
>>   * or a branched unit.
>>   */
>> -static int check_input_term(struct mixer_build *state, int id,
>> -                           struct usb_audio_term *term)
>> +static int __check_input_term(struct mixer_build *state, int id,
>> +                             struct usb_audio_term *term)
>>  {
>>         int protocol = state->mixer->protocol;
>>         int err;
>>         void *p1;
>> +       unsigned char *hdr;
>>
>> -       memset(term, 0, sizeof(*term));
>> -       while ((p1 = find_audio_control_unit(state, id)) != NULL) {
>> -               unsigned char *hdr = p1;
>> +       for (;;) {
>> +               /* a loop in the terminal chain? */
>> +               if (test_and_set_bit(id, state->termbitmap))
>> +                       break;
>> +
>> +               p1 = find_audio_control_unit(state, id);
>> +               if (!p1)
>> +                       break;
>> +               hdr = p1;
>>                 term->id = id;
>>
>>                 if (protocol == UAC_VERSION_1 || protocol ==
>> UAC_VERSION_2) {
>> @@ -802,7 +810,7 @@ static int check_input_term(struct mixer_build
*state,
>> int id,
>>
>>                                         /* call recursively to verify
that
>> the
>>                                          * referenced clock entity is
>> valid */
>> -                                       err = check_input_term(state, d->
>> bCSourceID, term);
>> +                                       err = __check_input_term(state,
>> d->bCSourceID, term);
>>                                         if (err < 0)
>>                                                 return err;
>>
>> @@ -836,7 +844,7 @@ static int check_input_term(struct mixer_build
*state,
>> int id,
>>                         case UAC2_CLOCK_SELECTOR: {
>>                                 struct uac_selector_unit_descriptor *d =
>> p1;
>>                                 /* call recursively to retrieve the
>> channel info */
>> -                               err = check_input_term(state, d->
>> baSourceID[0], term);
>> +                               err = __check_input_term(state, d->
>> baSourceID[0], term);
>>                                 if (err < 0)
>>                                         return err;
>>                                 term->type = UAC3_SELECTOR_UNIT << 16; /*
>> virtual type */
>> @@ -899,7 +907,7 @@ static int check_input_term(struct mixer_build
*state,
>> int id,
>>
>>                                 /* call recursively to verify that the
>>                                  * referenced clock entity is valid */
>> -                               err = check_input_term(state, d->
>> bCSourceID, term);
>> +                               err = __check_input_term(state, d->
>> bCSourceID, term);
>>                                 if (err < 0)
>>                                         return err;
>>
>> @@ -950,7 +958,7 @@ static int check_input_term(struct mixer_build
*state,
>> int id,
>>                         case UAC3_CLOCK_SELECTOR: {
>>                                 struct uac_selector_unit_descriptor *d =
>> p1;
>>                                 /* call recursively to retrieve the
>> channel info */
>> -                               err = check_input_term(state, d->
>> baSourceID[0], term);
>> +                               err = __check_input_term(state, d->
>> baSourceID[0], term);
>>                                 if (err < 0)
>>                                         return err;
>>                                 term->type = UAC3_SELECTOR_UNIT << 16; /*
>> virtual type */
>> @@ -966,7 +974,7 @@ static int check_input_term(struct mixer_build
*state,
>> int id,
>>                                         return -EINVAL;
>>
>>                                 /* call recursively to retrieve the
>> channel info */
>> -                               err = check_input_term(state, d->
>> baSourceID[0], term);
>> +                               err = __check_input_term(state, d->
>> baSourceID[0], term);
>>                                 if (err < 0)
>>                                         return err;
>>
>> @@ -984,6 +992,14 @@ static int check_input_term(struct mixer_build
>> *state, int id,
>>         return -ENODEV;
>>  }
>>
>> +static int check_input_term(struct mixer_build *state, int id,
>> +                           struct usb_audio_term *term)
>> +{
>> +       memset(term, 0, sizeof(*term));
>> +       memset(state->termbitmap, 0, sizeof(state->termbitmap));
>> +       return __check_input_term(state, id, term);
>> +}
>> +
>>  /*
>>   * Feature Unit
>>   */
>> --
>> 2.16.4
>>
>>
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE1BqveDE4xg/g0AwHIp/nqknaPR4FAl1VoGYACgkQIp/nqkna
PR7begf/VLHveyoRopqc2MMhJ7aSH9837dNvss2JV/QVvUrdRvpKDpLNLx9EkxSu
U8FXWTl7HImaDBszTwtOJG8Peh/6L8G3ouAtiFIMhq9AsLqMOKS2p3wIvkJwGiCM
hjSZ3U7A8jaIjdUnUz2bVMvLVLfZH7dI8kIUuKtqh7qtBBnRL6w2RhfO1GdMnxvU
etczHfl4anKuQbfMZpI9Xv1ruFkYewUQOBhK4Kp/De00GqqtaINm73WYVqY3gf6I
Txk8zrLBsgFk3wJI6qi1NeITiZ4z8kd7wJL84rj8PraqtFpmkn7p7QfVzDSLibvP
V2HZfnaVwXrAf/FZrxYjpqfoZH44JA==
=MKbq
-----END PGP SIGNATURE-----

--------------93B7766F64C12B7D19BE0D7E
Content-Type: text/x-patch;
 name="0001-Fix-a-stack-buffer-overflow-bug-in-check_input_term.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Fix-a-stack-buffer-overflow-bug-in-check_input_term.pat";
 filename*1="ch"

>From c42bc88ee150e543de26665b05c8c99866a39386 Mon Sep 17 00:00:00 2001
From: Hui Peng <benquike@gmail.com>
Date: Thu, 15 Aug 2019 00:31:34 -0400
Subject: [PATCH] Fix a stack buffer overflow bug in check_input_term

`check_input_term` recursively calls itself with input from
device side (e.g., uac_input_terminal_descriptor.bCSourceID)
as argument (id). In `check_input_term`, if `check_input_term`
is called with the same `id` argument as the caller, it triggers
endless recursive call, resulting kernel space stack overflow.

This patch fixes the bug by adding a bitmap to `struct mixer_build`
to keep track of the checked ids and stop the execution if some id
has been checked (similar to how parse_audio_unit handles unitid
argument).

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 sound/usb/mixer.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ea487378be17..b5927c3d5bc0 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -68,6 +68,7 @@ struct mixer_build {
 	unsigned char *buffer;
 	unsigned int buflen;
 	DECLARE_BITMAP(unitbitmap, MAX_ID_ELEMS);
+	DECLARE_BITMAP(termbitmap, MAX_ID_ELEMS);
 	struct usb_audio_term oterm;
 	const struct usbmix_name_map *map;
 	const struct usbmix_selector_map *selector_map;
@@ -775,16 +776,25 @@ static int uac_mixer_unit_get_channels(struct mixer_build *state,
  * parse the source unit recursively until it reaches to a terminal
  * or a branched unit.
  */
-static int check_input_term(struct mixer_build *state, int id,
+static int __check_input_term(struct mixer_build *state, int id,
 			    struct usb_audio_term *term)
 {
 	int protocol = state->mixer->protocol;
 	int err;
 	void *p1;
+	unsigned char *hdr;
 
 	memset(term, 0, sizeof(*term));
-	while ((p1 = find_audio_control_unit(state, id)) != NULL) {
-		unsigned char *hdr = p1;
+	for (;;) {
+		/* a loop in the terminal chain? */
+		if (test_and_set_bit(id, state->termbitmap))
+			return -EINVAL;
+
+		p1 = find_audio_control_unit(state, id);
+		if (!p1)
+			break;
+
+		hdr = p1;
 		term->id = id;
 
 		if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
@@ -802,7 +812,7 @@ static int check_input_term(struct mixer_build *state, int id,
 
 					/* call recursively to verify that the
 					 * referenced clock entity is valid */
-					err = check_input_term(state, d->bCSourceID, term);
+					err = __check_input_term(state, d->bCSourceID, term);
 					if (err < 0)
 						return err;
 
@@ -836,7 +846,7 @@ static int check_input_term(struct mixer_build *state, int id,
 			case UAC2_CLOCK_SELECTOR: {
 				struct uac_selector_unit_descriptor *d = p1;
 				/* call recursively to retrieve the channel info */
-				err = check_input_term(state, d->baSourceID[0], term);
+				err = __check_input_term(state, d->baSourceID[0], term);
 				if (err < 0)
 					return err;
 				term->type = UAC3_SELECTOR_UNIT << 16; /* virtual type */
@@ -899,7 +909,7 @@ static int check_input_term(struct mixer_build *state, int id,
 
 				/* call recursively to verify that the
 				 * referenced clock entity is valid */
-				err = check_input_term(state, d->bCSourceID, term);
+				err = __check_input_term(state, d->bCSourceID, term);
 				if (err < 0)
 					return err;
 
@@ -950,7 +960,7 @@ static int check_input_term(struct mixer_build *state, int id,
 			case UAC3_CLOCK_SELECTOR: {
 				struct uac_selector_unit_descriptor *d = p1;
 				/* call recursively to retrieve the channel info */
-				err = check_input_term(state, d->baSourceID[0], term);
+				err = __check_input_term(state, d->baSourceID[0], term);
 				if (err < 0)
 					return err;
 				term->type = UAC3_SELECTOR_UNIT << 16; /* virtual type */
@@ -966,7 +976,7 @@ static int check_input_term(struct mixer_build *state, int id,
 					return -EINVAL;
 
 				/* call recursively to retrieve the channel info */
-				err = check_input_term(state, d->baSourceID[0], term);
+				err = __check_input_term(state, d->baSourceID[0], term);
 				if (err < 0)
 					return err;
 
@@ -984,6 +994,15 @@ static int check_input_term(struct mixer_build *state, int id,
 	return -ENODEV;
 }
 
+
+static int check_input_term(struct mixer_build *state, int id,
+			    struct usb_audio_term *term)
+{
+	memset(term, 0, sizeof(*term));
+	memset(state->termbitmap, 0, sizeof(state->termbitmap));
+	return __check_input_term(state, id, term);
+}
+
 /*
  * Feature Unit
  */
-- 
2.22.1


--------------93B7766F64C12B7D19BE0D7E
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------93B7766F64C12B7D19BE0D7E--
