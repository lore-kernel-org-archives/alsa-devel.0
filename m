From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: The best-supported Pro Audio device?
Date: Thu, 28 Aug 2003 10:13:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030828101338.pochini@shiny.it>
References: <200308280008.h7S08OmC025251@oud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308280008.h7S08OmC025251@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ametts2@mindspring.com
Cc: alsa-devel@lists.sourceforge.net, Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org


On 28-Aug-2003 Paul Davis wrote:
>>--*-- What is the best-supported *Pro Audio* device in terms of solid ALSA dri
>>ver support?  Not interested in Sound Blasters and chips on the motherboard --
>> something along the lines of the Echo, M-Audio, or RME products.  But the ALS
>>A drivers need to be stable -- and need to fully support the capabilities of h
>>e respective device (i.e., on-board DSP, MIDI, or whatever).
> 
> the echo drivers are extremely new, and largely untested at this
> point. they may even be incomplete.

The Echo driver is complete and tested on most supported cards. All
features are supported but MIDI and CARDBUS are untested. The driver
is based on the Windos driver code and that part is stable. The ALSA
part of the driver has some known issues and needs more testing but
it's useable (it never crashes on my box). Betatesters are welcome,
expecially for the MIDI thing because my card has no MIDI port. I
also wrote a mixer app.


Bye.
    Giuliano.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
