From: Tim Hollingsworth <tim@hollingsworth.com.au>
Subject: Where do I begin?
Date: Thu, 4 Mar 2004 09:11:06 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <D086F2E8-6D78-11D8-A8A8-000A95AB8A40@hollingsworth.com.au>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi

I'm a bit of a newbie here.  I'm trying to write a PCM application 
using alsa 1.x.  Firstly, is there an up to date howto or tutorial on 
this?  I am currently using the ALSA 0.9.0 HOWTO from the ALSA dev 
page:

http://www.suse.de/~mana/alsa090_howto.html

*nothing* works.  The header files mentioned in the howto 
(alsa/libasound.h) don't exist in my system.  I am running debian, have 
installed:

alsa-base		1.0.2c-3
alsa-headers	1.0.2c-3
alsa-source	1.0.2c-3

I tried including sound/asound.h.  Compile chokes on the first 
declaration:

udpServer.c:24: error: parse error before '*' token

snd_pcm_t *pcm_handle;

Where do I start?

TIA
Tim



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
