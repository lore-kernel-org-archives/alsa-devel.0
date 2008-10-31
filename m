From: Philippe CARRIERE <philippe-f.carriere@wanadoo.fr>
Subject: Re: TASCAM US122L
Date: Fri, 31 Oct 2008 13:24:24 +0100 (CET)
Message-ID: <150643.280926.1225455864724.JavaMail.www@wwinf1b28>
Reply-To: Philippe CARRIERE <philippe-f.carriere@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1b.orange.fr (smtp1b.orange.fr [193.252.23.64])
	by alsa0.perex.cz (Postfix) with ESMTP id B350F1037E3
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 13:24:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: mfp.perfumo@ono.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I discovered your previous email to alsa-devel recently. Had you a look to my further mail

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-October/011339.html

which possibly answer part of your questions ?

A patch is required for ehci-hcd module to access pcm emulation.

Regards


Phil

>At Mon, 6 Oct 2008 13:11:48 +0200,
>Fernando Perfumo wrote:
>> 
>> 
>> Hello all,
>> 
>>     following is an extract of kern.log when connecting and disconecting a 
>> TASCAM US122L :
>> ( the pcm part of the us122L does not appear in /proc/asound/... but only 
>> the midi part.
>>   kernel : 2.6.27-rc5-git11, alsa-driver-1.0.18rc3 compiled separately of 
>> the kernel sources, alsa-lib-1.0.18rc3 and  alsa-utils-1.0.18rc3 )
>
>Most messages are from snd_printdd(), so it's no bug but verbose messages.
>
>> I'd appreciate some ideas about the segfault in alsactl and the ausence of 
>> the pcm functionality..
>
>alsactl segfault seems irrelevant.  Are you using the latest git version?
>
>thanks,
>
>Takashi
