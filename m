From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 13:44:42 +0100
Message-ID: <g2tq3q$969$1@ger.gmane.org>
References: <20080609190225.GA4534@tango.0pointer.de>	<s5h1w333o7r.wl%tiwai@suse.de>	<20080612205225.GB20818@tango.0pointer.de>	<s5hd4mlhlau.wl%tiwai@suse.de>	<Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
	<48524882.6050606@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 18923244D3
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 14:44:57 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K78eA-000069-Oy
	for alsa-devel@alsa-project.org; Fri, 13 Jun 2008 12:44:50 +0000
Received: from host-84-9-255-116.dslgb.com ([84.9.255.116])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2008 12:44:50 +0000
Received: from gmane by host-84-9-255-116.dslgb.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2008 12:44:50 +0000
In-Reply-To: <48524882.6050606@superbug.co.uk>
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

James Courtier-Dutton wrote:
> Jaroslav Kysela wrote:
>> On Fri, 13 Jun 2008, Takashi Iwai wrote:
>>
>>   
>>> - Add some new API functions,
>>>     
>> I would prefer to extend the current API than to change meaning of hw_ptr 
>> to handle extra latencies.
>>
>>   
> I would prefer the definition of snd_pcm_delay() to be:
> Before the next sample is written to the buffer, snd_pcm_delay() returns 
> the expect time delay, in frames, indicating the time the next sample 
> will reach the speakers.
> This is what snd_pcm_delay() was introduced into the ALSA api for. I 
> remember, because it was added as a result of me requesting it.
> 
> 
> Then implement a totally different api call to help with under run timings.

Big +1

You also have to think of the use cases currently out there.

* World + Dog uses it as James (and Lennart) states.
* Wine uses it sans latency.

So lots of apps having to change to cope verses one (known) app 
changing. I think even the wine folk would agree this is more sensible!

Also by changing the definition, would you not have to change the 
usb-audio driver works? In general I'd say it's a whole lot less work to 
leave snd_pcm_delay() as it is, update the docs and add a new api 
function for under run stuff.

Col
