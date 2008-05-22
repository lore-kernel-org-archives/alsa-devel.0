From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Moving sound/* to drivers/ ?
Date: Thu, 22 May 2008 18:40:31 +0200
Message-ID: <4835A1FF.3050902@keyaccess.nl>
References: <s5hzlqjz74d.wl%tiwai@suse.de> <4834B252.1080700@garzik.org>
	<4834B5E2.3040301@keyaccess.nl> <s5hy7623fqs.wl%tiwai@suse.de>
	<alpine.LNX.1.10.0805221052050.971@fbirervta.pbzchgretzou.qr>
	<alpine.LFD.1.10.0805220758000.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id A5FBF24406
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 18:38:05 +0200 (CEST)
In-Reply-To: <alpine.LFD.1.10.0805220758000.3081@woody.linux-foundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alsa-devel@alsa-project.org, Jeff Garzik <jeff@garzik.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@medozas.de>
List-Id: alsa-devel@alsa-project.org

On 22-05-08 17:04, Linus Torvalds wrote:

> On Thu, 22 May 2008, Jan Engelhardt wrote:

>> I am in favor of keeping /sound around with the
>> non-hardware-dependent code, much like /block does with regard to
>> /drivers/block.
> 
> I'd personally *much* rather have just one subdirectory.

Then I'd agree/suggest ALSA move to drivers/sound. I brought it up but 
both Jaroslav and Takashi agree with you. For me it was more a "nicely 
reflects the design of things" issue than anything else...

I do agree that the drivers are better of in drivers/ and they are 10 
times the size of the sound core.

Rene.
