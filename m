From: Jon Ellis <ashura666@mac.com>
Subject: libao alsa playback
Date: Sat, 22 Mar 2003 14:41:07 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E13AF6AB-5C28-11D7-AE02-0003934489D0@mac.com>
Mime-Version: 1.0 (Apple Message framework v551)
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

Hi,

i've been debugging a problem with a xiph.org library called libao. 
Playing was distorted when using alsa but fine with oss.

I tracked this down to libao using snd_pcm_hw_params_set_period_size 
instead of snd_pcm_hw_params_set_buffer_size. Changing to the later 
fixes the problem and playback is no longer distorted.

All is well. But, i'd really like to understand what was going on and 
why the change fixed things. Anyone care to enlighten me?

Thanks

j.



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
