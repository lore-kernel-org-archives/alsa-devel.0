From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Access to bytes from the raw audio stream? (AC'97)
Date: Wed, 3 Feb 2010 16:17:37 +0000
Message-ID: <20100203161737.GC12034@sirena.org.uk>
References: <94cf76f1002030808t1d54dc08oab179673e814f016@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 80129103818
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 17:17:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <94cf76f1002030808t1d54dc08oab179673e814f016@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Graham <johngavingraham@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 03, 2010 at 04:08:38PM +0000, John Graham wrote:

> So, can anybody tell me what functions and files in the sound/
> directory of the linux kernel I need to look at to see/modify the raw
> data stream coming in? Am I just missing something in the tutorial?
> I'd appreciate any suggestions very much.

With a lot of AC97 controllers the hardware won't allow you direct
access to the cooked wire data, you'll only be able to see decoded audio
streams.  What is it that you're actually trying to do?

For embedded platforms you mostly want to look under sound/soc though
there are a few platforms outside of there.
