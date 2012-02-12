From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Re: 1ca3d59d5a3e762fb1c002bcd912914bc858b430 broke
 passthrough [Was: Re: ALSA 1.0.25 broke AC3 passthrough?]
Date: Mon, 13 Feb 2012 00:44:53 +1100
Message-ID: <CANpj82+JuX69+Qw1VU=cE9TxHnMi_cPfmiQyGMf5rmY6wY+-yg@mail.gmail.com>
References: <CANpj82JKFx1YXgaY3HZyTSyCZs83ZdvEtYGAbNJPdb6q7qN7kg@mail.gmail.com>
	<4F37BBDD.1090207@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E82A024346
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 14:44:55 +0100 (CET)
Received: by yenm14 with SMTP id m14so2090661yen.38
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 05:44:54 -0800 (PST)
In-Reply-To: <4F37BBDD.1090207@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 13 February 2012 00:17, Anssi Hannula <anssi.hannula@iki.fi> wrote:

> I'm not familiar enough with HDA to comment on the cause of the issue,
> but out of interest, does the hang really only happen with passthrough,
> i.e. (AES0 & 0x02) set, or does it happen with a PCM stream with the
> same parameters as well (and the application(s) just happen to set
> problematic ALSA parameters only in passthrough mode)?

Hi

To be honest, I don't really know for sure.

But I've only experienced it with digital passthrough.

If I disable passthrough, and force the decoding of the AC3 and
downmix it as stereo (so it would open the audio card with the same
parameters as with passthrough), then I do not see the hang

But I haven't looked into the details very carefully to make sure that
it is indeed the case.

I will try more tomorrow..
