From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 1/31] HDA patch_via.c: Remove
	IS_VT17xx_VENDORID macro
Date: Thu, 8 Oct 2009 15:28:17 +0800
Message-ID: <16685ee0910080028m620ead80j28c9cc03d45d51@mail.gmail.com>
References: <16685ee0910050628r328962bbt1af7e429264868d3@mail.gmail.com>
	<s5hd4516g5t.wl%tiwai@suse.de>
	<16685ee0910072227v76bb2e38kc75c91565c45f633@mail.gmail.com>
	<s5h63aqtobl.wl%tiwai@suse.de>
	<16685ee0910072311h2995f96fw100ad0bdbfdb9390@mail.gmail.com>
	<s5h1vletnp4.wl%tiwai@suse.de>
	<16685ee0910072322o4de9666bwbb88006e3a301897@mail.gmail.com>
	<s5hws36s8m8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id AB6C210398A
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 09:28:18 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1640063bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2009 00:28:18 -0700 (PDT)
In-Reply-To: <s5hws36s8m8.wl%tiwai@suse.de>
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
Cc: LoganLi@viatech.com.cn, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 8, 2009 at 2:27 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 8 Oct 2009 14:22:07 +0800,
> Li Bo wrote:
>>
>> On Thu, Oct 8, 2009 at 2:16 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Thu, 8 Oct 2009 14:11:42 +0800,
>> > Li Bo wrote:
>> >>
>> >> On Thu, Oct 8, 2009 at 2:03 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > At Thu, 8 Oct 2009 13:27:49 +0800,
>> >> > Li Bo wrote:
>> >> >>
>> >> >> [ALSA] HDA VIA: Remove unused IS_VT17xx_VENDORID macro
>> >> >>
>> >> >> IS_VT17*_VENDORID macros are used nowhere, so clean them up.
>> >> >>
>> >> >> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>> >> >
>> >> > Li, could you add your sign-off, too, when you handle the patches?
>> >> > Otherwise I can't merge them.
>> >> >
>> >> >
>> >> > thanks,
>> >> >
>> >> > Takashi
>> >> >
>> >>
>> >> Is that OK signed-off with LoganLi@viatech.com.cn with this gmail
>> >> liboat@gamil.com? LoganLi@viatech.com.cn is my company's email.
>> >> If not, I'll will resend them tomorrow when I go back to company.
>> >
>> > I don't care which address you use (and I don't know whether it
>> > matters your employer). =A0It's fully your choice.
>> >
>> > But, if the signed address is different from the mail sender, add a
>> > line "From: YOUR NAME <your@mail>" at the beginning of the patch
>> > explicitly.
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>> >
>> I just randomly use my gmail. I will resend them tomorrow, thank you for
>> teaching me:)
>
> Well, I was unclear in the text above.
>
> You can send patches with the sign-off of your company account even
> from your gmail account. =A0Just add "From:" line with your company
> account in the patch text so that I can pick up the right address.
>
>
> Takashi
>
like this?
[ALSA] HDA VIA: Remove unused IS_VT17xx_VENDORID macro

IS_VT17*_VENDORID macros are used nowhere, so clean them up.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>
From: Li Bo <liboat@gmail.com>

---
 sound/pci/hda/patch_via.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -76,14 +76,6 @@
 #define VT1702_HP_NID		0x17
 #define VT1702_DIGOUT_NID	0x11

-#define IS_VT1708_VENDORID(x)		((x) >=3D 0x11061708 && (x) <=3D 0x1106170b)
-#define IS_VT1709_10CH_VENDORID(x)	((x) >=3D 0x1106e710 && (x) <=3D 0x1106=
e713)
-#define IS_VT1709_6CH_VENDORID(x)	((x) >=3D 0x1106e714 && (x) <=3D 0x1106e=
717)
-#define IS_VT1708B_8CH_VENDORID(x)	((x) >=3D 0x1106e720 && (x) <=3D 0x1106=
e723)
-#define IS_VT1708B_4CH_VENDORID(x)	((x) >=3D 0x1106e724 && (x) <=3D 0x1106=
e727)
-#define IS_VT1708S_VENDORID(x)		((x) >=3D 0x11060397 && (x) <=3D 0x1106739=
7)
-#define IS_VT1702_VENDORID(x)		((x) >=3D 0x11060398 && (x) <=3D 0x11067398)
-
 enum VIA_HDA_CODEC {
 	UNKNOWN =3D -1,
 	VT1708,
