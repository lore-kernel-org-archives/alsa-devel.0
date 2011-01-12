From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [uclinux-dist-devel] [PATCH] ASoC: Blackfin TDM:
 use external frame syncs
Date: Wed, 12 Jan 2011 11:36:25 -0500
Message-ID: <AANLkTins-dSkJ1e_Z4RmffpgC1wQ-chkXFZ1hq162gP=@mail.gmail.com>
References: <1294819195-29119-1-git-send-email-vapier@gentoo.org>
	<20110112111222.GC20911@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A45E245E8
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 17:36:49 +0100 (CET)
Received: by wwi18 with SMTP id 18so4175312wwi.2
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 08:36:45 -0800 (PST)
In-Reply-To: <20110112111222.GC20911@opensource.wolfsonmicro.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 12, 2011 at 06:12, Mark Brown wrote:
> On Wed, Jan 12, 2011 at 02:59:55AM -0500, Mike Frysinger wrote:
>> From: Barry Song <barry.song@analog.com>
>
>> We don't want to use internal frame syncs otherwise we sometimes
>> get out of sync, so don't enable them when setting up the SPORT.
>
> This sounds a lot like the TDM mode needs to be clock slave on the
> external bus, though it's a bit hard to tell?

i believe that's the case
-mike
