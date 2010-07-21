From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Merging alsa-firmware into linux-firmware
Date: Wed, 21 Jul 2010 08:53:13 +0200
Message-ID: <4C469959.7020600@ladisch.de>
References: <4C457C89.5040209@canonical.com> <4C45A538.2060704@ladisch.de>
	<4C45C521.4020208@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0428424465
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 08:53:18 +0200 (CEST)
In-Reply-To: <4C45C521.4020208@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, alsa-devel@alsa-project.org, David Woodhouse <david.woodhouse@intel.com>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> On 2010-07-20 15:31, Clemens Ladisch wrote:
> > I wonder what you're going to do about the multisound firmware files;
> > the /lib/firmware/turtlebeach/*.bin files are just symbolic links to
> > the actual files in /etc/sound that owners of these cards (if any such
> > still exist) are supposed to have.  
> 
> Ah, thanks for bringing this up to my attention. From where do these
> .bin-files come originally?

I don't know more than what Documentation/sound/oss/MultiSound says.
The download links in there are, of course, broken; with Google, I've
found msndvkit.zip but not pnddk100.zip.

> Can we include them?

| This developer's kit does not provide you with a license to distribute
| any of the contained software, including, but not limited to
| DSPCODE.OBJ, MCONTROL.C. Developers wishing to use these in specific
| applications can do so by requesting and returning the "MultiSound DSP
| OEM Licensing Agreement".
| 
| Turtle Beach's policy on redistribution is simple. For a license fee
| of $1, we allow developers to distribute the above code modules along
| with their products, provided that MultiSound hardware is included in
| the target product. Since DSP_CODE.OBJ only works with MultiSound
| hardware, this is the only logical use of the code.

Try asking Turtle Beach.

> > (Er, wasn't there a regression introduced in the emi62 firmware in
> > 2.6.27?)

http://xiphmont.livejournal.com/46858.html


Regards,
Clemens
