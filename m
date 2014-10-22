From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Alsa-lib 32-bit on 64-bit machine
Date: Wed, 22 Oct 2014 08:59:13 +0100
Message-ID: <201410220859.13254.gineera@aspect135.co.uk>
References: <201410211912.21662.gineera@aspect135.co.uk>
 <s5hy4s8d1s0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 2.array2.smtp.34sp.com (2.array2.smtp.34sp.com [46.183.9.2])
 by alsa0.perex.cz (Postfix) with ESMTP id AB0FF2625ED
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 09:59:03 +0200 (CEST)
Received: from smtpauth1.array1.smtp.34sp.com (lvs3.34sp.com [80.82.124.221])
 by 2.array2.smtp.34sp.com (Postfix) with ESMTP id 1AAFAFF2BF
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 08:59:01 +0100 (BST)
In-Reply-To: <s5hy4s8d1s0.wl-tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wednesday 22 October 2014 08:03, you wrote:
> At Tue, 21 Oct 2014 19:12:21 +0100,
>
> Alan Horstmann wrote:
> > I've tried to find info or examples of this on the web, but to no avail.
> >
> > What is the recommended way to build Alsa-lib on a 64-bit machine to
> > create the additional alternative 32-bit libraries for compatibility with
> > 32-bit applications?
> >
> > The original distro (in this case a Suse Enterprise) has them, but
> > standard './configure make install' only builds the 64-bit variants.  I
> > only succeeded by explicitly adding CFLAGS, and wondered if it should
> > work using configure options, or another way?  I'm also not sure exactly
> > which flags should be set with that method (m32, march=i686 others?). 
> > Does anyone know how it is done in the Suse builds?
>
> I don't know of any other than passing CFLAGS and LDFLAGS.

OK, thanks; what is the purpose/use of '--target=' or '--build=' configure 
options?

Regards

Alan
