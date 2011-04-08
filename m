From: Hugo Estopendo <sido616@gmx.de>
Subject: External microphone doesn't work on Thinkpad T410(i)
Date: Fri, 08 Apr 2011 23:51:31 +0200
Message-ID: <4D9F8363.7040902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 8C1BE10387B
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 23:51:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi there,
my ThinkPad does not have 2 audio jacks, it has just one for speakers 
and microphone both, like a MacBook or Smartphone. It also has an 
internal mic under the screen.
Normal audio playback works via the internal speakers and the jack both. 
The internal mic works, but when I plug a stereo headset with a mic 
included on this one jack, the internal mic is still used and the 
external mic is just ignored.

I alread opened a bug report: 
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5325

output of alsa information script: 
http://www.alsa-project.org/db/?f=68cddd0301737d0060ebfc1d292ac82953e273d7

lspci output: 
https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=3522&type=bug

Greetings, Hugo
