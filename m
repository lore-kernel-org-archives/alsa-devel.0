From: Hans-Kristian Arntzen <maister@archlinux.us>
Subject: Troubles using the external SDK
Date: Thu, 18 Feb 2010 23:44:49 +0100
Message-ID: <4B7DC2E1.6050106@archlinux.us>
References: <mailman.5292.1266501879.2074.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E9AA243CF
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 23:44:54 +0100 (CET)
Received: by ewy5 with SMTP id 5so881452ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 14:44:54 -0800 (PST)
In-Reply-To: <mailman.5292.1266501879.2074.alsa-devel@alsa-project.org>
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

I am trying to make an alsa output plugin that streams the audio over 
network (something like esd, just even more simplistic) using the 
external SDK, however, I am having trouble implementing some things 
correctly it seems, and the docs weren't descriptive enough.

So far, it works quite well with music playback that doesn't really care 
about audio blocking, etc. The main problem is audio sync and blocking 
with more complex applications like MPlayer. As far as I can see in the 
MPlayer source, to retain audio sync, it uses

     snd_pcm_delay() for delay, and
     snd_pcm_status_get_avail() to figure out how much it can write 
without audio blocking.

This is fine, but how can snd_pcm_status_get_avail() get the data it 
needs from the plugins? It doesn't seem to call on any callbacks to do this.
It seems so far that snd_pcm_status_get_avail() always returns 
buffer_size, since I seem to get working audio, but the video starts to 
stutter. The stuttering goes away when I force a really small maximum 
buffer size (we're talking 512-ish bytes), but this is really, really 
bad, and doesn't work
too well on my netbook (performance/timing issues I guess). Is it 
possible to define a snd_pcm_status_get_avail() callback in the SDK in 
some way?

Anyways. I want to know how you'd do this. The OSS driver for example 
doesn't even seem to define a delay() callback, which strikes me as odd.
How can it know about the delay?

Also, I want to know the reasoning behind the pointer() function. It 
seems to be called all the time. I don't know what it really does, and 
what good it does. Is it supposed to represent where in the buffer we 
are? As in, it's supposed to stay somewhere between 0 and buffer_size? 
If so, my experience with it doesn't make sense at all. If I return that 
actual value, the programs simply stop up and loop endlessly over the 
pointer() function. The temporary "hack" (as in probably very wrong) was 
to return the total amount of data that's been sent since the start. Can 
anyone help a frustrated programmer? :P

  -- Themaister
