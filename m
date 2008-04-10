From: Pieter Palmers <pieterp@joow.be>
Subject: Re: Monotonic timestamps
Date: Thu, 10 Apr 2008 19:20:08 +0200
Message-ID: <47FE4C48.6030308@joow.be>
References: <20080409213602.GA2589@tango.0pointer.de>
	<47FDBBC1.1030500@joow.be>
	<20080410141513.GA5852@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhineheart.priorweb.be (rhineheart.priorweb.be
	[213.193.229.215])
	by alsa0.perex.cz (Postfix) with SMTP id D755024550
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 19:20:18 +0200 (CEST)
Received: from [10.0.0.21] (unknown [62.235.139.108])
	by rhineheart.priorweb.be (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 19:20:12 +0200 (CEST)
In-Reply-To: <20080410141513.GA5852@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote:
> On Thu, 10.04.08 09:03, Pieter Palmers (pieterp@joow.be) wrote:
> 
>>> I find it very strange that ALSA just switches to monotonic timestamps
>>> just like that, anyway. Programs written for wallclack timestamps will
>>> break if they run on a system where ALSA uses monotonic timestamps!
>>>
>>> There's a function missing that enables monotonic timestamps
>>> explicitly, or at least one that can be used to query if they are
>>> monotonic or not.
>> The clean solution would (IMHO) be to have ALSA provide a function to 
>> obtain 'current time', thereby making the timestamp system 
>> self-contained. Maybe it already does...
> 
> This wouldn't help much since timestamps might also come from other
> libraries. i.e. being able to relate timestamps from ALSA with
> timestamps from the application itself is not enough. They also need
> to be relatable to timestamps from other code, which might not
> necessarily be linked against ALSA.
> 
> i.e. think of gstreamer that uses timestamps attached to each video
> frame. Do you really expect gst to move their timestamp source over to
> ALSA just because one of the plugins for gst supports ALSA?

Let me put it another way: if some library provides timestamps, it 
should also provide a mechanism to obtain the current time. That way the 
  application is able to relate the timestamps to whatever clock it wants.

On the other hand, the "mechanism to obtain the current time" could 
equally well be "use CLOCK_MONOTONIC". In that sense your original post 
points out the issue, since obviously ALSA doesn't provide this info.

Never mind the noise.

Pieter
