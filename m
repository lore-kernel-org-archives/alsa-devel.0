From: Randolph Chung <rchung42@gmail.com>
Subject: Re: Questions about alsa driver for i.Mx27 + wm8974:
 playback time shorter than the original record time
Date: Thu, 26 Aug 2010 22:13:37 +0800
Message-ID: <AANLkTin7TWwLH1B9WGebA0_wL_qLK6KQo+FENs7doQg3@mail.gmail.com>
References: <1282824338.1106.44.camel@UT43>
	<20100826124137.GA3509@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AC57F103836
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 16:13:38 +0200 (CEST)
Received: by yxj4 with SMTP id 4so603557yxj.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 07:13:38 -0700 (PDT)
In-Reply-To: <20100826124137.GA3509@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jie Jiang <jjinfo@nudt.edu.cn>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> What's the possible reason causing the incorrect faster playback speed?
>> Any suggestion is appreciated.
>
> Normally this will be the result of either an incorrect frame rate or
> the hardware trying to play back mono data as stereo (which will cause
> data to be consumed as twice the expected rate).

Although I have only seen this on capture, another possible reason for
this is due to the way the SSI registers are setup on the MX27.

Eric B=E9nard's patches that are in the latest kernel fixed a similar
problem for me. The eukrea audio machine driver was a good reference.

randolph
