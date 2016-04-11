From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] amidi: ignore not only Active
	Sensing	but all System Real-Time messages
Date: Mon, 11 Apr 2016 16:13:08 +0200
Message-ID: <570BB0F4.2020504@ladisch.de>
References: <570AA980.3070802@ladisch.de>
 <alpine.DEB.2.02.1604110858100.9999@lnxricardw1.se.axis.com>
 <570BA6B1.8060101@ladisch.de>
 <alpine.DEB.2.02.1604111535500.9999@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 645EF2604D6
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 16:13:13 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1604111535500.9999@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Martin Tarenskeen <m.tarenskeen@zonnet.nl>
List-Id: alsa-devel@alsa-project.org

Ricard Wanderlof wrote:
> On Mon, 11 Apr 2016, Clemens Ladisch wrote:
>> Ricard Wanderlof wrote:
>>> I would argue that it would be better to have both options, somehow. I.e.
>>> active sensing is mostly a nuisance, but I can imagine occasions
>>> (analyzing the output from a sequencer perhaps) where one would want to
>>> keep the rest of the real time messages.
>>
>> I can imagine this too, and even more complex filters.
>>
>> But the amidi tool is designed to be simple, and works on the lowest
>> level, with raw MIDI bytes.  This makes it appropriate to handle SysEx
>> stuff and to debug low-level hardware problems, but when you care about
>> the semantics of the messages, you should use a higher-level tool, such
>> as aseqdump.
>>
>> Filtering out clock messages serves an actual need.  But I am not
>> willing to add complexity for a problem that is, at the moment, nothing
>> but a figment of our imaginations.
>
> My argument is really that currently amidi has an option for filtering out
> active sensing, which has probably been added as it serves a useful
> purpose in its own right. The patch replaces that filter with one that
> filters out everything from F8 (clock) and up

I consider this change a bug fix; I just forgot about clock messages
when I originally impemented the filter.

> I think it would be better to keep the existing option, and add a new
> one, rather than to essentially change the meaning of the existing
> option.

That would be a new feature.


Regards,
Clemens
