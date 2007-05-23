From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: bios update alters hda-intel and alsamixer
Date: Tue, 22 May 2007 23:05:04 -0700
Message-ID: <1179900304.15236.162.camel@razman.gruemaster.com>
References: <ccc103cf0705222155q70db032ckdedfbbde4ccda832@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id A8510245B4
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2007 08:05:06 +0200 (CEST)
In-Reply-To: <ccc103cf0705222155q70db032ckdedfbbde4ccda832@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Could you post the output from this script:
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh

It was written by a user on the #alsa irc channel, and has been very
helpful in debugging sound driver issues, at least for me.

Tobin

On Tue, 2007-05-22 at 23:55 -0500, Chris Pemberton wrote: 

> After updating the bios on a Lenovo notebook, my hda-intel sound "changed"
> 
> Before the bios update I used kernel 2.6.20.3, external
> alsa-driver-1.0.14rc3 and the attached patch_realtek.c (in-kernel alsa
> wouldn't work)
> 
> After the bios update I use just the alsa contained in kernel 2.6.20.3.
> 
> Before bios update, my mixer contained many items:  including master,
> front, mic, pcm, etc.
> 
> Now it only contains master and pcm.
> 
> So, I have a few questions:
> 
> How can I determine what items are "supposed" to show up in alsamixer?
> 
> Where can I submit my laptop soundcard information to help finalize
> support of this model/card?
> 
> Thank you
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
