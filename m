From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Some cs4630 progress
Date: Sun, 21 Jul 2002 20:36:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3AFF45.8060806@cucumelo.org>
References: <Pine.LNX.4.33.0207211030310.755-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA01401
	for <alsa-devel@alsa-project.org>; Sun, 21 Jul 2002 21:28:48 +0200
Received: from cucumelo.org (cactus [194.236.61.89])
	by cucumelo.org (Postfix) with ESMTP id B86212F46E
	for <alsa-devel@alsa-project.org>; Sun, 21 Jul 2002 20:36:53 +0200 (CEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

In this moment i've been hacking on the cs46xx alsa driver and hopefully 
i've got something that can make any fustraded cs46xx user/developer a 
little bit happier.
Public documentation about the cs4630 dont seems to exist and as we 
already know, and Cirrus have not been very helpful providing us such 
necesary technical information. Finally Tom. W at Cirrus have provided 
me some DSP assembler sources, and some other related C++ sources. With 
that references i've able to find out some internals of the cs4630 and 
get a little bit further.

The CS4630 runs a mini Real-Time OS inside, called SPOS (Stream 
Processing OS I guess ...), parts of the SPOS is located in ROM memory 
on the CS4630 and CS4612, on the CS4610 got no ROM, and the hole SPOS 
needs be loaded in RAM.
Then it's up to user/driver to setup which tasks should be running 
inside the SPOS, basically here we one basic entry to care of, the SCB 
(stream controll block), then we have 4 task tree, Hyper Foreground, 
Foreground,  and Background. A SCB entry got a few basic things to care 
of, a  address pointer to the next SCB list, a sublist address pointer, 
a function entry pointer. Then it has a lot of other relevant variables 
which depends on which task uses the SCB, but no documentation about 
this, so it's only to test && guess.
In the DSP image with the current ALSA driver all tasks are statically 
setup when load the image.
When the drivers pokes and peeks on the BA1 address space what it 
actually does is to modify and read parameters from a SCB task running 
in the DSP.

So I've been working on using the .osp files provided by the Windows 
driver. To .osp contains a EXPORT segment where from the driver obtain 
the task entry when setting up a SCB, (or a task tree).
The .osp provided by Windows driver dont contain any parameter data, 
which means that all tasks and SCB needs to be setup by the driver. When 
a the CODE in a .osp file is loaded into the DSP on other addres then 
0x0000 all "call()", and  "goto xxxx" instructions needs to be fixed up.

In this moment I've wroten  a program named "ospparser" then generates 
.h  from a .osp which contains a table with all exported symbol, code, 
sample and parameter segments.
Indirectly i can successfully load cwc4630.osp, cwcasync.osp, 
cwcsnoop.osp code into DSP, do all necesary fixups, and have everything 
working just a before, (as with current ALSA driver) All SCB's and 
tasktrees are setup by the driver.

Today i manage to get "signals" out from the SPDIFO interface, however 
the sound is very distorcionated, totally broken, and my minidisc dont 
wont record it, course some copyright
bit in the stream that i've got no idea how i been able to configure it 
in such way.

To make multiple PCM channel, secondary CODEC to work is just to setup 
the necesary SCB's entries, which is hard to know how to do without any 
documenation.

Well, if you want take a look at my  changes to the cs46xx driver, 
however the difference is not "hearable" yet, there a lot of work done, 
download my code at this locations:
http://www.cucumelo.org/~gorm/alsa-driver-0.9.0rc2-bs20020721.tar.gz
http://www.cucumelo.org/~gorm/ospparser.tar.gz

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
