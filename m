From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Sound card word clocks.
Date: Tue, 03 Jan 2006 23:45:35 +0000
Message-ID: <43BB0C9F.5050002@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A207A17A
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 00:45:36 +0100 (MET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.42)
	id 1EtvjL-000Pwd-Iy
	for alsa-devel@alsa-project.org; Tue, 03 Jan 2006 23:38:16 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I was wondering if it would be useful to let alsa-lib
1) read sound card word clocks. Do all sound cards have word clock 
registers? I know all Creative ones do.

2) set timer period interrupts based on the sound card's word clock.
This could make a call back similar to periods_elapsed(), which happens 
when a period interrupt happens.

They could possibly be used for a better alsa-lib resampler.

Another possible alternative could be a form of nanosleep() that auto 
repeats. I.e. the kernel causes a user-land callback every X 
nanoseconds. Does one exist in the kernel?
I think a wordclock based callback would probably be more in sync with 
the sound card than a nanosleep() one.

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
