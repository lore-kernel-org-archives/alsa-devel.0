From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: Connecting a codec to an i2c codec driver.
Date: Thu, 24 Mar 2011 12:56:27 -0700
Message-ID: <4D8BA1EB.2080407@gmail.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
	<4D821A18.30407@ladisch.de>
	<AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
	<4D894196.4040002@gmail.com> <20110323110702.GA27671@sirena.org.uk>
	<AANLkTikr-9k9p8gXsaJ8uCtFKNmbNEwsp3JwMoj-kka7@mail.gmail.com>
	<20110323133013.GB25754@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 81E0A1037EA
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 20:56:35 +0100 (CET)
Received: by pzk12 with SMTP id 12so48492pzk.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 12:56:31 -0700 (PDT)
In-Reply-To: <20110323133013.GB25754@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/23/11 06:30, Mark Brown wrote:
> On Wed, Mar 23, 2011 at 06:22:59AM -0700, Steve Calfee wrote:
>> On Wed, Mar 23, 2011 at 4:07 AM, Mark Brown
>
>>> You need to write a machine driver for your board describing how the
>>> CODEC is connected to the CPU and other components in your system.
>
>> Great, can you give me a pointer to a sample arm source code
>> in the 2.6.38 kernel?
>
> There are *many* example machine drivers under sound/soc.  Look for a
> driver for a machine relevant to your CPU (eg, a reference board).

Thanks, that helps.

Any tips on how to turn on the debug printouts in the alsa and device 
systems? Do I recompile the kernel with new options etc? I already 
lowered the /proc/sys/kernel/printk level to 8.

Regards, Steve
