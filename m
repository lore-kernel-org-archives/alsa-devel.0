From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH v2] ASoC: rt5677: make volume TLV closer to
	reality
Date: Wed, 3 Dec 2014 12:10:52 -0800
Message-ID: <CAOMFOmWJgceaLYbZ_yk_40eDrO7manNw9MEh0uDUH+_sW3GbCA@mail.gmail.com>
References: <1412892687-1264-1-git-send-email-dgreid@chromium.org>
 <20141009231042.GC18557@sirena.org.uk>
 <CAEUnVG72KL7iYGVgg8UMM6NyeSEe8vFADjFKzE4cLUUYwqTq5w@mail.gmail.com>
 <20141013080110.GE27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DC2426042F
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 21:10:52 +0100 (CET)
Received: by mail-lb0-f169.google.com with SMTP id p9so12827090lbv.14
 for <alsa-devel@alsa-project.org>; Wed, 03 Dec 2014 12:10:52 -0800 (PST)
In-Reply-To: <20141013080110.GE27755@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.de>, Dylan Reid <dgreid@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, benzh@chromium.org
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, Oct 13, 2014 at 1:01 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 09, 2014 at 07:27:40PM -0700, Dylan Reid wrote:
>
>> I can easily add a flag to the UCM config to hint userspace to divide by 10, so
>> I'm not strongly tied to making this change if it isn't bothering anyone else.
>
> I was thinking about just doing this in the driver rather than working
> around it in userspace.

If kernel solution is preferable are you going to accept Dylan's
solution then? Or you think it should be implemented other way?
