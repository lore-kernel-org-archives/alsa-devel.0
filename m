From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [LAD] implementing audio device driver on embedded
 platforms
Date: Tue, 07 Jul 2009 12:48:04 +0200
Message-ID: <4A5327E4.2040203@ladisch.de>
References: <2F30E5E59E98344DA24420015E36EB96032709C8@shydexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 85C6524738
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 12:48:09 +0200 (CEST)
In-Reply-To: <2F30E5E59E98344DA24420015E36EB96032709C8@shydexmb1.amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linux-audio-dev@lists.linuxaudio.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jugalkishore Darak, Pankaj wrote:
> We are porting Linux 2.6.25.4 to a platform which has ARM11 as its core
> processor. My job is to implement audio device driver.

Then you'd better ask on alsa-devel (CC'd).

> Most of the docs are meant for PC audio which has sound cards on PCI.
> And the source code resides in sound folder under the kernel root.
> 
> Since mine is an embedded platform, where will my architecture specific
> code resides?

Any platform-specific code will be below your arch/ directory.
The DMA controller and the codecs are likely to be used on other
platforms too, so they'd go into sound/.

> Which all folders under sound folder will be used for embedded devices

mostly soc/

> and which APIs to look into?

linux/Documentation/sound/alsa/soc/*.txt
http://alsa-project.org/main/index.php/ASoC
http://opensource.wolfsonmicro.com/content/asoc-audio-embedded-linux-systems


HTH
Clemens
