From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA patch Nvidia 8 channel hdmi audio
Date: Wed, 03 Jun 2009 09:22:50 +0200
Message-ID: <4A2624CA.8020406@ladisch.de>
References: <410e92830906021458x3d47a1d6jebba8bbe1150e76d@mail.gmail.com>	<200906030022.07693.marek.vasut@gmail.com>	<410e92830906021530l767478c4tae72c4b161583b6@mail.gmail.com>	<200906030200.54455.marek.vasut@gmail.com>
	<15F501D1A78BD343BE8F4D8DB854566B058A63F1@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id C271C24621
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 09:22:41 +0200 (CEST)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B058A63F1@hkemmail01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wei Ni <wni@nvidia.com>
Cc: Peer Chen <pchen@nvidia.com>, Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, Alan Alan <alanwww1@gmail.com>
List-Id: alsa-devel@alsa-project.org

Wei Ni wrote:
> I used mplayer to test. The channels are mapped good.
> Running mplayer -ao alsa:device=hw=0.3 6ch.wav
> 
> I tried to use speaker-test to test, but I can't get the hdmi device name.
> I used speaker-test -Dsurround51:NVidia -c6, the sound output from the analog jack.

speaker-test -Dhw:0,3 -c6

Or put a line
  pcm.hdmi = "hw:0,3"
into your ~/.asoundrc or the /etc/asound.conf file, then you can just
use the device name "hdmi" everywhere.


HTH
Clemens
