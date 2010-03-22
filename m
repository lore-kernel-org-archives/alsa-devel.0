From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Fix 0 dB offset for HP laptops
	using CX20551 (Waikiki)
Date: Mon, 22 Mar 2010 00:00:19 -0400
Message-ID: <604760771003212100x3579167cgfe2e0539dc69752e@mail.gmail.com>
References: <604760771003211601n3457e1d5jcff90aacefdcd112@mail.gmail.com>
	<4f3252891003212002y3de65f75xe84239e5d1458f56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CA8E2455D
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 05:00:22 +0100 (CET)
Received: by pxi7 with SMTP id 7so1602994pxi.5
	for <alsa-devel@alsa-project.org>; Sun, 21 Mar 2010 21:00:19 -0700 (PDT)
In-Reply-To: <4f3252891003212002y3de65f75xe84239e5d1458f56@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 21, 2010 at 11:02 PM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> how did he verifty the 0dB ? using hw device or pulseaudio

He's in the recipient list; I checked with him on IRC using PulseAudio
(latest stable-queue, flat volume disabled) running the patch applied
to the latest daily alsa-driver stable snap.
