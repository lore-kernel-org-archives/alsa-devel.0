From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Making ALSA apps run on OSS driver
Date: Thu, 06 Dec 2007 12:34:32 +0100
Message-ID: <1196940872.19688.1225129847@webmail.messagingengine.com>
References: <61445c750712060056w23b00084j5e5c6a30f1d38bc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 26470244EC
	for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2007 12:34:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <61445c750712060056w23b00084j5e5c6a30f1d38bc7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> I have heard about OSS emulation in ALSA i.e. any read/write to /dev/dsp will go to my ALSA driver
> but is there any way to do the reverse i.e. apps using ALSA interface should somehow talk to OSS
> driver?

The alsa-plugins package has the "oss" plugin for this:
http://hg.alsa-project.org/alsa-plugins/raw-file/878b7784425c/doc/README-pcm-oss


HTH
Clemens
