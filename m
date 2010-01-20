From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Wed, 20 Jan 2010 01:24:10 +0000
Message-ID: <hj5lvn$is9$1@ger.gmane.org>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>	<alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>	<hj29f0$v5d$1@ger.gmane.org>
	<alpine.LNX.2.00.1001182233280.4324@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id BDFB4103801
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 02:24:32 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NXPJ7-0003QR-T8
	for alsa-devel@alsa-project.org; Wed, 20 Jan 2010 02:24:29 +0100
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 02:24:29 +0100
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 02:24:29 +0100
In-Reply-To: <alpine.LNX.2.00.1001182233280.4324@eeebox2.perex-int.cz>
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

Hi,

'Twas brillig, and Jaroslav Kysela at 18/01/10 21:39 did gyre and gimble:
> On Mon, 18 Jan 2010, Colin Guthrie wrote:
>> This is handled in our bug report here:
>> https://qa.mandriva.com/show_bug.cgi?id=57010
>>
>> For reference relating to comment 12:
>> 2.6.32.3-1mnb: First introduced the above 4 fixes.
>> 2.6.32.3-2mnb: included 7b3a177
>> 2.6.32.4-0.rc1.1mnb: included ed69c6a
>>
>> Is there something more that needs done?
> 
> Thanks for feedback. Please, provide debug information:
> 
> http://www.alsa-project.org/main/index.php/XRUN_Debug
> 
> Use 101 or 29 values for xrun_debug and try to put ksyslog messages 
> to a relation with the audiable problems.

Just following up on this on behalf of a colleage.

He's set the 101 value and this annoyingly seems to fix his problem
(well, no glitches to the ear anyway!).

However he does get the following messages:

kernel: PCM: hw_ptr skipping! [Q] (pos=1024, delta=8192, period=1024,
jdelta=0/170/0, hw_ptr=140116992/140116992)

When he does the 29 value it spams the log >one every second and he
didn't try too long to get it to fail before he switched to 101. I can
get the full log of the above too if it's useful or run the 29 test and
capture the output if it'll still help even tho it's not showing the error.

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
