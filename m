From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Sun, 08 Aug 2010 14:12:26 +0200
Message-ID: <4C5E9F2A.5070906@gmx.de>
References: <4C595A52.7030401@gmx.de> <20100804233309.GB6629@00110101.home>
	<4C5A9EDA.10509@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 9AADA243C0
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 14:16:27 +0200 (CEST)
In-Reply-To: <4C5A9EDA.10509@gmx.de>
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
List-Id: alsa-devel@alsa-project.org


>> it crashes on my machine with one USB soundcard,
>> and an RME Hammerfall ..i think RME causes it -
>> i get a `Floating exception` ..hm, not a segfault this time :)
> 
> This looks like a bug in the slider/painter code.
> Maybe some ranges are screwed, like 0 to 0 or so and the slider
> can't handle it.

Indeed an 0 to 0 range exactly creates this kind of error.
I'll fix this within the next few days.

> A gdb backtrace would be helpful.
> Could you compile with:
> 
> cmake -DCMAKE_BUILD_TYPE=Debug
> make
> 
> and then create a backtrace with gdb:
> 
> echo -e "run\nwhere\nquit" > gdb_com.txt
> gdb src/alsamixer-qt4 -batch -x gdb_com.txt > gdb.txt
> 
> and send me the gdb.txt file?
> 
>> ..i can do some tests ..have you got an svn or git?
> 
> Right now I only have a mercurial repository on my local machine.
> I think sourceforge support mercurial now, I'll check on this later.

Ok, the mercurial repository is online (read only).

http://sourceforge.net/projects/alsamixer-qt4/develop

To create a clone type

hg clone
http://alsamixer-qt4.hg.sourceforge.net:8000/hgroot/alsamixer-qt4/alsamixer-qt4


>> basically RME alsa driver is different from all other drivers,
>> so far i only see one mixer that presented snd-hdsp options
>> in correct way ..it's mostly just tick boxes..
>> i'd say that you can just try to set up a condition
>> that if the card is RME, then just ignore that card :)
>> ..otherwise check hdspmixer and hdspconf in alsa-tools.
> 
> I would like to avoid keeping a blacklist in the mixer application.
> It's meant to be a general purpose mixer but it should'n crash on high
> end hardware.
