From: Joe Hsu <nagual.hsu@gmail.com>
Subject: What's the right way to do??? resample??
Date: Thu, 31 Mar 2005 10:49:04 +0800
Message-ID: <7fe2059905033018492546d763@mail.gmail.com>
Reply-To: Joe Hsu <nagual.hsu@gmail.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

    I am a beginner on Linux audio programming.

    When recording from one audio codec and playing
back from another audio codec in real time, there
must be some asynchronous problems.(Buffer overrun
for recording or buffer underrun for playback).
I believe this problem must have some answers.
Hence should I resample audio in real time dynamically
so that asynchronous conditions would be eliminated?
If so, what resample library would be suitable??
Libsamplerate or Libresample???
Thanks if anyone can give me some hints.
(My recording device is 8000HZ and my playback device 
also works at 8000HZ)
-- 
The sun is shinny but the ice is slippery.


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
