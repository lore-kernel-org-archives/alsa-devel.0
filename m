From: David McNab <rebirth@orcon.net.nz>
Subject: Re: Question - scratchy audio
Date: Thu, 13 May 2004 00:14:35 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A2152B.6010904@orcon.net.nz>
References: <40A20137.409@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40A20137.409@orcon.net.nz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David McNab wrote:
> However, I've got a problem, where I'm getting intermittent 
> 'scratch'/'pop' noises (sounds a bit like a dodgy jack or lead).
> 
> Any ideas what could be causing this?

For the benefit of others who may be new to alsa seq api, I'll post what 
I found out.

It seems that if a client process is spiking the CPU, even for short 
bursts, it will impact one or more other audio progs. Not sure whether 
the scratchiness is caused by ALSA, fluidsynth, or something else 
getting momentarily cpu-starved.

Solution - I optimised my (python) client app, psyco'ed the scheduler 
loop, and shimmed to C functions which create and dispatch the events.

It turned out that my python code was doing a lot of unnecessary object 
creation and dict manipulation, which was causing CPU spikes. Seems that 
even a spike of a couple of ms can impact the audio.

Result - instead of scratchy audio, with jerky off-time notes sounding 
like a garage band with a 3-day hangover, the music is now coming 
through clear and rhythmically tight.

Seems I won't need to bother battling with alsa queues and scheduling 
any more :))

Cheers
David



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
