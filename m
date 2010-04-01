From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: line in recording w/ alsa - suggestions for a snd
 card?
Date: Thu, 01 Apr 2010 15:47:58 +0200
Message-ID: <4BB4A40E.2040809@ladisch.de>
References: <20100401151931.6ff54457@romy.gusto>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id BB934243DB
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 15:48:00 +0200 (CEST)
In-Reply-To: <20100401151931.6ff54457@romy.gusto>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars Schotte <lars.schotte@schotteweb.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Lars Schotte wrote:
> does anybody have a suggestion for a sound card PCI-internal that
> works w/ ALSA and records HQ from line-in that can be used for
> digitalizing?

There aren't that many PCI chipsets.  The CMI8738/8768/8770 chips have
the DACs and ADCs integrated and aren't very good (although the 68/70
are noticeably better).  The ICE1712/1724, CA0106, X-Fi and CMI8788
chips are purely digital and must be combined with separate DAC/ADC
chips, which usually are quite good.

The X-Fi is not supported very well.  The CA0106 is supported, and used
on several cheap Sound Blaster cards, e.g. the SB 5.1 VX.  The ICE1712/
ICE1724 chips are used in many models; see the .h files in
<http://git.alsa-project.org/?p=alsa-kernel.git;a=tree;f=sound/pci/ice1712;hb=HEAD>.
(The "ICE1723" is a low-end model, and I don't know if it's supported at
all).  The CMI8788 is used on the Asus Xonar cards; the D1/DX/D2/D2X/ST/
STX are supported; the DS is partially supported in the latest kernel.


Regards,
Clemens
