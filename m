From: Caleb Crome <alsa@crome.org>
Subject: How do create a dummy device for recording audio?  Does it exist
 already?
Date: Thu, 22 Apr 2004 06:44:43 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4087CC4B.80402@crome.org>
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

Hello,
      I've looked through the archives and I couldn't find what I'm 
looking for, so here goes:

I'd like to create a dummy audio device that can record the PCM data 
written to it into a file.  So, the dummy device would appear as a sound 
card to the audio program (Real Player for example), and start dumping 
audio into a file, or maybe it would create another device that could be 
read simply by 'dd' or some custom command.  Then I'd pipe the data into 
an MP3 or OGG encoder, split into 1/2 hour chunks, or whatever length 
chunks I like.

Once the system is running, I'd do something like this:

1) Open my Player, tune to my favorite station. Use my new device for 
audio output.
2) do something like:  dd if=/dev/audiocapturepcmout count=xxx | lame 
--output myfile.mp3

What would it take to make a alsa drive that captures the PCM data into 
a file?
How about one that captures it, then pumps it into a new /dev/ device 
for reading?

Thanks,
  -Caleb



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
