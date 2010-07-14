From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: Re: Which project to choose?
Date: Wed, 14 Jul 2010 21:45:21 +0200
Message-ID: <4C3E13D1.1070908@epost.diwic.se>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTildhplqQxzk7mBMc5IW_3bwAVDDrRe5UDpJXIS6@mail.gmail.com>
	<4C3DD271.6040003@epost.diwic.se>
	<alpine.LNX.2.00.1007141723070.16744@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp02.sth.basefarm.net (ch-smtp02.sth.basefarm.net
	[80.76.149.213])
	by alsa0.perex.cz (Postfix) with ESMTP id E116C1037F2
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 21:45:27 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1007141723070.16744@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010-07-14 17:25, Jaroslav Kysela skrev:
> On Wed, 14 Jul 2010, David Henningsson wrote:
> 
>> 2010-07-14 13:13, Raymond Yau skrev:
>>
>>> localhost pulseaudio[24553]: alsa-util.c:   appl_ptr     : 735801008
>>> localhost pulseaudio[24553]: alsa-util.c:   hw_ptr       : 735846184
>>>
>>> This is underrun as you can see appl_ptr is behing hw_ptr
>>
>> Ehm, isn't that a ring buffer? I e, there is nothing wrong with appl_ptr
>> being less than hw_ptr.
> 
> For playback, if appl_ptr is less than hw_ptr, it's underrun situation
> (application didn't feed samples in time to the driver's ring buffer).
> 
> Note that pointers in ALSA are in range 0..boundary not
> 0..ring_buffer_size (boundary is near LONG_MAX value) - it's design to
> detect such situations (underrun, overrun).

Okay, thanks for the clarification. But LONG_MAX (as in 2^31) would
still wrap around every thirteen hours (at 44100 Hz), so are we having
bugs, such as e g failure to detect underruns, at those occasions?

// David
