From: Ludwig Schwardt <schwardt@sun.ac.za>
Subject: Multiple Delta 1010LT woes: verdict
Date: Sun, 29 Feb 2004 14:42:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4041DE4D.70504@sun.ac.za>
References: <4036521E.9070407@sun.ac.za> <403716BA.7010505@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <403716BA.7010505@comcast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Doug <nostar@comcast.net>
List-Id: alsa-devel@alsa-project.org

Hi,

My quest for syncing two Delta 1010LTs under ALSA has gone on hold for 
the time being... No success so far. Both cards work fine separately. 
The main problem is that I cannot get either a word clock output or 
SPDIF output going. Both these digital outputs remained dead no matter 
what I did. I'm especially curious whether the word clock output has to 
be enabled in some way by the driver. It seems that you have to enable 
it under Windows, at least.

Luckily for me, my application didn't really depend on synchronization - 
I only needed it to get JACK to record from all my soundcards at once. 
After a switch to PortAudio I was able to simultaneously record 
(unsynced) sound from all the soundcards. Both great APIs, by the way.

I would still be interested in any suggestions to get syncing to work, 
as I have a few Delta 1010LTs left on which to experiment and I am a 
willing guinea pig :->

Ludwig



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
