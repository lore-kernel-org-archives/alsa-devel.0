From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ASoC: add TI ts3a227e headset chip driver
Date: Wed, 12 Nov 2014 14:31:41 -0800
Message-ID: <CAEUnVG5B44-iKbkOL0tZ43S2giNEcRutmDinNA3UC6wvgySSrg@mail.gmail.com>
References: <1415829023-13340-1-git-send-email-dgreid@chromium.org>
 <20141112221452.GT3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 94BDD265AAD
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 23:32:03 +0100 (CET)
Received: by mail-ie0-f180.google.com with SMTP id y20so14746466ier.11
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 14:32:02 -0800 (PST)
In-Reply-To: <20141112221452.GT3815@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, dmitry.torokhov@gmail.com, Benson Leung <bleung@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2014 at 2:14 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Nov 12, 2014 at 01:50:23PM -0800, Dylan Reid wrote:
>
>> This chip also has built-in support for the new button standard
>> described in the Android "Wired audio headset specification" v1.0.
>> These buttons will be reported on a separate input device.
>
> We have a standard jack detection reporting interface in ASoC which can
> cope with buttons, please use it for them instead of creating a second
> device unless there's a strong reason.  There are enough slots for that
> and an interface for specifying the values for the keys.

thanks Mark, I missed snd_jack_set_key, that will be much better.

I'll rework the patch to use that and resend.
