From: Alberto.Pareto@seleniacomms.com
Subject: Capturing audio and 1010lt
Date: Wed, 26 Jan 2005 11:33:39 +0100
Message-ID: <OFDAEF9790.06BB015E-ONC1256F95.003851E8@MarconiSelenia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Hi, I'm starting using a delta 1010lt (my first audio device). I installed
ALSA on a RedHat Linux and at the moment I'm able to capture/play.

   ALSA version:
   Advanced Linux Sound Architecture Driver Version 1.0.8.
   Compiled on Jan 19 2005 for kernel 2.4.21-4.EL with versioned symbols.

I've to capture simultaneously 8 different input sources and to record
separate audio in different
files (one file for each input) , but I only see one capture device:

   cat /proc/asound/devices:

           8: [0- 0]: raw midi
          16: [0- 0]: digital audio playback
          24: [0- 0]: digital audio capture
           0: [0- 0]: ctl
           1:       : sequencer
       33:       : timer

At the moment I'm using 'arecord', 'aplay' and 'alsamixer'. My .asoundrc
is empty (I'd need it?). I use the default device or 'hw:0,0' (otherwise I
get errors).

What I'm supposed to do to get 8 different captures? Maybe this can be done
only through the API and not with the standard tool installed with ALSA
(like arecord and aplay)?
Is this a limitation of the board?

Thanks for advices!!!
Alberto



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
