From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: IEC switch issues
Date: Wed, 23 Jun 2010 14:05:32 +0200
Message-ID: <4C21F88C.6000200@ladisch.de>
References: <AANLkTinpl5hs7NRAm38uF7FbGCOuIOxCvohD70jOQxam@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id AD07F2444C
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 14:05:35 +0200 (CEST)
In-Reply-To: <AANLkTinpl5hs7NRAm38uF7FbGCOuIOxCvohD70jOQxam@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pl bossart wrote:
> If I play my AC3 data on my HDAudio/SPDIF output using the hw:0,1
> device, I can use alsamixer/amixer to mute/unmute.
> 
> Now if I use the iec958: plugin, I can't control the mute switch any longer:

Muting an AC-3 stream would require encoding a stream of silent PCM
samples (no data is not the same as silence); therefore, the iec958
plugin disallows muting.


Regards,
Clemens
