From: Eric Angel <ejangel@ucdavis.edu>
Subject: polling question
Date: Thu, 24 Oct 2002 10:39:09 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210241039.09754.ejangel@ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
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

Hello,
   I am trying to write a program using alsa.  I want to run the pcm.m example 
that is posted at: 
http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html
but when I try to compile it, I get lots of errors. The errors indicate that 
the code is trying to use functions incorrectly. 

It seems that the documentation and examples at alsa-project.org do not match 
the current function prototypes. Do you have any suggestions on how I can 
find current documentation to help me use alsa in my program?

Here is an overview of what I need to do with alsa: 
--------------------------------------------------------------------------------------
There is a while loop that processes 1 block of 1024 frames (stereo) and sends 
it to the soundcard each time through the loop.  I want the program to send 
blocks out in real-time: i.e. blocks should be sent out every (1024 frames / 
44,100 frames per sec) = 23 msec.  I have working code right now, but it runs 
way too fast. It will process and send 1 minute of sound to the soundcard in 
a few seconds. I think I need to use the polling option, but I am having 
difficulties understanding how to use it.

(I am using release candidate 3 of alsa)

  Thank you very much,
  Eric


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
