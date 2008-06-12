From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Thu, 12 Jun 2008 12:51:01 +0100
Message-ID: <g2r2j5$g3$1@ger.gmane.org>
References: <20080609190225.GA4534@tango.0pointer.de>	<s5h1w333o7r.wl%tiwai@suse.de>
	<g2pc9p$16h$1@ger.gmane.org> <s5hod670x1s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id EDC71249AB
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 13:51:18 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K6lKh-0007mR-7C
	for alsa-devel@alsa-project.org; Thu, 12 Jun 2008 11:51:11 +0000
Received: from host-84-9-255-116.dslgb.com ([84.9.255.116])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2008 11:51:11 +0000
Received: from gmane by host-84-9-255-116.dslgb.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2008 11:51:11 +0000
In-Reply-To: <s5hod670x1s.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
>> I think this 
>> was done due to the docs specifically say that it is the "difference 
>> between appl_ptr and hw_ptr" so it makes sense to assume this will 
>> return 0 when there is nothing waiting to be played. I would strongly 
>> recommend that you remove the implementation detail from the (supposedly 
>> high level) docs.
> 
> Why?  I don't see your logic...

Well in the pulseaudio driver, snd_pcm_delay() will typically *not* 
return 0 because it will include e.g. network latency.

Therefore the wine code which *expects* it to return 0 (e.g. waits for 
it to return 0) does not get the relevant trigger it needs.

The fact that the implementation detail is included in the docs means 
that the belief that this function *will* return 0 in all cases when no 
samples are left to be played is totally understandable. As you and 
James have confirmed, the snd_pcm_delay() function should return details 
about the delay expected. The fact that this is the "difference
 >> between appl_ptr and hw_ptr" does not seem to be correct in all 
cases/impelmentations.

I'm no alsa expert so forgive me if I'm just "not getting it". :p

Col
