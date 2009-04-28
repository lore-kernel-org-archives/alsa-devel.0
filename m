From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 16/17] ASoC: Basic split of mpc5200 DMA
	code out from mpc5200_psc_i2s
Date: Tue, 28 Apr 2009 12:55:16 -0400
Message-ID: <9e4733910904280955u179bc260k80dd955fce6d1c0a@mail.gmail.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
	<1240932222-3718-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hljpk233w.wl%tiwai@suse.de>
	<9e4733910904280859t6409e9b7w4eccee65959598e5@mail.gmail.com>
	<s5hk554sow9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id EEFEE10385F
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 18:55:18 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 26so141683eyw.56
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 09:55:18 -0700 (PDT)
In-Reply-To: <s5hk554sow9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 28, 2009 at 12:51 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 28 Apr 2009 11:59:01 -0400,
> Jon Smirl wrote:
>>
>> On Tue, Apr 28, 2009 at 11:46 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Tue, 28 Apr 2009 16:23:41 +0100,
>> > Mark Brown wrote:
>> >>
>> >> From: Jon Smirl <jonsmirl@gmail.com>
>> >>
>> >> Basic split of mpc5200 DMA code out from i2s into a standalone file.
>> >>
>> >> [Fixed trailing whitespace -- broonie.]
>> >>
>> >> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>> >> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>> >> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> >
>> > This patch conflicts with the last patch I merged to add
>> > SNDRV_PCM_INFO_BATCH to some drivers including mpc5200.
>> > (It's in fix/pcm-info-batch branch and not merged to */asoc branch
>> > =A0yet. =A0Feel free to pull to your tree by yourself.)
>> > And, the jiffies check shall be anyway fixed in the upstream PCM core
>> > side, thus there is no big merit to hurry to merge the unfinished
>> > changes now.
>> >
>> > So, could you back off mpc5200 changes and wait for a while until the
>> > issue regarding PCM jiffies-check is resolved?
>>
>> This is why I was pushing so hard to get the patches that split the
>> files in.
>
> And this is why I am against pulling now :)

I wanted the split files added to 2.6.30 not 2.6.31. If they had gone
into 2.6.30 you would have patched after the split and everything
would have propagated without merge conflicts. In general, changes in
git that cross a file split will cause manual manual merges in
everything pending past the split.

>
>
> Takashi
>



-- =

Jon Smirl
jonsmirl@gmail.com
