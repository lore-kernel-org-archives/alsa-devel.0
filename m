From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Wed, 11 Jun 2008 23:40:24 +0200
Message-ID: <48504648.5020000@dbservice.com>
References: <20080609190225.GA4534@tango.0pointer.de>	<s5h1w333o7r.wl%tiwai@suse.de>
	<g2pc9p$16h$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from matterhorn.dbservice.com (dbservice.com [213.239.204.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 12721248C3
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 23:40:31 +0200 (CEST)
Received: from [192.168.0.21] (gw.ptr-62-65-141-13.customer.ch.netstream.com
	[62.65.141.13])
	by matterhorn.dbservice.com (Postfix) with ESMTP id 2892B20BB3B6
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 23:40:18 +0200 (CEST)
In-Reply-To: <g2pc9p$16h$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
> AFAIK, the way Wine uses snd_pcm_delay() is to check when a sample is 
> fully played. e.g. they wait for the function to return 0. I think this 
> was done due to the docs specifically say that it is the "difference 
> between appl_ptr and hw_ptr" so it makes sense to assume this will 
> return 0 when there is nothing waiting to be played. I would strongly 
> recommend that you remove the implementation detail from the (supposedly 
> high level) docs.

Wine needs to know when a particular sample has been played by the 
hardware. And it should be reasonably accurate as some applications may 
depend on that timing. Currently Wine accounts for how many bytes it has 
written into the device, and then uses 'bytes_written - 
frames_to_bytes(snd_pcm_delay())' to find out which samples have been 
played. AFAICS alsa has no dedicated function to find out which samples 
have been played, so Wine is forced to emulate it using snd_pcm_delay(). 
If there is any function at all that would be more appropriate in that 
situation, please tell the Wine developers.

tom
