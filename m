From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: add STA32X codec driver
Date: Mon, 20 Jun 2011 08:07:42 +0200
Message-ID: <BANLkTinK_ohyW6kQNOS7gNRXqYybX9NDNA@mail.gmail.com>
References: <BANLkTinVAPv4gyAg3OOP=6oZ+bNEeAojDA@mail.gmail.com>
	<1308226043-18584-1-git-send-email-zonque@gmail.com>
	<20110617094531.GC7851@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 32FD0103857
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 08:07:44 +0200 (CEST)
Received: by pzk26 with SMTP id 26so3495389pzk.38
	for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2011 23:07:42 -0700 (PDT)
In-Reply-To: <20110617094531.GC7851@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 17, 2011 at 11:45 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jun 16, 2011 at 02:07:23PM +0200, Daniel Mack wrote:
>
> Looks very good, a few small nits, if Liam's OK I guess we could fix
> these incrementally:
>
>> +#define DEBUG
>
> This shouldn't be in the submission.
>
>> +SOC_SINGLE_TLV("Master Volume", STA32X_MVOL, 0, 0xff, 1, mvol_tlv),
>> +SOC_SINGLE("Master Playback Switch", STA32X_MMUTE, 0, 1, 1),
>> +SOC_SINGLE("Ch1 Playback Switch", STA32X_MMUTE, 1, 1, 1),
>> +SOC_SINGLE("Ch2 Playback Switch", STA32X_MMUTE, 2, 1, 1),
>> +SOC_SINGLE("Ch3 Playback Switch", STA32X_MMUTE, 3, 1, 1),
>> +SOC_SINGLE_TLV("Ch1 Volume", STA32X_C1VOL, 0, 0xff, 1, chvol_tlv),
>> +SOC_SINGLE_TLV("Ch2 Volume", STA32X_C2VOL, 0, 0xff, 1, chvol_tlv),
>> +SOC_SINGLE_TLV("Ch3 Volume", STA32X_C3VOL, 0, 0xff, 1, chvol_tlv),
>
> The "Playback" should be consistently either present or not present in
> both volume and mute controls so UIs can match them up easily.
>

I've sent a fixed version of this patch just after you mentioned these
issues. Hope it's all good now.

Daniel
