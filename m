From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: 16-channel recording w/ LAYLA, ALSA, JACK, ARDOUR
Date: Wed, 12 Apr 2006 23:29:30 -0400
Message-ID: <1144898970.10666.139.camel@localhost.localdomain>
References: <20060412200957.GA4090@hurl.ugcs.caltech.edu>
	<1144873089.27496.22.camel@mindpipe> <1144878001.27496.33.camel@mindpipe>
	<20060413031705.GA9160@hurl.ugcs.caltech.edu>
Reply-To: paul@linuxaudiosystems.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20060413031705.GA9160@hurl.ugcs.caltech.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lance Blisters <geoff@hurl.ugcs.caltech.edu>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-04-12 at 20:17 -0700, Lance Blisters wrote:

> ALSA: cannot configure playback channel
> cannot load driver module alsa

i don't believe that "multi" will work without the MMAP_COMPLEX patch to
JACK that has been outstanding for months and months. its available in
the patch tracker at jackit.sf.net if you want to try it; otherwise i
intend to merge it next week or the week after.

> Beyond that, the solution you suggest creates two devices, one 
> 16 channel playback the other 16 channel capture.  The core problem 
> is that JACK will only open a single device.  So even if multi_playback
> and _capture worked, to the best of my knowledge that would still
> not enable me to run ardour in 16 channel duplex.  Wouldn't it require
> another layer of asym or something to present it as a single device?
> Or can _playback itself be opened duplex?  The definition seems
> identical to _capture anyhow....

this command: 

   jackd -d alsa -P hw:0 -C hw:1

opens different devices for capture and playback

--p






-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
