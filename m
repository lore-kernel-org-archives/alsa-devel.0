From: Dennis Thompson <yknot@cipic.ucdavis.edu>
Subject: surround sound project.  looking for suggestions
Date: Tue, 29 Oct 2002 10:24:24 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4.3.1.2.20021029093337.0143aee0@phosphor.cipic.ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I am working on a surround sound project.  When finished this code will update a virtual acoustic environment based on a persons head motion.  I am hoping for some hints on solving a problem I have.  Note!  My background is in signal processing, not software/hardware interfacing. So I am still clueless on the process of moving data between user memory and the sound card.

My problem:

The current code can process the audio far faster then the sound card can except/output it. Therefore, to reduce the latency between head motion and changes in the sound output, I will need to keep the amount of data in the output buffer to a minimum.  For the sake of discussion say about a 1024 frames (the exact amount is flexible)  Currently I try to control the flow by pausing the output loop. My problem is that I keep getting buffer underruns, even when I am writing another 1024 frames of data to the sound card before 1024 frames have had time to play (which does not make any sense to me). 

What I want to do is poll the data buffer so that I can determine the amount of data remaining in the buffer.  So far I have only been able to determine (by polling) that the buffer is willing to accept new data.  

So my question. Does anyone have a idea on how I can determine the percentage of fill in the output buffer?  

I am also open to any ideas on keeping the amount of data queued for output to a minimum, in a controlled fashion.


Thank You

  Dennis Thompson

*******************************************************************
  Center for Image Processing and Integrated Computing (CIPIC) 
  Interface Laboratory
  University of California, Davis CA 95616
  Phone	: (530) 754-9861
  Fax		: (530) 752-8894
  e-mail	: mailto:dmthompson@ucdavis.edu
  URL		: http://interface.cipic.ucdavis.edu/
*******************************************************************



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
