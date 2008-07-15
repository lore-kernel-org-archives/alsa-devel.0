From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] ALSA: re-order AC97 codec ID table.
Date: Tue, 15 Jul 2008 16:17:32 +0200
Message-ID: <487CB17C.4080100@keyaccess.nl>
References: <487BFC2B.8010107@keyaccess.nl> <s5hskubuw5t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000006000004070200060601"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B671243D1
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 16:15:41 +0200 (CEST)
In-Reply-To: <s5hskubuw5t.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000006000004070200060601
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 15-07-08 15:14, Takashi Iwai wrote:

> At Tue, 15 Jul 2008 03:23:55 +0200,
> Rene Herman wrote:
>> Hi Takashi.
>>
>> Feel free to drop if considered pointless churn but keeping it ordered 
>> makes checking easier.
> 
> The idea is fine, but this breaks the current code...

Ah crap, sorry, completely failed to notice. Updated version attached, 
also with the other trivial (whitespace and 'c' instead of 'C') changes 
left out.

Perhaps to avoid another person helpfully screwing this up, it could be 
somewhat useful to order the table down instead of up? In that case, the 
order is just by ID without reference to the mask. If you feel that's 
actually worth it, I'll go and shuffle the entire table around... :)

Rene.

--------------000006000004070200060601
Content-Type: text/plain;
 name="0001-ALSA-re-order-AC97-codec-ID-table.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-ALSA-re-order-AC97-codec-ID-table.patch"

>From be4db30e1406c3c4e82c124e04bc9bea19e64322 Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Tue, 15 Jul 2008 03:00:21 +0200
Subject: [PATCH] ALSA: re-order AC97 codec ID table.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/pci/ac97/ac97_codec.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 8c49a00..f6a7d72 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -67,8 +67,8 @@ struct ac97_codec_id {
 };
 
 static const struct ac97_codec_id snd_ac97_codec_id_vendors[] = {
-{ 0x414b4d00, 0xffffff00, "Asahi Kasei",	NULL,	NULL },
 { 0x41445300, 0xffffff00, "Analog Devices",	NULL,	NULL },
+{ 0x414b4d00, 0xffffff00, "Asahi Kasei",	NULL,	NULL },
 { 0x414c4300, 0xffffff00, "Realtek",		NULL,	NULL },
 { 0x414c4700, 0xffffff00, "Realtek",		NULL,	NULL },
 { 0x434d4900, 0xffffff00, "C-Media Electronics", NULL,	NULL },
@@ -94,11 +94,6 @@ static const struct ac97_codec_id snd_ac97_codec_id_vendors[] = {
 };
 
 static const struct ac97_codec_id snd_ac97_codec_ids[] = {
-{ 0x414b4d00, 0xffffffff, "AK4540",		NULL,		NULL },
-{ 0x414b4d01, 0xffffffff, "AK4542",		NULL,		NULL },
-{ 0x414b4d02, 0xffffffff, "AK4543",		NULL,		NULL },
-{ 0x414b4d06, 0xffffffff, "AK4544A",		NULL,		NULL },
-{ 0x414b4d07, 0xffffffff, "AK4545",		NULL,		NULL },
 { 0x41445303, 0xffffffff, "AD1819",		patch_ad1819,	NULL },
 { 0x41445340, 0xffffffff, "AD1881",		patch_ad1881,	NULL },
 { 0x41445348, 0xffffffff, "AD1881A",		patch_ad1881,	NULL },
@@ -112,20 +107,25 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x41445374, 0xffffffff, "AD1981B",		patch_ad1981b,	NULL },
 { 0x41445375, 0xffffffff, "AD1985",		patch_ad1985,	NULL },
 { 0x41445378, 0xffffffff, "AD1986",		patch_ad1986,	NULL },
+{ 0x414b4d00, 0xffffffff, "AK4540",		NULL,		NULL },
+{ 0x414b4d01, 0xffffffff, "AK4542",		NULL,		NULL },
+{ 0x414b4d02, 0xffffffff, "AK4543",		NULL,		NULL },
+{ 0x414b4d06, 0xffffffff, "AK4544A",		NULL,		NULL },
+{ 0x414b4d07, 0xffffffff, "AK4545",		NULL,		NULL },
 { 0x414c4300, 0xffffff00, "ALC100,100P", 	NULL,		NULL },
 { 0x414c4710, 0xfffffff0, "ALC200,200P",	NULL,		NULL },
 { 0x414c4721, 0xffffffff, "ALC650D",		NULL,	NULL }, /* already patched */
 { 0x414c4722, 0xffffffff, "ALC650E",		NULL,	NULL }, /* already patched */
 { 0x414c4723, 0xffffffff, "ALC650F",		NULL,	NULL }, /* already patched */
 { 0x414c4720, 0xfffffff0, "ALC650",		patch_alc650,	NULL },
-{ 0x414c4760, 0xfffffff0, "ALC655",		patch_alc655,	NULL },
-{ 0x414c4781, 0xffffffff, "ALC658D",		NULL,	NULL }, /* already patched */
-{ 0x414c4780, 0xfffffff0, "ALC658",		patch_alc655,	NULL },
-{ 0x414c4790, 0xfffffff0, "ALC850",		patch_alc850,	NULL },
 { 0x414c4730, 0xffffffff, "ALC101",		NULL,		NULL },
 { 0x414c4740, 0xfffffff0, "ALC202",		NULL,		NULL },
 { 0x414c4750, 0xfffffff0, "ALC250",		NULL,		NULL },
+{ 0x414c4760, 0xfffffff0, "ALC655",		patch_alc655,	NULL },
 { 0x414c4770, 0xfffffff0, "ALC203",		NULL,		NULL },
+{ 0x414c4781, 0xffffffff, "ALC658D",		NULL,	NULL }, /* already patched */
+{ 0x414c4780, 0xfffffff0, "ALC658",		patch_alc655,	NULL },
+{ 0x414c4790, 0xfffffff0, "ALC850",		patch_alc850,	NULL },
 { 0x434d4941, 0xffffffff, "CMI9738",		patch_cm9738,	NULL },
 { 0x434d4961, 0xffffffff, "CMI9739",		patch_cm9739,	NULL },
 { 0x434d4969, 0xffffffff, "CMI9780",		patch_cm9780,	NULL },
-- 
1.5.5


--------------000006000004070200060601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000006000004070200060601--
