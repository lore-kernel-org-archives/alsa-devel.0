From: Perry Gilfillan <perrye@linuxmail.org>
Subject: Adding module to ALSA tree with Kconfig script
Date: Mon, 26 Apr 2004 09:54:44 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <408D22B4.9040106@linuxmail.org>
Reply-To: perrye@linuxmail.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

It seems that between alsa-driver-1.0.2 and 1.0.4, the 
scripts/Modules.dep file has been dropped in favour of Kconfig scripts. 
  This seems like a good thing, but I'm at a loss to get my snd-tvmixer 
to work by this method.

I've looked at the revised "Writing an ALSA Driver" chapter 14, and 
still can't get it straight.  The first hurdle is creating a Kconfig 
script in the alsa-kernel/i2c directory.  This is what I came up with:

   # ALSA I2C drivers

   menu "I2C devices"
           depends on SND!=n && I2C

   config SND_TVMIXER
           tristate "Video 4 Linux TV-Mixer"
           depends on SND
           help
             Say 'Y' or 'M' to include support for TV-Mixer.
                   This module requires that the V4L msp3400 module be
                   present.

   endmenu



Then I have added these lines to alsa-kernel/i2c/Makefile:

snd-tvmixer-objs := tvmixer.o
obj-$(CONFIG_SND_TVMIXER) += snd-tvmixer.o


Chapter 14 has the second line written as 'extra-obj-$( ....', so I 
tried it both ways.

I'm building against a 2.4.25 kernel, so how do I invoke the Kconfig 
scripts?  or do I need to RTFine kbuild Manual?

Thanks,

Perry
-----
Gilfillan Family: http://www.gilfillan.org/

Projects:
   V3TV: http://www.gilfillan.org/v3tv/
   VPX3224:  http://www.gilfillan.org/vpx3224/
   snd-tvmixer:  http://www.gilfillan.org/ALSA/



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
