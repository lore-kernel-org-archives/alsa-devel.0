From: Tim Hollingsworth <tim@hollingsworth.com.au>
Subject: period size
Date: Tue, 30 Mar 2004 22:45:42 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <EB5AA0AA-8258-11D8-88CD-000A95AB8A40@hollingsworth.com.au>
References: <Pine.HPX.4.33n.0403301505490.25443-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403301505490.25443-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I am trying to write a pcm app which receives sound over the network 
and outputs it through the speakers.  The network protocol is udp.  
 From what I can tell, each packet is a single period with interleaved 
channels.   My problem is that the period size appears to be below the 
minimum that my hardware will go.  For example:

rate: 			48000 Hz
channels:		2
packet size:	512 bytes
sample size:	16 bit

ok so far... (correct me if I'm wrong)

period size 	= (packet size * 8) / (channels * sample size)
			=  (512 * 8) / (16 * 2)
			= 128

buffer size	= (whatever i like...? latency/network stability...?)

When I try to set the period size exactly I get an error.  If I set the 
period size near I get 192.  How do I make this work?  Should I 
reconfigure the network sound source?  Do I put the packets together 
into larger periods?  Can alsa do this for me?

cheers
Tim



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
