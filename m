From: chri <chripell@gmail.com>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Mon, 10 Nov 2008 20:08:00 +0100
Message-ID: <cabda6420811101108od6fe848qc291135a2ba9d819@mail.gmail.com>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110133451.GD12804@sirena.org.uk>
	<20081110185800.42b6c198.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by alsa0.perex.cz (Postfix) with ESMTP id E14972438D
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 20:08:00 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so935769eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 11:08:00 -0800 (PST)
In-Reply-To: <20081110185800.42b6c198.kristoffer.ericson@gmail.com>
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
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, zdevai@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2008 at 6:58 PM, Kristoffer Ericson
<kristoffer.ericson@gmail.com> wrote:
> On Mon, 10 Nov 2008 13:34:52 +0000

> I'm equally interested in this patch, seeing as I
> got an hp jornada 7xx with uda1344 waiting.
>
> Have you any plans on creating an 134x seeing as there
> is very little difference between chipsets?
>

Hi,

I had a quick look at the UDA1344 data sheet. When operated in L3-mode
it's basically a subset of the UDA1341 so I can do the changes. Anyway
I'm not able to test them so could you give me a hand testing? Anyway
if you won't use special mixer settings the patch I sent should work
since the important configuration registers and the volume are the
same for both chips.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
