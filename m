From: "Fox, Jason P." <JFox@gai-tronics.com>
Subject: ASoC: Sharing Codec on SSC TDM
Date: Wed, 22 Jun 2011 16:36:38 -0400
Message-ID: <E06FBBB839298740947D23138FE9F83D0548EF4F@hitmhnpaw3-ex1.hi.hubbell-ad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exprod7og116.obsmtp.com (exprod7og116.obsmtp.com [64.18.2.219])
	by alsa0.perex.cz (Postfix) with SMTP id F182C24332
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 22:37:00 +0200 (CEST)
Content-class: urn:content-classes:message
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

I have an application where I need an AD193X codec to be shared between
8 audio streams using one SSC channel on an AT91SAM9263. The AD1938
codec as configured in my driver has 8 channels. I need to be able to
send audio to the codec from 8 different tasks simultaneously. Each task
is to use only one channel.

 

We have the 8 TDM channels working in the driver. The first task can
access the codec and play audio just fine.  The second task cannot open
the device and gets an EBUSY return from snd_pcm_hw_open() because the
card is now owned by the first task.

 

However, the first task is only using one of the 8 channels.  I want the
second task to use the second channel, and so on.  

 

I can create an asound.conf that gives access to any one of the 8
channels, but only to one task at a time.  I've tried using dshare and
dmix, but that swamps the AT91 and there are lots of audio dropouts.
There is no need to mix audio between any of the streams, i.e. they are
all to be discrete audio outputs. 

 

What I am looking for is a way to structure the ASOC interface to allow
use of all 8 channels simultaneously.  If anyone can point me in a
direction, recommend a solution, or tell me where else to look it would
be VERY much appreciated.

 

Thank you for any help,

Jason Fox

GAI-Tronics   

 


*******************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager. This footnote also confirms that this
email message has been swept for the presence of computer viruses.
www.Hubbell.com - Hubbell Incorporated**
