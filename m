From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Help! Need to switch between normal speaker and BT
	headset dynamically
Date: Tue, 06 Apr 2010 15:30:21 +0100
Message-ID: <hpfghv$dm8$1@dough.gmane.org>
References: <27215555.734641270553822178.JavaMail.weblogic@epml05>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id D57DF244BB
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Apr 2010 16:30:37 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Nz9nW-0003fh-Je
	for alsa-devel@alsa-project.org; Tue, 06 Apr 2010 16:30:34 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 06 Apr 2010 16:30:34 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 06 Apr 2010 16:30:34 +0200
In-Reply-To: <27215555.734641270553822178.JavaMail.weblogic@epml05>
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

'Twas brillig, and ANISH KUMAR at 06/04/10 12:37 did gyre and gimble:
> As my question is related to the query what pradeep is asking and mark brown also suggested to me to use PA.
> I have some additional questions regarding PA which i would like to clarify before starting:
> 
> 1.Does PA have good resampler code if my hardware doesn't support resampling?

Yes. Infact this code will likely be needed in several cases when the
h/w does support resampling. If PA has multiple streams playing at once,
the h/w will likely only be able to cope with one rate at a time.

The resamplers are pluggable and can have optimized implementation for
some hardware - e.g. I believe Palm wrote an ARM specific resampler to
do this for their Pre platform (I could be mis-remembering tho').

> I have a system where we are using ALSA as the base and on top(application side) of it there is a thread running which 
> is pumping data and this thread is started by java code.Combination of LINUX+JAVA.
> This thread can perform these tasks:
> 1.Resampling for some rates.
> 2.Talking to PV framework to get the decoded PCM data and pumping audio data to alsa.
> 3.Routing support using asound.conf file.
> Can i replace this thread with PA by writing some wrapper over PA??
> What extra features PA is going to provide additionally if i start using PA other than what is listed above??As i know 
> PA is kind of sound deamon which my thread is not.

One very interesting feature of PA that is particularly relevant to
mobile platforms is the use of a timer-based model to drive the hard
ware. This allows for very large latencies to be used (e.g. 10-20s)
allowing for very efficient processor usage - only waking up when
absolutely necessary, not to service interrupts.

More info:
http://0pointer.de/blog/projects/pulse-glitch-free.html

This approach can bring power savings and thus increased battery life.

> Is there any good resampler code which i can use without any licensing problem  and which can be 
> easily integrated???

I pretty sure the included resamplers are OK to use, but it's all
clearly documented so just take a look.

Like I say it's easy enough to include your own too if needs be.

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
