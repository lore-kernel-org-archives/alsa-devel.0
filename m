From: Benno Senoner <sbenno@gardena.net>
Subject: Re: The obsolence of OSS, Was: big smile
Date: Tue, 24 Feb 2004 22:54:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403BC832.4080404@gardena.net>
References: <Pine.LNX.4.58.0402241536450.1883@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from dns.gardena.net (dns.gardena.net [213.21.177.18])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id WAA09484
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2004 22:50:31 +0100
In-Reply-To: <Pine.LNX.4.58.0402241536450.1883@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

for those that are too lazy to browse the forums:

http://www.4front-tech.com/forum/viewtopic.php?t=25
-----
.... We hope you can now show your ALSA friends how much better your OSS 
drivers sound and actually tell them that OSS isn't all that "old and 
obsolete". The fact that we can do a ALSA emulation implies that OSS is 
far more advanced than ALSA people give it credit.  ...
----

far more advanced ???
Ok I'd like see Ardour runnnig with multiple 24bit cards, all the 
switches for hardware monitoring etc under OSS.

How about MIDI ? Where is OSS' midi router, is there an ossconnect 
utility ? (of course this a sarcastic comment :) )


http://www.4front-tech.com/forum/viewtopic.php?t=4
----
.... One of our main observations is that the "driver" part of ALSA is 
actually just a 1:1 clone of OSS's low level driver interface but 
everything is rewritten from scratch. We have been able to get ALSA work 
with the low level drivers of (commercial) OSS without any changes to 
OSS itself. Everything can be done in a small module that is loaded 
after executing soundon and loading ALSA's snd-pcm module. This module 
will be released under GPL during this spring.

After this it will be possible to use ALSA applications together with 
OSS. So if you are an OSS customer you don't need to leave OSS to use 
ALSA. You can use proven OSS drivers and still be able to run the few 
ALSA only applications.
....
----
The FEW ALSA only applications ??

Only a fool would write a new linux audio app that does not use ALSA, 
especially apps that need MIDI.
Ok jackd will probably become the "audio interface" of choice, but jackd 
using ALSA is more powerful than in the OSS case,
(talking of pure PCM based apps, with PCM/MIDI apps the advantage is 
even more apparent).

Not to mention that most distros once they will ship kernel 2.6 they 
will probably use ALSA as default because users
are demanding multimedia features like MIDI, support of highend cards, 
jackd support etc.
So this will slowly but surely render OSS totally obsolete. I'm sorry 
but that's the truth that you cannot escape from.
Just like Micosoft's share on the desktop will drop considerably over 
time due to linux being more efficient and cheaper :-)

cheers,
Benno
http://www.linuxsampler.org



Jaroslav Kysela wrote:

>http://www.opensound.com/cuckoo.html
>
>:-) No comment, except that some comments are really wrong.
>
>						Jaroslav
>
>-----
>Jaroslav Kysela <perex@suse.cz>
>Linux Kernel Sound Maintainer
>ALSA Project, SuSE Labs
>
>
>-------------------------------------------------------
>SF.Net is sponsored by: Speed Start Your Linux Apps Now.
>Build and deploy apps & Web services for Linux with
>a free DVD software kit from IBM. Click Now!
>http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>  
>




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
