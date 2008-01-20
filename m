From: Brian Hinz <bphinz@hotmail.com>
Subject: Re: Si3054 and Lenovo3000 n100
Date: Sun, 20 Jan 2008 12:44:49 -0500
Message-ID: <BLU123-W30BF40CB7043E67B7B553AC83C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu139-omc3-s21.blu139.hotmail.com
	(blu139-omc3-s21.blu139.hotmail.com [65.55.175.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FFDE248C0
	for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2008 18:44:50 +0100 (CET)
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


11c1:1040 is not an SiLabs chip, it's an agere - see alsa bug #0003316:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3316

and agere still has not released a driver or documentation yet:

http://linmodems.technion.ac.il/archive-seventh/msg03029.html

it probably should be removed from patch_si3054.c though...

-brian

------------------------------
 
Message: 3
Date: Mon, 14 Jan 2008 12:07:15 +0100
From: Takashi Iwai 
Subject: Re: [alsa-devel] Si3054 and Lenovo3000 n100
To: Vasily Khoruzhick 
Cc: Andy Shevchenko , alsa-devel@alsa-project.org
Message-ID: 
Content-Type: text/plain; charset=US-ASCII
 
At Sun, 13 Jan 2008 19:10:44 +0200,
Vasily Khoruzhick wrote:
> 
> On 13 January 2008 18:15:06 Andy Shevchenko wrote:
>> Hi Vasily Khoruzhick!
>>
>>  On Sun, Jan 13, 2008 at 04:49:45PM +0200, Vasily Khoruzhick wrote next:
>>> Hi, I have problems with setting up internal modem (regular si3054
>>> sitting on hda bus) with subj notebook.
>>
>> Do you belive that the Si3054 clone? What is ids of your modem codec?
>> If you get 11c1:1040 you lose this game.
>>
>> P.S. IIRC the n200 has unsupported modem codec. I guess your model too.
> 
> Btw, if it isn't compatible with Si3054, why its id added to patch_si3054.c 
> file?
 
Possibly mistakenly :)
 
 
Takashi
