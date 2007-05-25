From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Suggestion for getting alsa to use Conexant
Date: Thu, 24 May 2007 19:32:55 -0700
Message-ID: <1180060375.9034.18.camel@razman.gruemaster.com>
References: <000301c78d28$9d7a3a70$bbe664d0@PC120716747189>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id EF4DB243E0
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 04:32:59 +0200 (CEST)
In-Reply-To: <000301c78d28$9d7a3a70$bbe664d0@PC120716747189>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Victor Schneider <vtailor@copper.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I don't think this is limited to the Conexant CX20549 (5045) or the
CX20551 (5047).  I have a laptop with a Conexant vendor ID of 2bfa.  The
hda-intel driver picks it up, but uses the hda-generic configuration.

On the CX20549 & CX20551, I think I need to toggle a bit to enable the
MFG portion.  I have a test board here, but the drivers are not
detecting it, even without my patch_conexant code.  I'll look at the
intel-80xm module, but it is written for the AC'97 bus specification,
which is very different from the HDA bus specification.

Tobin

On Wed, 2007-05-02 at 21:13 -0500, Victor Schneider wrote:

> How about being able to parameterize Alsa modules so that the intel 80xm 
> module finds any hda modem that also acts as an Intel hda chip? I am 
> referring to the Conexant combination modem and hda chip that gets 
> identified as "Conexant Waikiki" by alsamixer, but that 80xm can't find as a 
> modem. Giving the 80xm module the device:identifier value to override its 
> detection of the Intel version of the Conexant hda modem might let slmodemd 
> work.
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
