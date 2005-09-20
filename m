From: David Cohen <david.cohen@indt.org.br>
Subject: Problem with a stereo alsa driver
Date: Tue, 20 Sep 2005 12:12:06 -0400
Message-ID: <433034D6.5060203@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all,

I am getting a problem with an alsa driver on arm platform. The codec
works only with 2 channel and the driver was implemented with 2 channel
support only too. But I guess that alsa can play a mono audio file
making a software convertion from mono to stereo, is that correct?. My
problem is that not all sample rates are playing well in mono mode. Some
rates get into a loop and play the sound 3 times, and some rates play
with no problem. With stereo audio files, I never get these problems,
even with the same rates.
Is there anything to do with the driver to fix this problem, or it might
be a alsa error?

BR,

David Cohen


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
