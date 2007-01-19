From: Chase Douglas <cndougla@purdue.edu>
Subject: Having issues with an I2S driver
Date: Thu, 18 Jan 2007 20:40:04 -0500
Message-ID: <AAFF1BF1-5C84-44DD-8545-64007D2242D4@purdue.edu>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm trying to write an alsa driver for cirrus logic's ep93xx series  
of chips. I based my driver off of the AC'97 driver for the same  
chips. The AC'97 driver used a compact mode where the 16 bit samples  
from alsa are pushed to AC'97 dma channel directly which is read by  
the cirrus chip as two 16 bit samples in a 32 bit word.  
Unfortunately, the I2S peripheral doesn't have a compact mode. When I  
send 16 bit samples to it, I have to take the stream of 16 bit  
samples and expand them to 32 bit words for every sample.

I believe I have the playback copy function implemented correctly to  
do this, but I have no clue how to change the other pcm functions to  
support this. What sort of configuration changes need to be made so  
that everything works correctly? I tried doubling the period_bytes  
size when allocating dma buffers and returning the correct number of  
frames in the pointer function by halving the number of transferred  
bytes before doing the conversion. The result is a driver that seems  
to play at the correct speed (before it was playing twice as fast),  
but it cycles playing for about 1/4 second and then silence for 1/4  
second. If anyone cares to see any code I would be happy to oblige.

Thanks a lot for your help,
Chase Douglas

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
