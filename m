From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] amidi: ignore not only Active
	Sensing	but all System Real-Time messages
Date: Mon, 11 Apr 2016 15:29:21 +0200
Message-ID: <570BA6B1.8060101@ladisch.de>
References: <570AA980.3070802@ladisch.de>
 <alpine.DEB.2.02.1604110858100.9999@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9479E26527F
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 15:29:24 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1604110858100.9999@lnxricardw1.se.axis.com>
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
> On Sun, 10 Apr 2016, Clemens Ladisch wrote:
>> By default, amidi ignores Active Sensing messages because they are sent
>> by many devices in the background and would only interfere with the
>> actual messages that amidi is supposed to capture.  However, there are
>> also devices that send Clock messages with the same problem, so it is
>> a better idea to filter out all System Real-Time messages.
>
> I would argue that it would be better to have both options, somehow. I.e.
> active sensing is mostly a nuisance, but I can imagine occasions
> (analyzing the output from a sequencer perhaps) where one would want to
> keep the rest of the real time messages.

I can imagine this too, and even more complex filters.

But the amidi tool is designed to be simple, and works on the lowest
level, with raw MIDI bytes.  This makes it appropriate to handle SysEx
stuff and to debug low-level hardware problems, but when you care about
the semantics of the messages, you should use a higher-level tool, such
as aseqdump.

Filtering out clock messages serves an actual need.  But I am not
willing to add complexity for a problem that is, at the moment, nothing
but a figment of our imaginations.


Regards,
Clemens
