From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-bebob and PrismSound Orpheus fails
	with	snd_pcm_hw_params_set_channels
Date: Thu, 23 Apr 2015 14:48:20 +0200
Message-ID: <5538EA14.6040105@ladisch.de>
References: <CAJ0eYfWMxiD1HhfD_UC48FGiNfrPdtYPyc7MzVhByde-W4FSqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 48703261A01
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 14:48:22 +0200 (CEST)
In-Reply-To: <CAJ0eYfWMxiD1HhfD_UC48FGiNfrPdtYPyc7MzVhByde-W4FSqg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Ood <jh1ood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mike Ood wrote:
> Clemens wrote:
>> An with "hw", you have disabled any automatic format conversion.
>> Try "plughw:2" or "default:2".
>
> Could you be kind enough to suggest how I should write .asoundrc?

You should not write an .asoundrc.
You should replace "hw" with "plughw" in the device name.


Regards,
Clemens
