From: Pieter Palmers <pieterp@joow.be>
Subject: Re: Support for SAM9407?
Date: Wed, 02 May 2007 19:57:15 +0200
Message-ID: <4638D0FB.6020103@joow.be>
References: <20070501111831.35E301F50B1@ws1-2.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rusty.kulnet.kuleuven.ac.be (rusty.kulnet.kuleuven.ac.be
	[134.58.240.42]) by alsa0.perex.cz (Postfix) with ESMTP id B93952446D
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2007 19:57:19 +0200 (CEST)
In-Reply-To: <20070501111831.35E301F50B1@ws1-2.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ash Willis <ashwillis@programmer.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ash Willis wrote:

> In the interest of making ALSA that bit more complete as well as trying to
> improve my skills, I've been looking around for some older hardware that I can
> write drivers for.

Are you interested in joining the FFADO project? (short into: FFADO = 
new FreeBoB = drivers for FireWire Audio Interfaces / www.ffado.org).

We need somebody that wants to write the ALSA support for FreeBoB / 
FFADO. Currently we only support jackd directly. The main reason that 
there is no ALSA support is simply that there is nobody that is doing 
it. We have a library that exposes an API that can be used to write 
backends for audio API's, and we have the jackd backend as an example. 
It's simply a matter of putting it all together, but we need someone to 
do it.

To be frank/direct here, I think that ALSA is better 'completed' with 
FFADO support than with driver support for obsolete cards. But of course 
I'm a little biased here :).

Greets,

Pieter Palmers
