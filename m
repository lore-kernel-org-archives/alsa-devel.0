From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: trouble using S/PDIF input on CMI8738-MC6:
	C-Media	CMI8738 (model 55)
Date: Thu, 21 Aug 2014 12:31:28 +0200
Message-ID: <53F5CA80.8020300@ladisch.de>
References: <53EA40EB.2060201@seniorblanco.com>
 <53EB80C3.7020909@ladisch.de>	<53EB9C3B.2070602@seniorblanco.com>
 <53F53B4C.20905@seniorblanco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 315E926571A
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 12:31:31 +0200 (CEST)
In-Reply-To: <53F53B4C.20905@seniorblanco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jon <jon@seniorblanco.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jon wrote:
> i/o error and resulting 44-byte file of silence.

This indicates that the chip does not see any S/PDIF signal.

Can't you connect some S/PDIF output to an input for testing?

> I'm wondering if this problem could be really just as simple as
> someone having guessed wrong about the correct value there having not
> had this particular model on hand to test with?

C-Media chips were very common once upon a time, and S/PDIF input always
worked just fine for everybody else.  There are no GPIOs, so the only
possible hardware implementation is to connect the S/PDIF input directly
to the chip's input pin(s).

The Windows driver for this board is the standard C-Media driver, so
there isn't any additional hardware that needs to be programmed.

I don't know anything that could be done.


Regards,
Clemens
