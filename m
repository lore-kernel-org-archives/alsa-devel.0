From: Eric Allamanche <alm@iis.fhg.de>
Subject: Getting actual sample rate
Date: Tue, 10 Jun 2003 17:54:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EE5FF42.5080107@iis.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

I'm using a digital Hammerfall audio card and was wondering how to 
figure out the sample rate of the ADAT input pcm stream (which can vary 
from 32kHZ to 96kHZ). I tried functions like 
snd_pcm_hw_params_get_rate() but they do not seem to give the right 
answer. Any hints?
BTW, when the input format changes, it would be great to be notified 
about this. Are there any notification handler which could be used for 
this purpose.

Eric



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
