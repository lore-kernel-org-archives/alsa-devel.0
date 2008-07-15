From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/3] ALSA SoC: Add Texas
	Instruments	TLV320AIC26 codec	driver
Date: Tue, 15 Jul 2008 11:33:34 +0100
Message-ID: <20080715103333.GM25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216108672.9701.5.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FFEA24348
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 12:33:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1216108672.9701.5.camel@dinesh.dua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dinesh <dinesh.dua@coraltele.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 15, 2008 at 01:27:52PM +0530, dinesh wrote:

> I have one query about this soc driver.
>  I want to know when u will merge it with kernel then 
> where and by which name this device will be available
>  in /dev directory of your file system.

> As i am following the same structure for my driver so please help me. I
> am ot able to recognise the device in the file system.

It will appear via the standard ALSA interfaces (and OSS interfaces if
you enable OSS compatibility).  The standard location for ALSA device
files is under /dev/snd where you'll see several files per device.
