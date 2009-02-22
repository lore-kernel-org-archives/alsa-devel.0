From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Standard mixer control names
Date: Sun, 22 Feb 2009 12:00:12 +0000
Message-ID: <1235304012.27887.528.camel@vega.slimlogic.co.uk>
References: <20090221233629.GA3748@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 606201037EC
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 13:00:17 +0100 (CET)
In-Reply-To: <20090221233629.GA3748@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 2009-02-22 at 00:36 +0100, Lennart Poettering wrote:
> Heya!
> 
> I'd like to add functionality to PulseAudio to allow a simplified
> selection of capture input (i.e. "Mic", "Line-In", ...) and playback
> outputs ("Headphones", "Line-Out", ...) for ALSA cards. By
> "simplified" I mean that only one input and output shall be active at
> a time. Also, some more nonsense items shall be filtered out
> (i.e. recording from "Phone"). Hence, basically I want to compile a
> list of available and whitelisted inputs and outputs and allow the
> user to select exactly one from each.
> 

Fwiw, I may have mentioned at the FOSDEM beer party that this feature
was on the to todo list for the hardware use case or scenario manager.
Although being a beer party we may not remember discussing....

http://www.slimlogic.co.uk/?p=40

>  Now I'd of course prefer if the drivers
> get fixed to use a single element naming scheme only. Is there any
> chance to get that? And which one would that be?
> 

This would likely be quite time consuming wrt to embedded drivers due to
the complex audio hardware requirements of modern mobile phones. There
are numerous hardware routes with different inputs and outputs and they
are used in different combinations depending on use case.

I think it's probably quite reasonable to do this for most PC sound
cards as they are often simpler in terms inputs/outputs.

Liam
