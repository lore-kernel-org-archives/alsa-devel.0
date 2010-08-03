From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Auto-muting line-outs?
Date: Tue, 3 Aug 2010 16:23:21 +0800
Message-ID: <AANLkTi=9QgTBvxcQVV7X-BhFQEPvV2nPmJwy2kA3cmuN@mail.gmail.com>
References: <4C57CB09.2090004@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0CB622413B
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 10:23:22 +0200 (CEST)
Received: by vws20 with SMTP id 20so3154939vws.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 01:23:22 -0700 (PDT)
In-Reply-To: <4C57CB09.2090004@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/8/3 David Henningsson <david.henningsson@canonical.com>

> I'm getting bug reports from downstream about auto-muting not working,
> and when looking at some of them I find that the reason is that they
> have a headphone + line-out combination instead of headphone + speaker.
>
> Looking at commits such as 2a2ed0df, this is intentional. I'm not sure
> what the majority of users want or expect in this case though, of course
> the users who like it the way it is, aren't raising their voices. :-)
>
> Anyway, for users that really want auto-muting for their line-outs,
> would a suitable workaround to recommend them, be to tweak
> user_pin_config, turning the line-out into a speaker-out, or would that
> have undesirable side effects?
>
>
headphone + speaker usually occur in laptop

headphone + line out occur in desktop

As HDA support multi streaming, the front panel green/pink jacks may be used
independent of the audio jacks in rear panels in desktop on some HDA codec
