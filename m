From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 15:12:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042985569.1663.33.camel@satellite.undata.org>
References: <3E2A952E.6060305@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E2A952E.6060305@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-01-19 at 13:08, Patrick Shirkey wrote:
> Using latest cvs, I have been trying to get this device working for my 
> friend. We have had some success but it is unreliable.
> 
> We could get sound out of the lineout port after using this command
> 
>   amixer -D hw:0 cset numid=5 0,0,16384
> 

This is supposed to route the signal received on analog input 1 to
analog output 1.

> numid=5,iface=PCM,name='Mixer'
>    ; type=INTEGER,access=rw---,values=3,min=0,max=65536,step=1
>    : values=16384,0,0
> 
> Using
> 
>   	numid=5 26,26,16384
>   	numid=5 27,27,16384

The above should indeed be the correct way to route software playback
channels 1-2 to the line outs (jack's alsa_pcm:playback_1 and _2, for
example).

> or
>   	numid=5 10,10,16384 <<<--- 10 appears to be line out id
> 

What makes you say so ?

> seem to do nothing.
> 
> Sometimes after trying to use aplay and usually when trying alsaplayer 
> amixer resets the volume to 0.
> 
> Is this buggy behaviour?
> 

Maybe there is a bug in the matrix mixer. Yesterday, while working in a
complex setup, I couldn't manage to route analog inputs 3-4 to analog
outputs 3-4, it just didn't work. I had those inputs routed to the line
outs, and could hear the signal, but nothing came out of ouputs 3-4. I
had to route inputs 3-4 to outputs 5-6 to get it working. As we were
rehearsing, I had no time to further investigate. One of the problem
preventing proper understanding of the situation is that you actually
can't read from the mixer control, as cget doesn't take a parameter.

I know Paul is not fully satisfied with the way the matrix mixer is
handled right now. Maybe it could be changed so that reading the mixer
state is possible. I am currently writing a totalmix clone, and reading
the mixer state could really prove usefull. Imagine you're working with
a complex mixer setup and accidentally close the mixer app. If you
relaunch the app, it won't be able to read the mixer state back, and
will have to fall back on a preset. Your mixing work will be lost.
Other examples of the need of mixer state readout include
synchronization between different apps using the mixer. I plan to
implement a ladspa plugin to control the matrix mixer, so that you could
automate hardware mixing in ardour, for example. The plugin and the
standalone mixer app should stay synced.

Thomas




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
