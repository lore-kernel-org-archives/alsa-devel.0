From: Thomas Roeder <rdr@emt.iis.fhg.de>
Subject: libasound and libpthread
Date: Mon, 29 Jul 2002 10:06:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D44F782.3070007@emt.iis.fhg.de>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I am working with Alsa 0.9.0beta12 version and I am also using posix 
threads (libpthread) in my project. In the release version of the 
program I link both libraries (libpthread, libasound) dynamically and 
everything works well. In the debug version however, I have to do static 
linking of the libpthread for proper debugging.

Here is the problem:

If I try to link libasound dynamically and libpthread statically, the 
program crashes with a segmentation fault before even reaching the first 
line of my code (maybe, because libasound uses multithreading and 
libpthread itself ?).
If I try to link both statically, the program runs at least some line of 
code, until it reaches the sound initialization. Then it crashes again 
with the following messages:

ALSA lib conf.c:2540:(snd_config_hook_load) Unable to find field files 
in the preload section
ALSA lib conf.c:1785:(snd_config_hooks_call) function 
snd_config_hook_load returned error: Invalid argument
ALSA lib conf.c:2127:(snd_config_update) hooks failed, removing 
configuration



Any help is appreciated.

Thanks in advance

Thomas



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
