From: Burris Ewell <dalsa@gigagig.org>
Subject: signal loss recovery
Date: Fri, 28 Nov 2003 17:16:06 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <D7AA4A37-21F8-11D8-8A08-00039393D25E@gigagig.org>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
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

I am writing a simple capture program using 0.9.8 and a PDAudioCF card. 
  I want to recover gracefully when the A/D converter stops and starts 
sending signal during capture.   When signal is lost, I call 
snd_pcm_start periodically until the signal returns  and continue 
capture.  On odd numbered starts (first, third, fifth stop/start of A/D 
converter) everything recovers normally and I continue to capture the 
output of the converter.  However, on even numbered starts (second, 
fourth, sixth stop/start of A/D converter) I capture full scale white 
noise.

I'm probably not doing something right.  Any pointers or suggestions 
will be greatly appreciated.

thanks,
burris



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
