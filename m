From: "Eliot Blennerhassett" <bigblen@xtra.co.nz>
Subject: Re: Writing a driver for this card: your thoughts?
Date: Fri, 7 Jun 2002 13:00:05 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D00AE55.11120.9CD4ED3@localhost>
References: <3CFF4177.16823.43BD597@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0206061155230.15480-100000@sasami.anime.net>
Content-description: Mail message body
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Dan Hollis <goemon@anime.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 6 Jun 2002 at 12:04, Dan Hollis wrote:

> Is it possible to bundle DSP firmware code with the driver? (If it's 
> uploaded by the host, and it's not in eeprom or something). It's very hard 
> to distribute drivers for firmware-based devices if we can't distribute 
> the firmware required :-o

Yes.  The firmware image is currently loaded from a binary data file which is 
distributed as part of our current drivers.

> But we don't need the source code to the DSP firmware. Just tell us how to 
> talk to the DSP and tell it to make noise.

I'll work out what info/code we would need to release, and see if this is 
something management would agree to.
  
> It looks pretty nice. But what's the price? :-o

Models range from $995 to $3495
:-O  no, they aren't competition for a soundblaster...
 
> What's minimum latency possible with the card?

Historically our cards have very large buffers that contain seconds of audio, so 
that they can keep playing flawlessly even if the CPU or network gets bogged 
down.  Whether this is used or not is up to the application though.

Low latency has not been a design goal.  I would say the latency is between 
about 3000 to 5000 samples depending on processing details.

> 
> -Dan


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
