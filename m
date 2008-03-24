From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Tue, 25 Mar 2008 12:56:04 +1300
Message-ID: <47E83F94.8010409@orcon.net.nz>
References: <20080318032427.298BCDBA2@gherkin.frus.com>
	<546A47FE-F98E-49E2-A250-41F65C2D482B@orcon.net.nz>
	<47E6338E.8030001@orcon.net.nz> <47E7EFDF.2070706@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx4.orcon.net.nz (mx4.orcon.net.nz [219.88.242.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 80A9B24549
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 00:56:10 +0100 (CET)
Received: from Debian-exim by mx4.orcon.net.nz with local (Exim 4.68)
	(envelope-from <mcree@orcon.net.nz>) id 1JdwWM-0007DP-Jf
	for alsa-devel@alsa-project.org; Tue, 25 Mar 2008 12:56:06 +1300
In-Reply-To: <47E7EFDF.2070706@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Bob Tracy <rct@frus.com>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> On 23-03-08 11:40, Michael Cree wrote:
> 
>> I have been able to run some tests.
>>
>> The es18xx and cmipci drivers work fine on the XP1000.  I base that 
>> observation on using a variety of software, such as mplayer and mocp, 
>> through both sound cards, mainly through oss, but also have tried 
>> alsa, over the last year for es18xx and for the last three or four 
>> months for cmipci.  (I have noted that the M-Audio Revolution 7.1 
>> sound card with the ice1724 driver fails to work and causes system 
>> crashes on the XP1000,
>> but that's a different discussion).
> 
> Was there ever a follow-up in that thread? :
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006513.html

Takashi replied with a suggestion to disable MMAP in the ice1724 driver. 
  I have been preoccupied with other things for the last couple of weeks 
so haven't had a chance to try it out.

> There's a patch attached that disables mmap on MIATA. You and Bob seem 
> to be experiencing problems of a different nature (or severity at the 
> least) but for both of you it would be good to hear what applying this 
> and then playing using "aplay -D hw foo.wav" (on the miata systems, 
> ofcourse) brings.

I have applied the patch to the PWS600au.  Sound now works.  I can play 
8bit and 16bit sound files through the es1887 and the C-Media CM8738. 
They are both working fine.  I managed to get a 32bit sound file to play 
through the M-Audio Revolution too. (Though another 32bit sound file 
just produces silence through the M-Audio Rev. Haven't been able to 
establish why - the file looks fine to me.)  Repeated playing of files 
doesn't cause any problems.

I can't get sox's play to work (reports no mmap support, which is, of 
course, quite true).  I don't know how to tell sox to use the equivalent 
of alsa's hw device.  So I can't do the test on short files that Bob was 
  performing.

At this stage I've run out of time to test the M-Audio Rev in the XP1000 
and see if the MMAP disable patch help there.

Michael.
