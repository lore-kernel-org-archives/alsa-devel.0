From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] PnP: Protocol for Media Vision
 Jazz16	sound cards
Date: Thu, 26 Apr 2007 14:55:03 +0200
Message-ID: <4630A127.1030908@gmail.com>
References: <20070412195523.GC5324@sygehus.dk> <4628F7FD.7000808@gmail.com>
	<20070420200007.GD3192@sygehus.dk> <462B8D00.8020305@gmail.com>
	<20070423185221.GA3157@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 2808D24A68
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2007 14:57:18 +0200 (CEST)
In-Reply-To: <20070423185221.GA3157@sygehus.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: Adam Belay <ambx1@neo.rr.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/23/2007 08:52 PM, Rask Ingemann Lambertsen wrote:

> On Sun, Apr 22, 2007 at 06:27:44PM +0200, Rene Herman wrote:

>> The Intel 430TX and 440BX (which also uses the PIIX4 if I'm not
>> mistaken) were hugely popular chipsets in the later generation of
>> boards that still had ISA slots and given that noone will deperately
>> want the MPU-401 IRQ assigned; how would you feel about the attached?
>> Just adds the preffered options minus the MPU IRQ as the first
>> acceptable. Works for me...
> 
> Fine with me. Maybe the MPU IRQ should be omitted alltogether? You tell 
> me.

"Using the hardware to its fullest potential" should probably be called the 
preferred option. I mean, what's the fun of playing with this old hardware 
if we're not going to use it fully? :)

So as submitted (or nothing at all but if we suppose the driver will be 
seeing practical use, guarding against that PIIX4 seems best) is nicest I feel.

> Aren't you having problems loading the module after a resource allocation
> failure? I find that I need this additional patch to be able to retry:

I've had to remove the jazz16 again for a bit and I haven't tested an 
allocation failure yet. That looks to be an "obvious fix" though. Now all we 
need is a PnP maintainer...

Rene.
