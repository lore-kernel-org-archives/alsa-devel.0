From: Rainer Menzner <rmenzner@L1id.com>
Subject: Re: NVidia AC97 / CK804: arecord hangs in system call
 poll()
Date: Mon, 02 Jul 2007 07:58:10 +0200
Message-ID: <468893F2.5090708@L1id.com>
References: <4684EEAF.5050108@L1id.com> <s5hwsxmz7by.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.rz.ruhr-uni-bochum.de (mx2.rz.ruhr-uni-bochum.de
	[134.147.64.30]) by alsa0.perex.cz (Postfix) with SMTP id 8BAD824374
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2007 07:58:12 +0200 (CEST)
Received: from tijuana.zn-ag.com ([192.168.10.5])
	by langley.de.viisage.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP
	id l625wAmH004380
	for <alsa-devel@alsa-project.org>; Mon, 2 Jul 2007 07:58:10 +0200
Received: from mailserver.zn-ag.com (berlin.zn-ag.com [192.168.10.1])
	by tijuana.zn-ag.com (8.12.9/8.12.8) with ESMTP id l625wAiT007605
	for <alsa-devel@alsa-project.org>; Mon, 2 Jul 2007 07:58:10 +0200
Received: from [134.147.254.35] (stuttgart [134.147.254.35])
	by mailserver.zn-ag.com (Postfix on SuSE Linux eMail Server 3.0) with
	ESMTP id 771581CB028 for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2007 07:58:10 +0200 (CEST)
In-Reply-To: <s5hwsxmz7by.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developer Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

your guess was correct, I hadn't believed in such trivial solution.

Thanks,
-Rainer

Takashi Iwai wrote:
> At Fri, 29 Jun 2007 13:36:15 +0200,
> Rainer Menzner wrote:
>   =

>> Hi,
>>
>> my soundcard is an onboard AC97 CK804 NVidia. I use snd-intel8x0 module. =

>> Everything works fine except recording sound. When calling
>>
>>    arecord -f cd buffer.wav
>>
>> the program infinitely hangs, and an strace shows that it is a poll() =

>> call that does not return. After interrupting, a wave file of 44 bytes =

>> which is the header only is left. My setup is Kernel 2.6.21.3, all =

>> ALSA-software is updated to the latest version, that is 1.0.14(a).
>>
>> In a previous setup with an older ALSA version and kernel 2.6.16.11 =

>> recording did work with the same hardware. Now that I updated all ALSA =

>> software, even with that older kernel version the same recording problem =

>> came up. From that I concluded that it is somehow related to the =

>> ALSA-lib version. I have tried to downgrade ALSA-lib down to 1.0.0 to no =

>> avail.
>>
>> I have also made tests appropriate if this would be an interrupt problem =

>> (using pci=3Dnoroute et al) which also did not solve the problem.
>>
>> I have scrolled though the archives of alsa-user and there have been a =

>> few posts regarding the same problem (but with other chip sets). =

>> However, in those threads no definitive solution of the problem has been =

>> discussed. So I tried it again in alsa-user but did not get any feedback=
 ...
>>
>> Now, I finally try this developer list. Your comments and help are much =

>> appreciated. Let me know if you need further info. I'm not a Linux =

>> system programmer or specialist, but I would be willing to do some =

>> debugging if somebody explains what to check.
>>     =

>
> Most likely a mixer configuration.  For example, it's now set up to
> record from the SPDIF input or so.
> You can check the detailed configuration from the generated file via
> "alsactl -f somefile store".
>
>
> Takashi
>
>   =



-- =


______________________________________________
 =

*Dr. Rainer Menzner*
Principal Engineer, R&D
 =

*L-1 Identity Solutions AG*
/Protecting and Securing Personal Identities and Assets/
 =

Universit=E4tsstr. 160
44801 Bochum, Germany
Telephone:  	+49-234-9787-41
Facsimile:  	+49-234-9787-77
Mobile:  	0160 / 700 99 07
email: 	rmenzner@L1id.com <mailto:rmenzner@L1id.com>

 =

www.L1ID.com <http://www.l1id.com/>
 =

This message is only for the use of the intended recipient and may =

contain information that is CONFIDENTIAL and PROPRIETARY to L-1 Identity =

Solutions. If you are not the intended recipient, please erase all =

copies of the message and its attachments and notify the sender immediately.
 =

VORSTAND / EXECUTIVE BOARD Hartmuth von Maltzahn (Vors. / Chairman), Dr. =

Stefan Gehlen | AUFSICHTSRAT / SUPERVISORY BOARD James H. Moar (Vors. / =

Chairman) | GERICHTSSTAND / REGISTER COURT Amtsgericht Bochum, HRB 69 54 =

| UST-ID / VAT-REG.-NO. DE 813124378
