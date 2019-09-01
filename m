From: Hui Peng <benquike@gmail.com>
Subject: Re: [PATCH 2/2] Fix a stack buffer overflow bug in check_input_term
Date: Sun, 1 Sep 2019 15:47:31 -0400
Message-ID: <d80f1fba-8bf5-58e2-1801-5ac2308b5d4e@gmail.com>
References: <20190830214730.27842-1-benquike@gmail.com>
 <20190901130028.GB23334@eldamar.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------5C362557DFF1DBD4FF087E3A"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901130028.GB23334@eldamar.local>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: carnil@debian.org
Cc: stable@vger.kernel.org, mathias.payer@nebelwelt.net, perex@perex.cz, tiwai@suse.com, gregkh@linuxfoundation.org, wang6495@umn.edu, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------5C362557DFF1DBD4FF087E3A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


On 9/1/19 9:00 AM, Salvatore Bonaccorso wrote:
> Hi Hui,
>
> On Fri, Aug 30, 2019 at 05:47:29PM -0400, Hui Peng wrote:
>> `check_input_term` recursively calls itself with input from
>> device side (e.g., uac_input_terminal_descriptor.bCSourceID)
>> as argument (id). In `check_input_term`, if `check_input_term`
>> is called with the same `id` argument as the caller, it triggers
>> endless recursive call, resulting kernel space stack overflow.
>>
>> This patch fixes the bug by adding a bitmap to `struct mixer_build`
>> to keep track of the checked ids and stop the execution if some id
>> has been checked (similar to how parse_audio_unit handles unitid
>> argument).
>>
>> CVE: CVE-2018-15118
> Similar to the previous one, this should be CVE-2019-15118 as far I
> can tell.

Same here: CVE id updated.

Can you apply it to  v4.4.190 and v4.14.141?

Thanks.

>
> Regards,
> Salvatore

--------------5C362557DFF1DBD4FF087E3A
Content-Type: text/x-patch;
 name="0002-Fix-a-stack-buffer-overflow-bug-in-check_input_term.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-Fix-a-stack-buffer-overflow-bug-in-check_input_term.pat";
 filename*1="ch"

>From f5e478c4807b16f49c00316fb80485562b84340a Mon Sep 17 00:00:00 2001
From: Hui Peng <benquike@gmail.com>
Date: Fri, 30 Aug 2019 16:20:41 -0400
Subject: [PATCH 2/2] Fix a stack buffer overflow bug in check_input_term

`check_input_term` recursively calls itself with input from
device side (e.g., uac_input_terminal_descriptor.bCSourceID)
as argument (id). In `check_input_term`, if `check_input_term`
is called with the same `id` argument as the caller, it triggers
endless recursive call, resulting kernel space stack overflow.

This patch fixes the bug by adding a bitmap to `struct mixer_build`
to keep track of the checked ids and stop the execution if some id
has been checked (similar to how parse_audio_unit handles unitid
argument).

CVE: CVE-2019-15118

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 sound/usb/mixer.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 10ddec76f906..e24572fd6e30 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -81,6 +81,7 @@ struct mixer_build {
 	unsigned char *buffer;
 	unsigned int buflen;
 	DECLARE_BITMAP(unitbitmap, MAX_ID_ELEMS);
+	DECLARE_BITMAP(termbitmap, MAX_ID_ELEMS);
 	struct usb_audio_term oterm;
 	const struct usbmix_name_map *map;
 	const struct usbmix_selector_map *selector_map;
@@ -709,15 +710,24 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
  * parse the source unit recursively until it reaches to a terminal
  * or a branched unit.
  */
-static int check_input_term(struct mixer_build *state, int id,
+static int __check_input_term(struct mixer_build *state, int id,
 			    struct usb_audio_term *term)
 {
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
 		switch (hdr[2]) {
 		case UAC_INPUT_TERMINAL:
@@ -732,7 +742,7 @@ static int check_input_term(struct mixer_build *state, int id,
 
 				/* call recursively to verify that the
 				 * referenced clock entity is valid */
-				err = check_input_term(state, d->bCSourceID, term);
+				err = __check_input_term(state, d->bCSourceID, term);
 				if (err < 0)
 					return err;
 
@@ -764,7 +774,7 @@ static int check_input_term(struct mixer_build *state, int id,
 		case UAC2_CLOCK_SELECTOR: {
 			struct uac_selector_unit_descriptor *d = p1;
 			/* call recursively to retrieve the channel info */
-			err = check_input_term(state, d->baSourceID[0], term);
+			err = __check_input_term(state, d->baSourceID[0], term);
 			if (err < 0)
 				return err;
 			term->type = d->bDescriptorSubtype << 16; /* virtual type */
@@ -811,6 +821,15 @@ static int check_input_term(struct mixer_build *state, int id,
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
2.17.1


--------------5C362557DFF1DBD4FF087E3A--
