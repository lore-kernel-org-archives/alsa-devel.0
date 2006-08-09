From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Linux v2.6.18-rc4, snd-aoa link error
Date: Wed, 09 Aug 2006 11:58:22 +0200
Message-ID: <44D9B1BE.9070600@sipsolutions.net>
References: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org>	<20060808194651.GA29482@aepfle.de>	<1155067429.26338.96.camel@mindpipe>
	<s5hoduudypc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E49C9229
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Aug 2006 11:59:05 +0200 (MEST)
In-Reply-To: <s5hoduudypc.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Olaf Hering <olaf@aepfle.de>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> --- aoa/Kconfig~	2006-08-08 16:02:30.000000000 -0400
>> +++ aoa/Kconfig	2006-08-08 16:03:26.000000000 -0400
>> @@ -5,6 +5,7 @@
>>  	tristate "Apple Onboard Audio driver"
>>  	depends on SND
>>  	select SND_PCM
>> +	select I2C
>>  	---help---
>>  	This option enables the new driver for the various
>>  	Apple Onboard Audio components.
>>     =

>
> Maybe better to put it in aoa/codecs/Kconfig.
> The requirement of i2c is not in the core part of aoa driver but in
> the codec support codes.
>   =

Yes, each codec except for toonie should select I2C. Looks like I missed =

that, sorry.

However, I was recently told that the expected behaviour with I2C (in a =

thread discussing the motion sensor) that I2C should be depended upon, =

not selected. I very much disagree (*), however, and would like to see a =

select here.

Unfortunately, I started new work in N=FCrnberg, don't have any internet =

at home right now and am not supposed to bring my own laptop to work. =

Would someone else create the required patch?
> Should I2C_POWERMANC be selected, too?
It makes sense since the aoa driver is specific to machines that have =

the i2c powermac bus, but I'm ambivalent about it. Though, does the G5 =

require I2C_POWERMAC? I'm not completely sure about that.

johannes

(*) I don't think it makes sense to bother someone configuring the =

kernel with the some concept called I2C. The user should be able to just =

select the sound driver necessary.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
