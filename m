From: Steven Feil <sfeil@io.com>
Subject: Best value for periods and periodsize
Date: Wed, 9 Apr 2003 01:02:46 -0500 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304090059300.10725-100000@hagbard.io.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

I'm trying to find out what are the "best" values for the parameters
periods and periodsize, or if I can just avoid setting them all
together and let the ALSA driver/libs handle it.  From reading the
ALSA documentation, I can see that the parameters periods and
periodsize have something to do with the ring buffer used beneath the
user level. What I do not understand is, should these low level
buffers "line up" or avoid "lining up" with user level reads.

I will describe an outline of my PCM reading program, so that you can
get an idea of what would be the best parameters for periods and
periodsize.

As it turns out my program uses it's own ring buffer to hold incoming
sounds from the PCM in a state of limbo. My ring buffer is actually a
series of frames arranged into a ring. Each frame is treated as an
indivisible unit. The size of the frames is determined by the variable
Samples_Per_Frame_Per_Channel. This variable is usually a 2^x number
(because FFT's like 2^x numbers ), with 512 or 1024 a typical
value. Theoretically Total_Frames_Used is only limited by memory,
however, the largest practical value would seem to be a few minutes
worth of sound. Most testing is done with 5 to 15 seconds worth of
sound. My program is multi-threaded, with a thread dedicated to taking
sound from the PCM and storing it in the aforementioned ring buffer.
Other task are handled by different threads

Under these circumstances, what do you think would be the best way to
set periods and periodsize?

=======================================================================
 Steven Feil              | Gram-pa, back at the turn of the      .~.  
 Programmer/Developer     | century, why did people use an        /V\  
 sfeil@io.com             | operating system, when they were not // \\ 
                          | allowed to see the source code?      (X_X) 
=======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
