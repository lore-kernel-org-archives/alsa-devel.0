From: Jeremy Hall <jhall@maoz.com>
Subject: Re: Want your Help
Date: Mon, 28 Apr 2003 08:35:47 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304281235.h3SCZl7g031386@sith.maoz.com>
References: <20030428120722.15330.qmail@webmail17.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030428120722.15330.qmail@webmail17.rediffmail.com> from mahendra
  sp at "Apr 28, 2003 12:07:22 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mahendra sp <mahendra_sp@rediffmail.com>
Cc: jhall@maoz.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

oh, well ecasound has FDX support.  I'm not sure what the state of alsa in 
it is, it seems to work now, it was broken for a while, but recent CVS 
seems to fix that.

I have not tried running jack (jackit.sf.net) with an es1938, that should 
be a fun adventure

You can test it (after compiling jack) by starting jack and then

jack_connect alsa_pcm:capture_1 alsa_pcm:playback_1
jack_connect alsa_pcm:capture_2 alsa_pcm:playback_2

WARNING use headphones for this test, otherwise you will get nasty 
feedback.  Connect a microphone, set the appropriate mixer settings, and 
with a bit of luck you should hear yourself in your headphones.

Last time I looked, both ecasound and jack were well commented, at least 
they seemed to be at the time I read them, and easily followable.

Jack tries to run the device synchronously, using a buffer split in half, 
the driver works on one half, the application the other.  It wants to keep 
the playback and capture streams synced.

Ecasound ran the playback and capture streams independently (I think) and 
somehow synced it in the application.  I think the comments in 
audioio_alsa6.cpp are better than the ones in jack, but I haven't looked 
at either in a long time.

oh and jack is written in c, ecasound in cpp, but the alsa-lib layer is in 
c.

Jack uses mmap access because it prefers to do its own reading and writing 
rather than alsalib.

Ecasound doesn't use mmap access, relying on alsa-lib read and write 
calls.

Hey Abramo, do you remember all that fun we had a few years ago 
surrounding this card and the "off-by-1" feature of the chip? If memory 
serves, part of the solution involved forbidding this card from using mmap 
access.  I'm looking in the sound for 2.5.68 and see that it is permitted.  
Does this mean the problem has possibly reappeared, or was it addressed?

anyway, hope this helps.

ecasound can be found at www.eca.cx, jack at jackit.sourceforge.net

_J


In the new year, mahendra  sp wrote:
> hi,
> 
>   Thanks for replying. I am a student who is doing a project on 
> linux.
> 
>    I have installed ALSA ESS 1938 driver as I have ESS 1938 sound 
> card driver. My main aim for going to ALSA driver is it supports 
> full dulex . My project consists of implementing the full duplex 
> in one of my modules. So i want to write a "C LANGUAGE APPLICATON 
> "  in which I want to  talk and also listen simultaneously. But 
> the problem is I  am not getting the documentation for Driver APIs 
> so that i can use in my application. So i requested for Driver API   
> documentation.Do you have any written  application code in c 
> language for Full Duplex ? If it is please send it to me   so that 
> i can readily use it and also enhance for my requirement. If u 
> have document for APIs please send it to me . I wanmt to know what 
> steps should bne followed for opening the device and congfiguring 
> it for full dulex operation.Please help me in this regard.
> 
> thanks for the reply,
> warm regards,
> mahendra.
> 
> 
> 
> 
> 
> 
> 
> 
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
