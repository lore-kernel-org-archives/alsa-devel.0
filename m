From: Martin Tarenskeen <m.tarenskeen@zonnet.nl>
Subject: Re: [PATCH 1/2] amidi: ignore not only Active Sensing
 but all System Real-Time messages
Date: Mon, 11 Apr 2016 13:17:54 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1604111304310.4695@localhost.localdomain>
References: <570AA980.3070802@ladisch.de>
 <alpine.DEB.2.02.1604110858100.9999@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpsmtpb-ews09.kpnxchange.com (cpsmtpb-ews09.kpnxchange.com
 [213.75.39.14]) by alsa0.perex.cz (Postfix) with ESMTP id 828FB26055E
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 13:17:58 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel mailinglist <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org



On Mon, 11 Apr 2016, Ricard Wanderlof wrote:

>
> On Sun, 10 Apr 2016, Clemens Ladisch wrote:
>
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

Hi,

I can see your point. I have been thinking about that but my coding skills 
are somewhat limited. I can image keeping the -a (--allow-realtime) option 
the way it is and adding a new option -c (--allow-clock) to allow 
receiving of 0xf8 midiclock messages. At the same time 0xf8 should be 
filtered by default, just like 0xfe. The other realtime messages are much 
less a problem because they are not sent continuously (e.g. start and 
stop)

What do you think Clemens Ladich, is this doable?

-- 

Martin Tarenskeen
