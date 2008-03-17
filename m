From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PATCH - ESI Juli driver
Date: Mon, 17 Mar 2008 10:37:22 +0100
Message-ID: <47DE3BD2.5090007@insite.cz>
References: <47DD1934.3000003@insite.cz>
	<s5hod9du6gb.wl%tiwai@suse.de>	<47DE328D.1080009@insite.cz>
	<s5htzj5r9d6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz
	(171-43-207-85.zapcechy.adsl-llu.static.bluetone.cz [85.207.43.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B7B9243F2
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 10:37:30 +0100 (CET)
In-Reply-To: <s5htzj5r9d6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Rainer Zimmermann <mail@lightshed.de>
List-Id: alsa-devel@alsa-project.org

>>
>> I did not want to copy/paste any algorithmical code from ice1724.c to 
>> juli.c as it complicates future maintenance. Now, the vt1724 code in 
>> ice1724.c is pretty much about general algorhitms, specific routines are 
>> in stdclock_... I tested the original clock with Prodigy192 which 
>> provided testing analog/SPDIF signals. There are no functional changes.
> 
> I see the point that you want to make it generic.  But, too many
> callbacks, in other words, too many tuning parameters make the code
> difficult to follow.  It's a question of balance.

Takashi, I understand your concern. On the other hand, if the callbacks 
are well documented, it actually makes the code easier to follow, as it 
separates general algorithms from detailed HW implementation. I can 
certainly add more comments to the callback functions.

Honestly, I do not know which callbacks to remove (apart of those two 
not redefined in Juli). Otherwise I will have to copy/paste serious 
portions of code to juli.c which I would really want to avoid.

As I see it, the clocking code in ice1724 was written for one specific 
implementation. There was no need to do so in a general way and I 
completely understand that. Nevertheless, juli uses a different clock 
implementation and I believe the time has come to make the code in 
ice1724 more general. Unfortunately, I do not know of any other 
technology but callbacks.

What would you recommend?

Thanks,

Pavel.


> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
-----------------

inSITE, s.r.o.

Rubesova 29, 326 00 Plzen
Tel., fax: +420 - 37 - 74 493 58
GSM: +420 - 603 - 163 973
Email: pavel.hofman@insite.cz

www.educity.cz, www.insite.cz
www.meetings.cz, www.hrzive.cz
www.comben.cz, www.hr-online.cz
-------------------------------
Navstivte www.educity.cz, server
s nejvetsi nabidkou profesniho
vzdelavani na ceskem internetu.
