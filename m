From: Gary Scavone <gary@ccrma.Stanford.EDU>
Subject: hdsp channel/sample rate issues
Date: Sun, 21 Jul 2002 11:56:53 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207211137360.17385-100000@cmn24.stanford.edu>
References: <Pine.LNX.4.44.0207201136590.8230-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA01066
	for <alsa-devel@alsa-project.org>; Sun, 21 Jul 2002 20:57:27 +0200
In-Reply-To: <Pine.LNX.4.44.0207201136590.8230-100000@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, Paul Davis <pbd@op.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
List-Id: alsa-devel@alsa-project.org


>From earlier replies of Jaroslav and Abramo, it sounds like the API
might already be able to handle this and perhaps the problem is in the
driver, but I'll just clarify my experience with the hdsp driver.

Here is the order of parameter setting I used to follow (on pcm
device, not plug interface!):

- query supported data formats, then set format.
- query the min/max channels, then set channels
- query supported sample rates, then set sample rate
- query number of periods, then set number of periods
- query min period size, then set period size

The hdsp driver always reports 18 channels for output (10 for input).  
If I use the above sequence (setting 18 output channels), the call to
set the sample rate fails (ex. 44100 Hz).  If I re-order the sequence
so that I set the sample rate first, it works.  If I attempt to use
the 88100 and 96000 rates reported by the driver, the call to set the
sample rate fails (Paul says that those rates are not available
through the pcm interface at the moment).  Paul also says that the
maximum number of output channels at these higher rates is less (10 or
8, don't remember).  So, the idea is that if I set the sample rate to
96000, the get_channels_min() function should report this lower value.

I think there are two issues here.  First, the available parameter
settings should automatically "scale" based on the previous settings
chosen and not require a certain sequence of events to succeed.

Second, there needs to be a means for reporting inter-parameter 
dependencies.

--gary


On Sat, 20 Jul 2002, Fernando Pablo Lopez-Lezcano wrote:

>>> > > on a related note, although the above suggestion will fix this
>>> > > particular problem, it seems that it might be wise to consider adding
>>> > > a parameter order information field to the driver API, so that drivers
>>> > > can say "you have to set param P first, then param N, then param
>>> > > O". the default would obviously be "don't care", but for devices that
>>> > > lose certain capabilities when certain parameters are set, it would
>>> > > make things very much easier.
>>> > 
>>> > agreed that it's good to have such one.
>>> > but how to implement this?
>>> > from the design of hw_constraint, i don't think it's so easy...
>>> 
>>> I think that this implementation will create a big mess for the 
>>> application developers. Also, I'm not sure, if it's really needed, because 
>>> our refining code should already reduce the available configurations. 
>>> Applications should use *_near() functions in order of their priority. You 
>>> can't predict, if rate or count of channels or any other parameter is more 
>>> important for a specific application.
>>
>>[not exactly an answer but more details on what is actually happening]
>>
>>I think this is what is happening with the current driver (Gary, please
>>correct me if I'm wrong):  The application looks at the configuration
>>space and selects from it one particular sampling rate. Then it looks at
>>the channel count and sees a range of channel counts (10:18 - or some
>>numbers like that, I don't remember). The application chooses the minimum
>>channel count and the set function fails.
>>
>>IMHO at that point the configuration space should have changed the number
>>of channels available to match the sampling rate selected so that the
>>channel count as advertised is legal (ie: if the selected sampling rate is
>>one of the "single speed" rates then the range of channels should be
>>18:18, if the sampling rate is one of the "double speed" rates then the
>>range should be 10:10).
>>
>>The reverse is also true, if the application first selects number of 
>>channels the sampling rates should be constrained to the set of rates that 
>>can be supported by that number of channels. 
>>
>>If it is not possible to do this with the current api, then the next best
>>solution I can imagine is to have a switch that changes the mode of the
>>card between single and double speed (that would make the dependency
>>between sample rate and number of channels dissapear).
>>
>>-- Fernando



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
