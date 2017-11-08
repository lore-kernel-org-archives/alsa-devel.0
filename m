From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr
	during dma
Date: Wed, 8 Nov 2017 14:35:05 -0500
Message-ID: <CADnq5_M8y44hapOkPoapGP-WRP=a-6zc3s-A_3Fv85ssPRFFEQ@mail.gmail.com>
References: <20171108181841.29332-1-alexander.deucher@amd.com>
 <20171108182214.bwdvt5wwwz7wqf32@sirena.co.uk>
 <CADnq5_PM=C9OjseqvV8M5ohm7Mo18foHGPUkFZSnVNpVruut8Q@mail.gmail.com>
 <20171108184752.wff6qn6ssguaegkq@sirena.co.uk>
 <BN6PR12MB1652F8671D062FDE91D42951F7560@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CABXOdTf=nEu_KAnAvT0p9tn96xiGGSqYzW1o0XUBDf9EHb+CoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A982267581
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 20:35:07 +0100 (CET)
Received: by mail-yw0-f193.google.com with SMTP id q126so3270307ywq.10
 for <alsa-devel@alsa-project.org>; Wed, 08 Nov 2017 11:35:07 -0800 (PST)
In-Reply-To: <CABXOdTf=nEu_KAnAvT0p9tn96xiGGSqYzW1o0XUBDf9EHb+CoA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guenter Roeck <groeck@google.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Guenter Roeck <groeck@chromium.org>, Mark Brown <broonie@kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 8, 2017 at 2:30 PM, Guenter Roeck <groeck@google.com> wrote:
> On Wed, Nov 8, 2017 at 11:18 AM, Deucher, Alexander
> <Alexander.Deucher@amd.com> wrote:
>>
>> > -----Original Message-----
>> > From: Mark Brown [mailto:broonie@kernel.org]
>> > Sent: Wednesday, November 08, 2017 1:48 PM
>> > To: Alex Deucher
>> > Cc: amd-gfx list; alsa-devel@alsa-project.org; Maling list - DRI
>> > developers;
>> > Mukunda, Vijendar; Liam Girdwood; Takashi Iwai; Guenter Roeck; Deucher,
>> > Alexander
>> > Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
>> >
>> > On Wed, Nov 08, 2017 at 01:40:32PM -0500, Alex Deucher wrote:
>> > > On Wed, Nov 8, 2017 at 1:22 PM, Mark Brown <broonie@kernel.org>
>> > wrote:
>> >
>> > > > Like I said in reply to your other mail please don't resubmit
>> > > > already
>> > > > applied patches.  The current tip of my topic/amd branch appears to
>> > > > be
>> > > > this very patch, if there's anything needs changing please send an
>> > > > incremental patch.
>> >
>> > > I'm not seeing this one in your tree either.  This is just a resend of
>> > > Guenter's patch from an hour ago with the chromium stuff removed.
>> > > Maybe you already applied it in the interim?
>> >
>> > Is this different to "ASoC: amd: Report accurate hw_ptr during dma"
>> > which was applied at 16:07?
>>
>> Yes, this is a fix for that patch.  It fixes a 64 bit division that wasn't
>> properly handled.
>>
>
> In that case, the subject should reflect the problem fixed, the description
> should describe the problem, and there should be a Fixes: tag pointing to
> the problematic patch.

I updated the patch subject and added a fixes tag when I resent it
after removing the chrome tags.  The subject could have been bit
better, but I wasn't sure how far to take it since it wasn't my patch
originally.

Alex

>
> Sorry, I was not aware that the problematic patch is already pending
> upstream, or I would have submitted a proper patch upstream myself.
>
> Guenter
>
>>
>> Alex
>>
>
