From: Dan Hollis <goemon@anime.net>
Subject: Re: Writing a driver for this card: your thoughts?
Date: Thu, 6 Jun 2002 12:04:32 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206061155230.15480-100000@sasami.anime.net>
References: <3CFF4177.16823.43BD597@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3CFF4177.16823.43BD597@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Eliot Blennerhassett <bigblen@xtra.co.nz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 6 Jun 2002, Eliot Blennerhassett wrote:
> (It may be possible to release the host side code, but never the DSP code 
> on the cards.)

Is it possible to bundle DSP firmware code with the driver? (If it's 
uploaded by the host, and it's not in eeprom or something). It's very hard 
to distribute drivers for firmware-based devices if we can't distribute 
the firmware required :-o

But we don't need the source code to the DSP firmware. Just tell us how to 
talk to the DSP and tell it to make noise.

> I think it would be much better if we had an ALSA driver. 

I agree :-)

> I'd like some idea how hard it would be to write an ALSA driver either as a 
> compatibility layer on top of our existing driver, or from the ground up.  I 
> realise that this is rather a broad question, so please consider this an 
> invitation to enter discussion, rather than a request for you to go off and 
> do a lot of work for me.

I think it would be better if it were a native ALSA driver talk directly 
to the DSP, eg ALSA->DSP rather than ALSA->HPI->DSP.

> Oh - what do you think of the cards' feature set?  

It looks pretty nice. But what's the price? :-o

> Some distinctive things about our cards (not all have all features) - they 
> have on board DSP.  Code is downloaded by the driver. - they have a lot of 
> on board buffer memory (hundreds of K at least) - on board DSP handles 
> decompression/compression - mixing - samplerate conversion or multiple 
> outputs at different rates - analog and digital audio I/O, balanced drivers 

What's minimum latency possible with the card?

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
