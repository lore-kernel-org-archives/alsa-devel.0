From: Nathaniel Gray <n8gray@caltech.edu>
Subject: aplay failures
Date: Fri, 9 May 2003 18:19:27 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305091819.27428.n8gray@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

This is for aplay 0.9.3 with the intel8x0 driver from 0.9.3a package.

I get failures when trying to play certain samples with aplay.  They 
are all low bitrate unsigned 8-bit mono samples from the KDE 
distribution (you can find them in the $KDEDIR/share/sounds directory).  

[n8gray@golux sounds]$ aplay KDE_Beep_Bottles.wav
Playing WAVE 'KDE_Beep_Bottles.wav' : Unsigned 8 bit, Rate 11127 Hz, Mono
aplay: set_params:847: Can't use period equal to buffer size (5564 == 5564)
[n8gray@golux sounds]$ aplay ktalkd.wav
Playing WAVE 'ktalkd.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
aplay: set_params:847: Can't use period equal to buffer size (5513 == 5513)
[n8gray@golux sounds]$ aplay KDE_Beep_Connect.wav
Playing WAVE 'KDE_Beep_Connect.wav' : Unsigned 8 bit, Rate 11128 Hz, Mono
aplay: set_params:847: Can't use period equal to buffer size (5564 == 5564)

BTW, this is a good (but noisy) way to test aplay.  Go to a directory 
with lots of wav files and:
	for f in *.wav; do echo $f; aplay $f || break; done

Cheers,
-n8

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
