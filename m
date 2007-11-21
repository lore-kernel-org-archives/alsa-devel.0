From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Channel mapping
Date: Wed, 21 Nov 2007 16:17:41 +0100
Message-ID: <1195658261.9272.1222564051@webmail.messagingengine.com>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hr6ijhljj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 843A5243C6
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 16:17:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr6ijhljj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Lennart Poettering <mznyfn@0pointer.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Yes, querying channel mapping is another missing piece with popular
> demand.
> 
> The implementation would be easy, I guess.  But we have to define the
> way to inform this from kernel to user space: whether create a new
> ioctl or extend the existing ones (if possible)...

It's just metadata that describes a PCM device, so I think we should use
TLV for this.

The existing struct snd_ctl_tlv uses a single integer to identify
control elements.  We could restrict control numid's to 31 bits and
use the upper bit to signal that this value includes device type and
device number in the lower bits, if we want to reuse the same TLV
ioctls.


Regards,
Clemens
