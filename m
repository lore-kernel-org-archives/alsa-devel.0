From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [Alsa-user] Re: [Sound] please help a newbie, red hat 8 and cs4610
Date: Thu, 26 Dec 2002 15:27:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E0B11B9.1000804@cucumelo.org>
References: <20021226075641.40837.qmail@web14704.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA29922
	for <alsa-devel@alsa-project.org>; Thu, 26 Dec 2002 14:24:22 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tejas Gandhi <gubbar924@yahoo.com>
Cc: sound-list@redhat.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

One relevant difference between the cs4610 versus cs4612, cs4620 and 
cs4630 is that the cs4610 got no program ROM, which probably will cause 
compatiblity issues. The DSP firmware used in all versions of the ALSA 
driver (so old and new DSP stuff) depends on the program ROM.

So I'm afraid that for the moment it wont work with any cs4610
based HW. The solution would be find another DSP firmware the dont
depends on the program ROM and use it for the case of the cs4610.

Then the cs4610 got less sample and program RAM, and the program
image will have bigger footprint (the ROM code will be included),
hopefully it will not become a problem.

There seems tobe very very few users using a cs4610 based HW,
is it worth the job trying to make it work ???

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
