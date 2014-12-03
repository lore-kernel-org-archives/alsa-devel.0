From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH v2] ASoC: rt5677: make volume TLV closer to
	reality
Date: Wed, 3 Dec 2014 13:04:56 -0800
Message-ID: <CAEUnVG40K+mABKU8D34gMpU2j9n-vBv85VRUowNhEKWfQ7SWuw@mail.gmail.com>
References: <1412892687-1264-1-git-send-email-dgreid@chromium.org>
 <20141009231042.GC18557@sirena.org.uk>
 <CAEUnVG72KL7iYGVgg8UMM6NyeSEe8vFADjFKzE4cLUUYwqTq5w@mail.gmail.com>
 <20141013080110.GE27755@sirena.org.uk>
 <CAOMFOmWJgceaLYbZ_yk_40eDrO7manNw9MEh0uDUH+_sW3GbCA@mail.gmail.com>
 <20141203201353.GN7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 17220260533
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 22:05:19 +0100 (CET)
Received: by mail-ob0-f169.google.com with SMTP id vb8so1775396obc.0
 for <alsa-devel@alsa-project.org>; Wed, 03 Dec 2014 13:05:17 -0800 (PST)
In-Reply-To: <20141203201353.GN7712@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, benzh@chromium.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 3, 2014 at 12:13 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Dec 03, 2014 at 12:10:52PM -0800, Anatol Pomozov wrote:
>
>> If kernel solution is preferable are you going to accept Dylan's
>> solution then? Or you think it should be implemented other way?
>
> To repeat my original review comment:
>
> | The usual thing to do with these is just to halve the resolution of the
> | control by ignoring the low bit so that you get exact values, though for
> | this device that does result in a relatively large step (step sizes like
> | 0.125dB are more common).  I dunno, doesn't make much difference either
> | way from my point of view.

Sorry, My fault here.  I forgot to send a v2 after I got back from
ELCE.  I'll try to dig up the machine I have that change on and get it
sent out later in the week.
