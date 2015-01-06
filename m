From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: tegra: Add platform driver for
	rt5677 audio codec
Date: Tue, 6 Jan 2015 10:46:04 -0800
Message-ID: <CAOMFOmWVwXF_S5UyeZG61VVRfxpQj=WmTe0Dm+SC4fxksWT9=Q@mail.gmail.com>
References: <1419362942-26192-1-git-send-email-anatol.pomozov@gmail.com>
 <20141226163826.GD17800@sirena.org.uk>
 <CAOMFOmW5BL4HpzC9Q32Q48s90Mnd0cqM5np8gH5RxZEXCAEEdw@mail.gmail.com>
 <20141229155532.GM17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 355ED2604F7
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 19:46:05 +0100 (CET)
Received: by mail-la0-f43.google.com with SMTP id s18so20676115lam.16
 for <alsa-devel@alsa-project.org>; Tue, 06 Jan 2015 10:46:04 -0800 (PST)
In-Reply-To: <20141229155532.GM17800@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Bard Liao <bardliao@realtek.com>, Laurent Dahan <ldahan@nvidia.com>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, Dec 29, 2014 at 7:55 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Dec 29, 2014 at 05:25:59AM -0800, Anatol Pomozov wrote:
>> On Fri, Dec 26, 2014 at 8:38 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> >> +#if defined(CONFIG_MODULES) && defined(MODULE)
>> >> +     request_module("snd_soc_tegra30_i2s");
>> >> +#endif
>
>> > What's this all about then?
>
>> Sorry, my question was not clear. I meant is it ok to put this
>> request_module() to upstream code? If not then just remove it before
>> merging my patch.
>
> What question, I'm not seeing a question in the patch (I'd expect it to
> be after the --- if one was being asked)?  I've no idea what it's there
> for so it's hard to tell, my first thought would be no and you need to
> fix whatever you're working around directly.


My question was related to dependency between i2s and codec driver
modules. See it here (in the middle of the message)
http://permalink.gmane.org/gmane.linux.alsa.devel/132054

Anyway I think it is not worth spending too much time on it. I resent
this patch without request_module().
