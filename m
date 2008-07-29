From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 05/14] ASoC: Convert bitfields in ASoC into
	full int width
Date: Tue, 29 Jul 2008 10:06:40 -0400
Message-ID: <9e4733910807290706o3d51bf04rccd1a878dcb79248@mail.gmail.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<9e4733910807290649r7da6d154xbeebeab45c2fba8f@mail.gmail.com>
	<20080729135642.GA32357@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 365AE1038C6
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 16:06:42 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so3579865rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2008 07:06:41 -0700 (PDT)
In-Reply-To: <20080729135642.GA32357@rakim.wolfsonmicro.main>
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
To: Jon Smirl <jonsmirl@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/29/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 29, 2008 at 09:49:30AM -0400, Jon Smirl wrote:
>
>  > Do you want me to change the uints to unsigned int?
>
>
> Yes, that would be good.

Other patches in this series are stacked on top of this one. Let's put
it in as in and then do a new one with only uint to unsigned int
replacements.

-- 
Jon Smirl
jonsmirl@gmail.com
