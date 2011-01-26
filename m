From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Triggering a DAPM widget event
Date: Wed, 26 Jan 2011 18:27:54 +0000
Message-ID: <20110126182754.GJ8501@opensource.wolfsonmicro.com>
References: <39D4D143FC30524CAB784A72ADFECEEE34A0BC92CA@NLCLUEXM02.connect1.local>
	<20110126165347.GB10759@sirena.org.uk>
	<39D4D143FC30524CAB784A72ADFECEEE34A0E8F3DF@NLCLUEXM02.connect1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E2C51037EC
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 19:27:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <39D4D143FC30524CAB784A72ADFECEEE34A0E8F3DF@NLCLUEXM02.connect1.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harrod, John" <john.harrod@philips.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 26, 2011 at 07:08:31PM +0100, Harrod, John wrote:

http://daringfireball.net/2007/07/on_top

> I ran a few experiments where I frequently opened and closed the PCM. Under
> a heavy load, I sometimes get a resource busy error when I use the
> snd_pcm_open() call. So it looks like alsa-lib is not designed for frequent

Two issues here:
- Opening and closing streams are not the same thing as stopping and
  starting them.  From a power point of view only the stoping and
  starting of data transfer should make any difference.

- That said should be no problem with opening and closing streams as often
  as you like.  It seems most likely that if there's an issue here it's
  due to a race condition somewhere or other, quite possibly in the
  driver code.

> pcm opening and closing. I also noticed a few points in the alsa-lib code
> where dynamic memory is being allocated and freed and am wondering how this
> would affect heap fragmentation in the long term.

Obviously any dynamic memory allocator will be designed to deal with
frequent allocations and frees.  I would be astonished if this caused a
serious issue.

> So the pre-powerdown event should occur when no sound is being played? When you
> say stop the data flowing, you mean within the sound kernel module? There is
> no call that I need to make to alsa-lib (for example making a call to
> snd_pcm_pause())? It sounds like something is not working correctly in the kernel
> module...

Just stop playing data from your application.  For PCM streams from the
CPU that's all your application should need to do.

What is your actual problem here?
