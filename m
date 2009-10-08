From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 1/31] HDA patch_via.c: Remove
	IS_VT17xx_VENDORID macro
Date: Thu, 8 Oct 2009 15:56:51 +0800
Message-ID: <16685ee0910080056t20601488k23480f3ee3ee02b3@mail.gmail.com>
References: <16685ee0910050628r328962bbt1af7e429264868d3@mail.gmail.com>
	<s5hd4516g5t.wl%tiwai@suse.de>
	<16685ee0910072227v76bb2e38kc75c91565c45f633@mail.gmail.com>
	<s5h63aqtobl.wl%tiwai@suse.de>
	<16685ee0910072311h2995f96fw100ad0bdbfdb9390@mail.gmail.com>
	<s5h1vletnp4.wl%tiwai@suse.de>
	<16685ee0910072322o4de9666bwbb88006e3a301897@mail.gmail.com>
	<s5hws36s8m8.wl%tiwai@suse.de>
	<16685ee0910080028m620ead80j28c9cc03d45d51@mail.gmail.com>
	<s5hhbuas5fa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 01F0A24380
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 09:56:51 +0200 (CEST)
Received: by fxm8 with SMTP id 8so5243949fxm.45
	for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2009 00:56:51 -0700 (PDT)
In-Reply-To: <s5hhbuas5fa.wl%tiwai@suse.de>
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

On Thu, Oct 8, 2009 at 3:36 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 8 Oct 2009 15:28:17 +0800,
> Li Bo wrote:
>>
>> On Thu, Oct 8, 2009 at 2:27 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Thu, 8 Oct 2009 14:22:07 +0800,
>> > Li Bo wrote:
>> >>
>> >> On Thu, Oct 8, 2009 at 2:16 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > At Thu, 8 Oct 2009 14:11:42 +0800,
>> >> > Li Bo wrote:
>> >> >>
>> >> >> On Thu, Oct 8, 2009 at 2:03 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> >> > At Thu, 8 Oct 2009 13:27:49 +0800,
>> >> >> > Li Bo wrote:
>> >> >> >>
>> >> >> >> [ALSA] HDA VIA: Remove unused IS_VT17xx_VENDORID macro
>> >> >> >>
>> >> >> >> IS_VT17*_VENDORID macros are used nowhere, so clean them up.
>> >> >> >>
>> >> >> >> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>> >> >> >
>> >> >> > Li, could you add your sign-off, too, when you handle the patche=
s?
>> >> >> > Otherwise I can't merge them.
>> >> >> >
>> >> >> >
>> >> >> > thanks,
>> >> >> >
>> >> >> > Takashi
>> >> >> >
>> >> >>
>> >> >> Is that OK signed-off with LoganLi@viatech.com.cn with this gmail
>> >> >> liboat@gamil.com? LoganLi@viatech.com.cn is my company's email.
>> >> >> If not, I'll will resend them tomorrow when I go back to company.
>> >> >
>> >> > I don't care which address you use (and I don't know whether it
>> >> > matters your employer). =A0It's fully your choice.
>> >> >
>> >> > But, if the signed address is different from the mail sender, add a
>> >> > line "From: YOUR NAME <your@mail>" at the beginning of the patch
>> >> > explicitly.
>> >> >
>> >> >
>> >> > thanks,
>> >> >
>> >> > Takashi
>> >> >
>> >> I just randomly use my gmail. I will resend them tomorrow, thank you =
for
>> >> teaching me:)
>> >
>> > Well, I was unclear in the text above.
>> >
>> > You can send patches with the sign-off of your company account even
>> > from your gmail account. =A0Just add "From:" line with your company
>> > account in the patch text so that I can pick up the right address.
>> >
>> >
>> > Takashi
>> >
>> like this?
>> [ALSA] HDA VIA: Remove unused IS_VT17xx_VENDORID macro
>>
>> IS_VT17*_VENDORID macros are used nowhere, so clean them up.
>>
>> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>> Signed-off-by: Logan Li <loganli@viatech.com.cn>
>> From: Li Bo <liboat@gmail.com>
>
> No, add your sign-off address, i.e. "Logan Li
> <loganli@viatech.com.cn>" to From: line, and put it at the beginning
> of the patch.
>
> But, now another question is who is the original author of the patch.
> Is it Lydia? =A0Then the "From:" line should be of Lydia. =A0In that way,
> we can clarify who is the original author.
>
> If you changed something from the original patch, better to mention
> in the changelog text, too.
>
> And, at best, add "Subject:" to each subject line, so that git-am can
> pick up properly. =A0So, the patch head would look like:
>
> =A0From: Lydia Wang <lydiawang@viatech.com.cn>
> =A0Subject: ALSA: HDA VIA: Fix blah blah
>
> =A0blah blah
> =A0...
>
> =A0Changed foo bar by Logan Li.
> =A0blah blah
> =A0...
>
> =A0Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
> =A0Signed-off-by: Logan Li <loganli@viatech.com.cn>
>
>
> thanks,
>
> Takashi
>
Yes, Lydia is the original author.
like this?

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Remove unused IS_VT17xx_VENDORID macro

IS_VT17*_VENDORID macros are used nowhere, so clean them up.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Li Bo <liboat@gmail.com.cn>

---
 sound/pci/hda/patch_via.c |    8 --------
 1 file changed, 8 deletions(-)
