From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: hdsp multiface pci.
Date: Mon, 20 Jan 2003 00:29:35 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E2AC45F.3070601@boosthardware.com>
References: <3E2A952E.6060305@boosthardware.com> <1042985569.1663.33.camel@satellite.undata.org>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thomas Charbonnel wrote:
> On Sun, 2003-01-19 at 13:08, Patrick Shirkey wrote:
> 
>>Using latest cvs, I have been trying to get this device working for my 
>>friend. We have had some success but it is unreliable.
>>
>>We could get sound out of the lineout port after using this command
>>
>>  amixer -D hw:0 cset numid=5 0,0,16384
>>
> 
> 
> This is supposed to route the signal received on analog input 1 to
> analog output 1.
> 
> 
>>numid=5,iface=PCM,name='Mixer'
>>   ; type=INTEGER,access=rw---,values=3,min=0,max=65536,step=1
>>   : values=16384,0,0
>>
>>Using
>>
>>  	numid=5 26,26,16384
>>  	numid=5 27,27,16384
> 
> 
> The above should indeed be the correct way to route software playback
> channels 1-2 to the line outs (jack's alsa_pcm:playback_1 and _2, for
> example).
> 

Sorry I'm not fully grasping this. Why are 26 and 27 directly related to 
alsa_pcm:playback_1 and _2?

I thought from reading the notes on the hdsp page that pcm1 and pcm2 
would be numbers 0 and 1 not 26 and 27.

eg.
======
Since the Multiface only have 18 i/o channels, the channel mapping in
the matrix mixer is different from the Digiface when operating at 48kHz
or lower.

input_source: 0-7 (analog), 16-23 (adat), 24-25 (spdif), 26-51 (playback)
output_source: 0-7 (analog), 16-23 (adat) 24-25 (spdif), 26-27 (line out)
======

See how it says 0-7 (analog)?	

I haven't found an explanation for the following in the docs describing 
how to use the amixer app so could you please clarify this for me?

What is this line saying?

   	numid=5 26,26,16384

something like:

connect 26 to 5 with a volume of 16384


> 
>>or
>>  	numid=5 10,10,16384 <<<--- 10 appears to be line out id
>>
> 
> 
> What makes you say so ?
> 


These are the id's in question:

numid=5,iface=PCM,name='Mixer'
   ; type=INTEGER,access=rw---,values=3,min=0,max=65536,step=1
   : values=16384,0,0

numid=10,iface=PCM,name='Line Out'
   ; type=BOOLEAN,access=rw---,values=1
   : values=on

numid=26,iface=PCM,name='Playback Peak',index=3
   ; type=INTEGER,access=r----,values=2,min=0,max=0,step=0
   : values=0,0

numid=27,iface=PCM,name='Playback RMS',index=3
   ; type=INTEGER64,access=r----,values=1,min=0,max=0,step=0
   : values=0



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
