From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Wed, 21 Mar 2012 11:16:14 +0200
Message-ID: <4F699C5E.6070905@ti.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<4F68AE51.808@bitmer.com> <4F698B56.6030502@ti.com>
	<4F69920B.4010701@bitmer.com>
	<20120321084051.GA9342@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F21110441E
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 10:16:34 +0100 (CET)
Received: by lbol5 with SMTP id l5so802351lbo.8
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 02:16:17 -0700 (PDT)
In-Reply-To: <20120321084051.GA9342@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2012 10:40 AM, Mark Brown wrote:
> On Wed, Mar 21, 2012 at 10:32:11AM +0200, Jarkko Nikula wrote:
>> On 03/21/2012 10:03 AM, Peter Ujfalusi wrote:
> =

>>> Well, for system integration's point of view I would prefer the sysfs
>>> file. If this is needed by the distribution/use case it can be enabled,
>>> disabled in runtime. In my view it poses less hassle for distributions.
> =

>> Problem with custom sysfs is that no generic distribution is going to
>> use it but problem can be triggered there. IMHO for tailored
>> distribution point of view custom sysfs setting is no better than custom
>> asound.conf.
> =

> I have to say that I agree wholeheartedly with this - the sysfs rule has
> all the problems that a custom asound.conf does.

Agreed. Let's drop this patch, and try to figure out something which can
be used by other platforms as well.

I would keep the first two patch in this series..

-- =

P=E9ter
