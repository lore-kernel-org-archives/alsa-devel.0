From: Daniel Mack <zonque@gmail.com>
Subject: Re: Generic clock divider indices
Date: Thu, 06 Jun 2013 16:09:52 +0200
Message-ID: <51B09830.7020208@gmail.com>
References: <51B09224.9050409@gmail.com> <20130606135605.GB9980@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 323772655C5
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 16:09:24 +0200 (CEST)
Received: by mail-wi0-f179.google.com with SMTP id hm9so393306wib.0
 for <alsa-devel@alsa-project.org>; Thu, 06 Jun 2013 07:09:23 -0700 (PDT)
In-Reply-To: <20130606135605.GB9980@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06.06.2013 15:56, Mark Brown wrote:
> On Thu, Jun 06, 2013 at 03:44:04PM +0200, Daniel Mack wrote:
> 
>> Would it be an idea to define some commonly used dividers in the core?
>> If they start at 0x80000000, they won't collide with existing ones, and
>> we could simply add them as alternative case statements to existing drivers.
> 
> I don't think this is a terribly sensible idea; as soon as you start
> relying on these dividers in machine code you're going to run into
> drivers that just don't implement them either due to hardware or due to
> them being able to figure things out by themselves and...

I do see that we have a way to propagate the sysclk, but how would you
determine the bit clock rate from a codec driver?

Also, the same problem with freely definable indices is true for
.set_sysclk() as well. Not all drivers expect the actual MCLK rate here.


Daniel
