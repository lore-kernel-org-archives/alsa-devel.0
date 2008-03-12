From: "Mike Mazarick" <mazarick@bellsouth.net>
Subject: It's time to discuss how to get a Gadget Labs driver
	into the Alsa tree...
Date: Wed, 12 Mar 2008 07:09:42 -0400
Message-ID: <000101c88431$92f087c0$b8d19740$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmailhost04.isp.att.net (fmailhost04.isp.att.net
	[207.115.11.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A513103841
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 12:09:47 +0100 (CET)
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: wavepro-driver-developers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

As discussed and posted to the Alsa Devel and Planet CCRMA lists back in
December (when this was 'a dream' ), we currently have a working Gadget Labs
Alsa driver.   There are a few more 'features' that are being considered for
development (multi card support, a control panel, etc) and more extensive
testing and verification by novice users is desired.    The main idea is
that we intend to ask the main Alsa developers for information twice;  first
when we have a functional driver and second when we have one that is 'user
tested' and is ready to go (ie. when there is a high degree of certainty
that all the features are finished and it's use won't cause any major
problems).   We are now at the first crossroads.   

 

There is a small team of developers, Dave Marion and Rick Macri, with some
assistance from Pete Mander on SVN setup (Dave and Rick finished before Pete
got a chance to 'play').   We have set up a sourceforge page to centralize
our effort.  The developers and I believe the code currently in the SVN
trunk (gl824) is suitable for identifying the appropriate steps to get it
from the project SVN repository into the Alsa Hg tree.

 

The project main page is here:

https://sourceforge.net/projects/wavepro-driver/

 

The source code is in an SVN repository here:

http://wavepro-driver.svn.sourceforge.net/viewvc/wavepro-driver/

 

There is a very short web page listed for development:

http://wavepro-driver.sourceforge.net/

 

There is a private mailing list of about 16 people that is tracking what is
going on.   

The group email address is:  wavepro-driver-developers@lists.sourceforge.net
(however,  you may have to be subscribed to mail something to the list;
I'm not sure).     

If you are subscribed, there is an archive available here:  

https://sourceforge.net/mailarchive/forum.php?forum_name=wavepro-driver-deve
lopers

 

Our goal is to have this driver included in Alsa so that an end user could
have this type of card in their system, and everything would automagically
work like all other cards.  The only way this can happen is if the driver
was included as part of Alsa.   The key 'next' questions are:

 

1.        When are the next couple of releases of Alsa planned?   How much
time before the release date should all drivers be 'in the Hg tree'?

2.       Does the code that is currently in the Gadget Labs SVN repository
meet the coding and syntax standards of Alsa?   We've tried to make it meet
the standards, and it is fairly easy to change at this stage if you happen
to spot something that is inconsistent with what you'd recommend.

3.       We have not modified Alsa to make this driver automatically;  there
is a 'Makefile' included currently.   We currently 'modprobe snd_rawmidi'
and 'modproble snd_pcm' and then 'insmod gl824.ko' to get it installed.  The
required changes to Alsa are fairly trivial and would be the same for every
other sound card.    Please let us know if there is something that should
happen besides what is in the GL repository.

4.       One of the key reasons that this driver was able to be developed
and tested in 2-3 months of part time effort is because there is already
complete source available for a Windows driver, complete with new firmware
and vhdl source (see 'External' in the repository).   The Windows developer
is a member of our mailing list and has been encouraging/helping our effort.
However, he didn't bother with GPL licensing (it's a 'Mostek/Waldemar'
license instead, but the source is readily available).   There may be a few
header files that he wrote and the PLD firmware is definitely from his
development.   Will everything (including the firmware) need to be GPLv2
before it can be included in the alsa tree?    

5.       What is needed for support?  What would you like us to be available
to do going forward?

6.       How can we make your life a little easier by modifying our
software?   What would you like to see that you don't see?

 

Although we will diligently try to get a broader base of testing to happen,
we will tell you realistically that there are probably very few users who
are likely to test this out.   I don't know of the exact number of Gadget
Labs cards that were produced, but the best guess is ~5,000 cards before the
manufacturer went bankrupt in 2001.  We feel the effort of creating a linux
driver has been advertised in most of the appropriate places, but the
mailing list that is tracking this is only 16 people, with 4 main
participants.   In other words, I don't think this will be a 'SoundBlaster'
or 'Audigy' with thousands of people giving feedback on how it works.
However, I do believe that this will be a very viable and cost effective
solution for some people who want an 8 channel in/out, 24 bit, 48 khz,
semi-professional soundcard solution with midi.   Although the soundcard
does not support DMA directly (a limitation of the PLX9052 interface chip),
Rick has developed an innovative scheme of using a user buffer and dumping
the result into a kernel ring buffer that provides as little as 2ms latency.
You may also find the method/architecture for development of interest to you
(see web page and SVN listings).

 

Please provide some of the key information you need so that we can work
together most effectively.   Answering some the questions above would be a
good way to start.   We would welcome your feedback so that we can
incorporate into the GL project codebase.   After your feedback has been
incorporated in the code and testing is completed, we will be pinging you
again (the second time) to let you know we are ready to put the code in the
alsa tree.

 

Regards,

 

Mike Mazarick

mazarick@bellsouth.net
