From: Christoph Haderer <chris_web@gmx.at>
Subject: Re: Re: [PATCH] aureon.c - hpamp, adc/dac mute
Date: Sat, 15 May 2004 12:07:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A5EBDD.7080409@gmx.at>
References: <40A4C012.8080004@gmx.at> <s5hn04bma09.wl@alsa2.suse.de> <40A53D8C.9030201@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40A53D8C.9030201@aei.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Apostolos Dimitromanolakis <apostolos@aei.ca>
List-Id: alsa-devel@alsa-project.org

Apostolos Dimitromanolakis wrote:
> I also have a dump from the communication of the windows driver with the 
> AC97 codec of the card which is used for mixing the 4 internal 
> connectors (the communication is through a XIlinx programmable device 
> and so it was difficult to implement).  I believe that the dump can be 
> used to add the support of the AC97 to both Prodigy and Aureon. I will 
> do it sometime when I find time but if anyone is interested I can send 
> the dump.
It would be really nice if support for the AC97 codec could be added. 
(I'm afraid I wouldn't be much of a help in this field as my current 
programming experience is rather low)

 > ... then we can  merge the two drivers into
 > one since they are almost identical (prodigy.c and aureon.c).
I agree - a merge of prodigy.c and aureon.c would be the right thing 
because as far as i know, the only difference (apart from the type of 
the digital io connection) is the content of the eeprom (and maybe the 
frequency of the crystal).

By the way, was anyone using an Aureon or Prodigy able to get a signal 
from one of the digital inputs? Currently the command 0x0200 from 
cs_inits[] sets the CS8415A's input multiplexer to RXP0 which is, at 
least on my Aureon, connected to the cd-spdif input. But unfortunately 
I'm neither able to record the signal applied to this input via the 
spdif device nor is it possible to monitor it by setting the "H/W 
Playback Route" control to "IEC 958 In". Any feedback/solutions/hints 
would be appreciated.

Regards,
Christoph Haderer


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
