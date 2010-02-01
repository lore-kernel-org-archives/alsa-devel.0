From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: hw_ptr_interrupt removal broke interrupt pointer
	updates
Date: Mon, 01 Feb 2010 15:33:24 +0000
Message-ID: <hk6s83$f5k$1@ger.gmane.org>
References: <4B5EF09B.3040900@ladisch.de>	<alpine.LNX.2.00.1001261713430.6542@eeebox2.perex-int.cz>	<4B600C3E.6090208@ladisch.de>	<alpine.LNX.2.00.1001271057160.6542@eeebox2.perex-int.cz>	<4B6049E8.5000401@ladisch.de>
	<alpine.LNX.2.00.1001271541380.6542@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id D416424133
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 16:33:47 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NbyHa-0003ot-JI
	for alsa-devel@alsa-project.org; Mon, 01 Feb 2010 16:33:46 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 16:33:46 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 16:33:46 +0100
In-Reply-To: <alpine.LNX.2.00.1001271541380.6542@eeebox2.perex-int.cz>
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

'Twas brillig, and Jaroslav Kysela at 27/01/10 17:21 did gyre and gimble:
> On Wed, 27 Jan 2010, Clemens Ladisch wrote:
> 
>> Jaroslav Kysela wrote:
>>> On Wed, 27 Jan 2010, Clemens Ladisch wrote:
>>>> A somewhat unrelated issue:  Both old and new code assume that
>>>> hw_ptr==0 is a period boundary, but that is not true if the boundary
>>>> is not an integer multiple of the period size, and the pointer wraps.
>>>> I'm not sure what happens then.
>>>
>>> I'm not exactly sure what you're talking about. Where is the
>>> hw_ptr==0 assumption?
>>
>> This code, which tries to align hw_ptr_interrupt to a period boundary:
>>
>> 	runtime->hw_ptr_interrupt = new_hw_ptr -
>> 			(new_hw_ptr % runtime->period_size);
> 
> I see. It is really problem, because if hw_ptr_interrupt shifts, then the 
> condition
>  		delta = runtime->hw_ptr_interrupt + runtime->period_size;
>                  if (delta > new_hw_ptr) {
> 
> is not accurate and might cause unwanted issues.
> 
> The simple fix for 64-bit archs is to use "boundary = buffer_size * 
> period_size" expression to setup the boundary variable properly.
> 
> I added code to find the lowest common multiple for 32-bit archs.
> 
> The patch is:
> 
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=7910b4a1db63fefc3d291853d33c34c5b6352e8e

FWIW, this patch seems to have finally solved:
https://qa.mandriva.com/show_bug.cgi?id=57010

which we used to track this issue.

Had two users confirm it as fixed which is good enough for me :)

Take care and thanks.

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
