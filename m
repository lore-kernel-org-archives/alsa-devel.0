From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Jack event API - decision needed
Date: Thu, 23 Jun 2011 09:01:33 +0200
Message-ID: <4E02E4CD.7060709@ladisch.de>
References: <20110620170739.GD32056@opensource.wolfsonmicro.com>	<4DFF973A.1080404@canonical.com>	<20110620234053.GA1905@opensource.wolfsonmicro.com>	<4E008A63.5080403@canonical.com>	<20110621123908.GA25980@opensource.wolfsonmicro.com>	<4E01C847.7060505@canonical.com>	<20110622114826.GD18726@opensource.wolfsonmicro.com>	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>	<20110622132518.GB21802@opensource.wolfsonmicro.com>	<20110622210131.GA6861@tango.0pointer.de>
	<20110623011045.GB20949@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id AE82C103AA7
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 09:01:36 +0200 (CEST)
In-Reply-To: <20110623011045.GB20949@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, David Henningsson <david.henningsson@canonical.com>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> We need some way for userspace to figure out that a jack exists and
> that it contains multiple functionalities from multiple subsystems.
> If we have a proposal for how we do that which seems viable then
> great, but we don't have that yet.

Last November I posted a patch to add ALSA entity types to the media
API; it stalled due to lack of time.  What's still missing is
a mechanism to associate entities with ALSA controls.


Regards,
Clemens
