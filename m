From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 17:07:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042992464.1649.55.camel@satellite.undata.org>
References: <3E2A952E.6060305@boosthardware.com>
	 <1042985569.1663.33.camel@satellite.undata.org>
	 <3E2AC45F.3070601@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E2AC45F.3070601@boosthardware.com>
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

On Sun, 2003-01-19 at 16:29, Patrick Shirkey wrote:

> Sorry I'm not fully grasping this. Why are 26 and 27 directly related to 
> alsa_pcm:playback_1 and _2?
> 
> I thought from reading the notes on the hdsp page that pcm1 and pcm2 
> would be numbers 0 and 1 not 26 and 27.
> 
> eg.
> ======
> Since the Multiface only have 18 i/o channels, the channel mapping in
> the matrix mixer is different from the Digiface when operating at 48kHz
> or lower.
> 
> input_source: 0-7 (analog), 16-23 (adat), 24-25 (spdif), 26-51 (playback)
> output_source: 0-7 (analog), 16-23 (adat) 24-25 (spdif), 26-27 (line out)
> ======
> 
> See how it says 0-7 (analog)?	
> 
> I haven't found an explanation for the following in the docs describing 
> how to use the amixer app so could you please clarify this for me?
> 
> What is this line saying?
> 
>    	numid=5 26,26,16384
> 
> something like:
> 
> connect 26 to 5 with a volume of 16384
> 
> 

You have to understand that software outputs are not directly related to
physical outputs. On simpler hardware, software and physical outputs can
be considered the same. On the hdsp system, thanks to the internal
matrix mixer, software outputs are totally abstracted from physical
ones. On the multiface you have 18 software outputs, each of wich can be
independently routed to any of the 18 physical outputs. For convenience,
the hdsp linux driver's default behaviour is to have a 1:1 routing
policy: each software output is by default routed to to corresponding
hardware output.
So the "numid=5 26,26,16384" line says:
connect software output 1 (called "playback" in the above table) to line
out left, as the syntax of the call is input_source,output_source,value.

> > 
> >>or
> >>  	numid=5 10,10,16384 <<<--- 10 appears to be line out id
> >>
> > 
> > 
> > What makes you say so ?
> > 

> 
> These are the id's in question:
> 
> numid=5,iface=PCM,name='Mixer'
>    ; type=INTEGER,access=rw---,values=3,min=0,max=65536,step=1
>    : values=16384,0,0
> 
> numid=10,iface=PCM,name='Line Out'
>    ; type=BOOLEAN,access=rw---,values=1
>    : values=on
> 
> numid=26,iface=PCM,name='Playback Peak',index=3
>    ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
>    : values=0,0
> 
> numid=27,iface=PCM,name='Playback RMS',index=3
>    ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
>    : values=0
> 
> 

Here it looks like you're mixing up the amixer numid parameter number
with the hdsp internal channel numbers.
Numid 5 is the actual alsa matrix mixer control. Numid 10 is the global
line out switch. Numid 26 and 27 are read only, and correspond to the
internal peak and rms calculation the card does to provide a 0% CPU
metering solution (to be used in the forthcoming HDSPMixer totalmix
clone !...)

I hope this makes things clearer.

Thomas




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
