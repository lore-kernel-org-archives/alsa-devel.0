From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ALSA: hda - apply CS420X erratum fix for
	CS4207 only
Date: Wed, 2 Mar 2011 22:03:28 +0000
Message-ID: <C9941A81.3C4F%brian.austin@cirrus.com>
References: <1299102498-29063-2-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id E02A1103834
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 23:04:14 +0100 (CET)
In-Reply-To: <1299102498-29063-2-git-send-email-arun.raghavan@collabora.co.uk>
Content-Language: en-US
Content-ID: <3896511C628FAE4689139A00087A0626@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

That should not happen. This sequence was tested on all version of cs420x

Is there some output of the failure you can report?

On 3/2/11 3:48 PM, "Arun Raghavan" <arun.raghavan@collabora.co.uk> wrote:

>From: Arun Raghavan <arun@accosted.net>
>
>The commit a769cbcf60cee51f4431c0938acd39e7e5b76b8d
>    ALSA: hda - Add errata initverb sequence for CS42xx codecs
>applies a fix for a chip erratum that is specific to CS4207
>unconditionally. On CS4206, this causes digital output to never be
>activated.
>---
> sound/pci/hda/patch_cirrus.c |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
>index a07b031..9804b09 100644
>--- a/sound/pci/hda/patch_cirrus.c
>+++ b/sound/pci/hda/patch_cirrus.c
>@@ -1065,8 +1065,9 @@ static int cs_init(struct hda_codec *codec)
> {
>     struct cs_spec *spec = codec->spec;
> 
>-    /* init_verb sequence for C0/C1/C2 errata*/
>-    snd_hda_sequence_write(codec, cs_errata_init_verbs);
>+    /* init_verb sequence for CS4207 C0/C1/C2 errata */
>+    if (codec->vendor_id == 0x10134207)
>+        snd_hda_sequence_write(codec, cs_errata_init_verbs);
> 
>     snd_hda_sequence_write(codec, cs_coef_init_verbs);
> 
>-- 
>1.7.4.1
>
>
