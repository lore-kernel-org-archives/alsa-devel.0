From: Davy Durham <pubaddr@davyandbeth.com>
Subject: buffers, periods, cycles.. oh my!
Date: Sat, 28 Aug 2004 00:46:40 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41301C40.10609@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,
   Something I don't seem to grasp is exactly what the difference is 
between, and min/max ranges of, periods and buffers.  I know that a 
sound card uses a buffer to which it reads/writes data (via DMA) and 
that an interrupt can be configured to trigger n times during that 
buffer's filling (these are periods and period count?)  Well, then 
there's API functions for buffer time and sizes (I assume you can set by 
time OR by size in frames, whichever you please, but you don't need to 
set by both).

  I've looked but to no avail.. is there some higher level documentation 
that explains the big picture here?

  When I fist started using the API I had a 1/4 second latency or so for 
playback.. I tried and tried to figure out why but couldn't.  Finally I 
coped JACKs use of the lib and eliminated that. 

  Now, I'm working on capture, but I can't seem to set the buffering 
time to more than 2*8192 frames.  I'd like to set it as high as possible 
to avoid studders in the recording and would rather not buffer the data 
myself if ALSA can already do that.

Thanks,
  Davy


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
