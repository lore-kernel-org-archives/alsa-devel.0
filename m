From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: SoC multiple streams
Date: Wed, 27 Jun 2007 21:05:14 -0400
Message-ID: <75b66ecd0706271805l46be2c3dqe199f8bf9158772e@mail.gmail.com>
References: <4676FF4A.3020508@embeddedalley.com>
	<1182248283.26658.134.camel@localhost.localdomain>
	<4682FBE1.2090808@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id BCF8110380F
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 03:05:15 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so513773wag
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2007 18:05:14 -0700 (PDT)
In-Reply-To: <4682FBE1.2090808@embeddedalley.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Longerbeam <stevel@embeddedalley.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/27/07, Steve Longerbeam <stevel@embeddedalley.com> wrote:
> It's looking like the way to implement per-substream controls is to add
> the controls for all possible substreams, and then somehow determine
> which substream is being referred to in the get/put callbacks, and then
> get/put the control for only that substream. Is this the way
> per-substream controls should be done?
>
> Also, with 64 substreams and multiple controls for each, we're talking
> about adding hundreds of controls, can ALSA handle this? I can imagine
> alsamixer looking quite crowded :-/

Please check the ALSA emu10k1 driver for a sample implementation.  32
substreams, hardware mixing with independent HW volume control for
each.

Lee
