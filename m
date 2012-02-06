From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Remove even more unused
	code
Date: Mon, 6 Feb 2012 22:48:44 +0200
Message-ID: <CAMP44s23-cDE3dVur0zgXLF0J7fjuJmrh5jD_E4zyrySKgYzwg@mail.gmail.com>
References: <1328556193-24593-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20120206192826.GB12326@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F0918103839
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 21:48:44 +0100 (CET)
Received: by lags15 with SMTP id s15so3412525lag.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2012 12:48:44 -0800 (PST)
In-Reply-To: <20120206192826.GB12326@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 6, 2012 at 9:28 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Feb 06, 2012 at 07:23:13PM +0000, Mark Brown wrote:
>> Now that we're not implement GPIO or microphone support there's no users
>> for the read() function any more.
>
> That's microphone detect, not plain microphone.

s/implement/implementing?

-- 
Felipe Contreras
