From: Dirk Jagdmann <doj@cubic.org>
Subject: Re: What's the right way to do??? resample??
Date: Thu, 31 Mar 2005 16:36:15 +0200
Message-ID: <424C0ADF.3040306@cubic.org>
References: <7fe2059905033018492546d763@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <7fe2059905033018492546d763@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joe Hsu <nagual.hsu@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>     When recording from one audio codec and playing
> back from another audio codec in real time, there
> must be some asynchronous problems.(Buffer overrun
> for recording or buffer underrun for playback).
> I believe this problem must have some answers.
> Hence should I resample audio in real time dynamically
> so that asynchronous conditions would be eliminated?
> If so, what resample library would be suitable??
> Libsamplerate or Libresample???

There is now software solution to this problem, because software has no 
way to figure out, when/how much two hardware pieces get out of sync. 
You have to sync your hardware for input and output. That either means 
you have to use a hardware which provides both input and output and full 
duplex access or you have to use an external word clock cable to 
synchronisation. Then on the software side you can be sure, that your 
output will always consume the exact amount of data the input has just 
generated.

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
