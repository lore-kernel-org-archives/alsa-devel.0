From: Anders Torger <torger@ludd.luth.se>
Subject: Repeatable exact I/O-delay
Date: Sat, 27 Jul 2002 14:51:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020727125116.B57458D1@mail.it4u.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA10763
	for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2002 14:52:03 +0200
Received: from there (shark.it4u.net [80.88.99.82])
	by mail.it4u.net (Postfix) with SMTP id B57458D1
	for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2002 14:51:16 +0200 (CEST)
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


I have made a multi-channel convolution software (BruteFIR) which has 
some I/O-delay, typically 4096 samples.

The software works like this: it reads a block of 2048 samples, 
processes it during the coming 2048 samples, and then puts the 
processed samples to the output, thus a total of 4096 samples I/O-delay.

The problem here is that there is no mechanism I know of which can 
cause the output to start coming *exactly* 4096 samples after the first 
input sample is read. I have not measured, but probably the I/O-delay 
varies a few tens of samples each time the program is started.

I think repeatable exact I/O-delay is a very important feature, but I 
guess that hardware support is necessary to make it work reliably. So, 
why is this feature important?

This feature means that the computer could be sample-aligned with other 
hardware audio processors. In the recording studio, you could use audio 
processing software on a standard workstation as a low-cost 
alternative, and still let it collaborate with your existing hardware 
processors.

Low I/O-delay is good, but if it varies, you can't sample-align anyway. 
In many cases it is better to have exactly 4096 samples I/O-delay every 
time, than having an I/O-delay that varies between 100 - 150 samples. 
Even not all commercially available hardware audio processors have zero 
delay, some have delays up to tens of milliseconds, but they can be 
used anyway in most applications, since the delay is always the same 
and can be compensated for.

With repeatable exact I/O-delay, it would also be possible to build 
audio processing clusters, by duplicating the inputs (using for example 
ADAT duplicators) to several sample-aligned workstations. With my 
software I could build a synchronised convolution cluster, which could 
handle large-scale auralisation, wave field synthesis and other 
extremely demanding applications.

Does anyone have any comments on this? Is repeatable exact I/O-delay 
possible to achieve today with current hardware (and ALSA)?

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
