From: Thomas Petersen <mendocino@mendocino.mine.nu>
Subject: CS4236 problems
Date: Thu, 09 May 2002 18:57:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDAAA8C.8040907@mendocino.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from server.mendocino.mine.nu (213.237.107.108.adsl.od.worldonline.dk [213.237.107.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id SAA30010
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 18:58:29 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm having lots of problems getting the cs4236 driver to work. I started 
out with the 0.9.0rc1 package. The snd-cs4236.o module wouldn't load. It 
just resulted in a message like "kernel: CS4236+ soundcard not found or 
device busy" in the system log.
Then i found out that the cs4236 driver was missing the pnp id of my 
card. I gathered the information from /proc/isapnp and added the line:
ISAPNP_CS4232('C','S','C',0xe936,0x0000,0x0010,0x0003),
to the list of pnpids in cs4236.c
Now the module could load, and I could even play some music... problem 
was now, that the sound wasn't audible. I turned up the volume for all 
channels in alsamixer and that actually made a difference. Now i could 
hear the music but extremely low. It is like the output is muted or 
something needs to be turned up. Also in a program like "kmix" the 
master volume is missing... strange.

Today i have tried with a cvs snapshot from 8th may. To get the module 
to load i did the same as before but i additionally had to uncomment the 
lines:
if (ver1 != ver2) {
     snd_printk("CS4236+ chip detected, but control port 0x%lx is not
  valid\n", cport);
     snd_device_free(card, chip);
     return -ENODEV;
}
in cs4236_lib.c. Otherwise it would just always give that message in the 
log when loading the module. I now have the same result as before.

In addition to the cs4236 card i also have a Terratec 128i (ESS Solo-1, 
snd-es1938.o) which is working perfectly with alsa.
The cs4236 is working correctly with OSS using the cs4232 driver.

I can supply more information on request like contents of /proc/isapnp 
and stuff like that. Just ask!


Thomas Petersen


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
