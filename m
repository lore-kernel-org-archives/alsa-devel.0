From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: alsa driver data rates
Date: Thu, 15 Apr 2004 12:43:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407E7578.3050203@superbug.demon.co.uk>
References: <20040415112709.13194.qmail@web25103.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040415112709.13194.qmail@web25103.mail.ukl.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Furey <brianmfurey@yahoo.co.uk>
Cc: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Brian Furey wrote:
> Hi James,
> Im asking you becuae looking thru the archives you asked a similar 
> question a long time ago.
> 
>  i'm using an open source VoIP application with the
> alsa driver. My card is the onboard intel8x0.
>    My problem is figuring out the patterns I am
> getting with the alsa driver when transmitting
> packets.
> For instance when I use the GSM codec with a packets
> size of 80 msecs and 132 bytes, packets are
> transmitted at alternate intervals of 64/96 msecs.
> When i use G.711 packets of 240 bytes are transmitted
> every 32 msecs with an extra packet every 15 pkts.
> With G.711 it is obvious that 256 bytes are added to driver sending 
> buffer every 32 msecs.However this does not match for GSM because it 
> needs only 132 bytes every 64/96 msecs.
> Can the driver change the amount of data it gets from the soundcard to 
> suit the codec?
> Help appreciated,
> 
> Brian.
> 
> 

Can you point me to a url for the source?
I think I will understand you a bit better if I see the source code.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
