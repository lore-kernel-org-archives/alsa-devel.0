From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/4] Revert "ASoC: tlv320dac33: Use core to
 set the msbits constraint"
Date: Thu, 19 Jan 2012 19:33:10 +0100
Message-ID: <4F1861E6.1000700@ti.com>
References: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
	<1326997456-16296-2-git-send-email-peter.ujfalusi@ti.com>
	<20120119182602.GM3178@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 682A824393
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 19:33:15 +0100 (CET)
Received: by mail-yw0-f49.google.com with SMTP id j72so185236yhj.8
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 10:33:12 -0800 (PST)
In-Reply-To: <20120119182602.GM3178@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/19/2012 07:26 PM, Mark Brown wrote:
> On Thu, Jan 19, 2012 at 07:24:13PM +0100, Peter Ujfalusi wrote:
>> The core implementation applies the msbits constraint to samples
>> where it should not.
>> Do not ask core to do this, the original code does the right thing.
> =

> Peter, grow up.  With my last patch (well, a typo fixed version of it)
> userspace will do what you want.

If you actually read the thread it was one of my problem.
It might not bother you that we are wasting CPU cycles for nothing, but
it annoys me.
This is the reason we need to update the CPUs every 2 years.

Please take this series. I'm not going to allow that the TI drivers will
waste CPU cycles (for nothing).

-- =

P=E9ter
