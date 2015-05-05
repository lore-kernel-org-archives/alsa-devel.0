From: Sergej Sawazki <ce3a@gmx.de>
Subject: Re: [RFC PATCH] ASoC: wm8741: Add differential mono
	mode support
Date: Tue, 05 May 2015 16:07:09 +0200
Message-ID: <EABFA35E-4B67-4CA9-8C48-95203DEAA582@gmx.de>
References: <1430504037-7170-1-git-send-email-ce3a@gmx.de>
 <20150504112537.GA15510@sirena.org.uk> <5547C29C.9020905@gmx.de>
 <20150505112239.GD22845@sirena.org.uk>
 <B33D8E95-F8F9-40B8-B9BC-6AA8734A4838@gmx.de>
 <20150505135731.GF22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 615FF2619F0
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 16:07:16 +0200 (CEST)
In-Reply-To: <20150505135731.GF22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>
Cc: ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org



Am 5. Mai 2015 15:57:31 MESZ, schrieb Mark Brown <broonie@kernel.org>:
>On Tue, May 05, 2015 at 02:19:38PM +0200, Sergej Sawazki wrote:
>
>> The mono mode of the device should not be confused
>> with the ALSA mono mode. If the device is in mono mode
>> it either plays the left (mono left mode) or the right (mono
>> right mode) channel.
>
>> My board has two of this DACs (left and right channel). 
>> The control names should be different, hence my
>> suggestion for the "Left" and "Right" prefixes.
>
>That's fine and totally normal.
>
>> Another approach would be to say that the machine
>> driver is responsible for mixer controls if the devices
>> are in mono mode. What do you think?
>
>Yes, the machine driver should do this - you may have left and right on
>your board but these configurations are for example often used with 5.1
>systems.

Good point. Thanks. I am going to resend the patch as v2.
