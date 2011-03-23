From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: Connecting a codec to an i2c codec driver.
Date: Wed, 23 Mar 2011 06:22:59 -0700
Message-ID: <AANLkTikr-9k9p8gXsaJ8uCtFKNmbNEwsp3JwMoj-kka7@mail.gmail.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
	<4D821A18.30407@ladisch.de>
	<AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
	<4D894196.4040002@gmail.com> <20110323110702.GA27671@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 81C9D243A9
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 14:24:37 +0100 (CET)
Received: by fxm6 with SMTP id 6so7279813fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 06:24:37 -0700 (PDT)
In-Reply-To: <20110323110702.GA27671@sirena.org.uk>
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

On Wed, Mar 23, 2011 at 4:07 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 22, 2011 at 05:40:54PM -0700, Steve Calfee wrote:
>
> You should fix your mail client to word wrap within paragraphs.
>

Hi Mark,

I am still trying to figure out how to get thunderbird to behave, sorry.

>> I can modprobe the driver (in this case snd_soc_max98088), and no alsa
>> "cards" or other linkages are established.
>
> You need to write a machine driver for your board describing how the
> CODEC is connected to the CPU and other components in your system.
>
Great, can you give me a pointer to a sample arm source code
in the 2.6.38 kernel?

Regards, Steve
