From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: Re: SoC multiple streams
Date: Wed, 27 Jun 2007 17:08:01 -0700
Message-ID: <4682FBE1.2090808@embeddedalley.com>
References: <4676FF4A.3020508@embeddedalley.com>
	<1182248283.26658.134.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.biz.mail.mud.yahoo.com (smtp102.biz.mail.mud.yahoo.com
	[68.142.200.237]) by alsa0.perex.cz (Postfix) with SMTP id B6CAA2454F
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 02:08:21 +0200 (CEST)
In-Reply-To: <1182248283.26658.134.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Mon, 2007-06-18 at 14:55 -0700, Steve Longerbeam wrote:
>   
>> Hi all,
>>
>> I'm developing an SoC driver for a sound engine that supports playing up 
>> to 64 simultaneous substreams, all mixed in h/w to a stereo DAC. But it 
>> doesn't appear that the SoC framework supports multiple substreams, 
>> according to soc_new_pcm(). Am I missing something, or is this on the 
>> asoc development roadmap?
>>
>>     
>
> It's now on the development roadmap ;)
>
> https://bugtrack.alsa-project.org/wiki/wikka.php?wakka=ASoCRoadMap
>   

that's cool, thanks.

I've got some more questions about multiple substreams. In the sound 
engine I'm working on, each "voice" (substream) has its own private 
controls, such as L/R volume, 3D (distance and angle factors), and gain 
envelopes. All 64 substreams are then mixed in h/w to a single stereo 
stream, and global controls are then applied, such as master volume.

It's looking like the way to implement per-substream controls is to add 
the controls for all possible substreams, and then somehow determine 
which substream is being referred to in the get/put callbacks, and then 
get/put the control for only that substream. Is this the way 
per-substream controls should be done?

Also, with 64 substreams and multiple controls for each, we're talking 
about adding hundreds of controls, can ALSA handle this? I can imagine 
alsamixer looking quite crowded :-/

Thanks,
Steve
