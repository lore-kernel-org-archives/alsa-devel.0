From: Pierre-Laurent CHAMBERT <pilo.c@wanadoo.fr>
Subject: question about minimum latency. (jack) how to calculate it?
Date: Mon, 22 Nov 2004 07:15:02 +0100
Message-ID: <200411220715.03369.pilo.c@wanadoo.fr>
Reply-To: pilo.c@wanadoo.fr
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi!

I would like to know how I can improve latency on digi32/8 driver.
The card has got a buffer of 128Ko, and block size per interrupt is 8Ko (so it 
makes 16 interrupt for the whole buffer). When I start jack I can use only 
setup 256 frame/periods (32bits, 8channel in adat mode) and 16 periods/
buffer. So this mean I can only have 80ms of latency?!? It's not possible to 
use less than 16 periods? 
I mean, a sound is recorded, the card send an interupt so the sound just 
recorded can not be read in the memory, and write back in memory 2 interrupts 
after? 
Maybe I miss something here, I already try to change number of periods/buffer 
in the driver, but of course with no luck.
So if the buffer size (128Ko here) and block size (8Ko) are always the same it 
cannot get a lower latency?

Thank you!

Pilo




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
