From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Juli@ ICE1724 and 24 bit audio
Date: Wed, 11 Feb 2009 09:38:42 +0100
Message-ID: <49928E92.7040805@insite.cz>
References: <366C228A7F9A4AAF9EE7190DC4C0EE68@PDSDesktop>	<49909186.4050902@insite.cz>	<67FF030CD7BA4BFB9ACE52B69F56D69D@DemianM1330>	<fd3eb9bf0902091338i7ffa51d6t5a62d82a6b48ada3@mail.gmail.com>	<47A687F571094A7F827250BBE602F100@DemianM1330>	<fd3eb9bf0902100333m7ab4edc1g99de11000a794245@mail.gmail.com>	<49919EA2.6030000@insite.cz>
	<3C34CD030E4642119E63E2F4F979C7DD@PDSDesktop>
	<49927988.5090308@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FA35103885
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 09:38:45 +0100 (CET)
In-Reply-To: <49927988.5090308@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Demian Martin <demianm_1@yahoo.com>
Cc: =?ISO-8859-2?Q?=27Vedran_Mileti=E6=27?= <rivanvx@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pavel Hofman napsal(a):
> Demian Martin napsal(a):
>> I confirmed that aplay and plughw:0,1 work fine. Aplay and hw:0,1 
>> don't work
>> at all.
>>
>> And that Xine is the culprit. Now to find out how to fix/work around 
>> Xine.
>>
>> Demian Martin
>> Product Design Services
>>
>>
> 
> The older aplay you most likely use does not support 24bit properly. 
> Install the latest alsa-utils from git and you will be fine.
> 

Sorry for confusion. Your aplay handles already 24bit correctly. ICE1724
supports only 32bit natively (as most modern cards do), and hw:0
correctly does not accept any other format. That is why plughw converts
your 24-bit format to 32bit - see the verbose output.

For testing purposes make a 32bit file (sox -V in.wav -4 32.wav), and
aplay -v -Dhw:0 32.wav will play fine.

Pavel


-- 
-----------------

inSITE, s.r.o.

Rubesova 29, 326 00 Plzen
Tel. +420 377 449 358
Fax  +420 222 745 553
GSM: +420 603 163 973
Email: pavel.hofman@insite.cz

www.educity.cz, www.jobcity.cz
www.meetings.cz, www.hrzive.cz
www.comben.cz, www.insite.cz

-------------------------------
Navstivte www.educity.cz, server
s nejvetsi nabidkou profesniho
vzdelavani na ceskem internetu.
