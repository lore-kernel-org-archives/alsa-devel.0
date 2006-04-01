From: Carlos Munoz <carlos@kenati.com>
Subject: snd_pcm_hw_params_get_period_size() returning 0
Date: Fri, 31 Mar 2006 17:00:07 -0800
Message-ID: <442DD097.40901@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I tested my new driver with a simple application I wrote. I can play and 
record pcm files with no problem. However, I'm unable to get aplay to 
work. aplay just hangs. I was able to trace it to aplay.c:playback_go(). 
aplay is stuck in the while loop. After closer examination it turns out 
that the reason is because previously 
snd_pcm_hw_params_get_period_size() had set the period size to 0. Does 
any one know why
snd_pcm_hw_params_get_period_size() would be returning 0 ? Is it 
something the driver did/didn't do ?

Thanks,


Carlos


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
