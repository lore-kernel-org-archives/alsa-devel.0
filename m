From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: .asoundrc file
Date: Fri, 16 Aug 2002 20:32:15 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5CE2BF.2070304@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>>What is the purpose of the ctl.rme9652 declaration? My plugin devices
>>>seem to work without it.
>>>
>>
>>It is a configuration for the onboard mixer. Very little is known about 
>>why we use it. Some programs (JACK) won't work without it.
> 
> 
> not really.
> 
> the control device for a card is the way that programs modify various,
> suprise, "controls" on the card. for many cards, this includes the
> mixer, though in the example above, the rme9652 has no mixer. it does
> still have a number of controls, however, and JACK needs to be able to
> access them. Examples include the digital i/o sync indicators, sample
> clock source switch and so on.
> 

Great that's a nice simple explanation. I have added it to the asoundrc 
page.

> as for why the name itself is required: JACK was written to open both
> the PCM and control devices using a single name. I felt this was nicer
> and less confusing than asking the user to specify two different
> names.
> 

Someone might want to submit this as a note too.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
