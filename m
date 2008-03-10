From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Mon, 10 Mar 2008 16:21:37 +0100
Message-ID: <47D55201.5050301@keyaccess.nl>
References: <20080309235800.17D26DBA2@gherkin.frus.com>
	<47D4E480.3090309@orcon.net.nz> <47D55115.3010708@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 7550810386B
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 16:21:08 +0100 (CET)
In-Reply-To: <47D55115.3010708@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Cree <mcree@orcon.net.nz>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, ALSA devel <alsa-devel@alsa-project.org>, Bob Tracy <rct@frus.com>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10-03-08 16:17, Rene Herman wrote:

> On 10-03-08 08:34, Michael Cree wrote:
> 
>> Bob Tracy wrote:
> 
>>> Supposedly with the ES1888, dma1 is for capture, dma2 is for 
>>> playback. dma2 == 5 is a 16-bit channel, yes?  That could explain 
>>> much...
> 
> It is, but what would it explain? You're only having playback problems, 
> right?
> 
>>>
>>> As for the values "chosen" for dma1 and dma2, they are the ones that
>>>  keep showing up in the Alpha sound "howto" postings/documents.
>>
>> Running 'show config' in SRM on my Alphas (PWS500au and XP1000) reveals
>> the settings (except possibly for mpu_port) for the ESS1888 sound chip.
>> I recall that they are as reported in Alpha sound howtos.
> 
> Can it be forced to use dma2=0 (an 8-bit channel, and the usual capture 
> channel on es18xx)? However, that might not be the issue anyway:
> 
>> I hadn't been using the ESS1888 for awhile, but have just tried it out
>> since you reported problems.  I am running kernel 2.6.24.3 and Debian
>> testing on the XP1000.  I tried playing a number of wav files with
>> alsa's aplay, sox's play and with mocp.  I found that aplay and mocp
>> worked reliably through the ESS1888.  Sox's play on some files did play
>> back a small extra segment of the file - particularly on short files and
>> usually some section near the end of the file - once it had completed
>> playing the file once; maybe this is what you are also observing. 
> 
> This sounds very suspiciously like a difference with playing through the 
> native ALSA interface and the OSS emulaion. Could you and/or Bob confirm 
> that sox is using the OSS emulation and not ALSA natively?

Bob is spam-blocking me (sigh...) so perhaps you can make sure he sees this.

> I could very well imagine the ALSA OSS emulation being broken on Alpha. 
> I doubt any of teh developers has an Alpha. And if aplay works correctly 
> this seems very likely.
> 
> "sox" _can_ use ALSA natively as well by the way (see manpage for the 
> version you have installed).
> 
>> More onerously, my testing eventually ended in a complete system lock up!
>> I ran play (or was it aplay - sorry can't remember now)
> 
> Vital if play is using the OSS interface...
> 
>> and the system locked up. Got a response with ping across the network but
>> couldn't log in via ssh.  Have been playing mplayer through the ESS1888
>> for the last couple of days (don't like it though - the sound quality of
>> the ESS1888 is not good enough for my ears) and haven't had another one
>> of those lockups since.
> 
> Mmm.

Rene
