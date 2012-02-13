From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdsp rpm support
Date: Mon, 13 Feb 2012 16:06:11 +0100
Message-ID: <4F3926E3.1050809@drcomp.erfurt.thur.de>
References: <1326877559.24738.84.camel@yoyo4>
	<20120118102658.GA5351@linuxaudio.org>
	<1326884040.18308.6.camel@yoyo4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [89.163.167.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D924324511
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 16:06:28 +0100 (CET)
In-Reply-To: <1326884040.18308.6.camel@yoyo4>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roman Haefeli <reduzent@gmail.com>
Cc: alsa-devel@alsa-project.org, Fons Adriaensen <fons@linuxaudio.org>
List-Id: alsa-devel@alsa-project.org

On 01/18/2012 11:54 AM, Roman Haefeli wrote:


Sorry for the late reply, I was on vacation...

[RME HDSP RPM]
> May I ask kindly for the 'other' version of the driver, which I would be
> happy to test?

As already mentioned by Fons, there are so many differnt versions now
that I hardly remember which one is supposed to work. ;)

    http://adi.loris.tv/hdsp_20111031.tar.bz2


seems to be a combined archive. It contains two versions of the driver,
the first (hdsp.c) is more or less what's in current alsa-driver, the
other one (hdsp-test.c) is what turned out to be working for one user,
so you would do

    mv hdsp-test.c hdsp.c

followed by

    make install

Note that this driver uses hdsp.ko as the module name in contrast to
snd_hdsp.ko from your tree, so you might need to add

blacklist snd_hdsp

to /etc/modprobe.d/foobar.conf


Please report back.


Final remark: For some devices (digiface, multiface, iirc), the firmware
filename was too long. mv /lib/firmware/hdsploader/* /lib/firmware/ did
the trick, but iirc, the RPM wasn't affected.


Cheers
