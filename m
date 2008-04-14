From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 19:22:59 +0200
Message-ID: <480392F3.9030701@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>
	<480099C6.3040708@superbug.co.uk>
	<20080412133536.GC32491@tango.0pointer.de>
	<48010E62.2020404@keyaccess.nl>
	<20080414170022.GH22115@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DFF0244E1
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 19:20:08 +0200 (CEST)
In-Reply-To: <20080414170022.GH22115@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: mznyfn@0pointer.de, James Courtier-Dutton <James@superbug.co.uk>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 14-04-08 19:00, Lennart Poettering wrote:

> On Sat, 12.04.08 21:32, Rene Herman (rene.herman@keyaccess.nl) wrote:

>> If we add in ISA cards, it's not a very generic assumption at least. For 
>> example on my cs4236, "master" is -94,5 to +12 dB with 0dB at "87" in the 
>> integer scale.
>>
>> It's a "Master Digital Gain" -- not sure what that "digital" implies as it 
>> very much seems to be positioend in the post output mixer analog path...
> 
> Maybe the driver should add an internal offset to the dB scale, to
> guarantee that 0dB is max, instead of just copying the hw specs?

No, really quite definitely not. 0 dB means no attenuation of amplification. 
How loud that actually ends up is very much dependent on what's _behind_ 
your line-out.

In this specific example, the cs4236 master is split in a digital part -60 
dB to 0 and an anlog -34,5 to +12. I most certainly want "0 dB" to mean no 
analog amplification (nor (digital) attenuation, but the analog is what I 
want to know) is being done.

And "Reply-To" from my previous message should be "Mail-Followup-To". Please 
kill that.

Rene.
