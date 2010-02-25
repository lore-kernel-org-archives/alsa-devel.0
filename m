From: Angel Tsankov <fn42551@fmi.uni-sofia.bg>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Thu, 25 Feb 2010 15:31:13 +0200
Message-ID: <hm5u2i$2h7$1@dough.gmane.org>
References: <hm5aba$p65$1@dough.gmane.org>
	<alpine.LNX.2.00.1002250915480.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080304050307020608010806"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 14BDE1039AE
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 14:31:13 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Nkdo7-0004bn-Ei
	for alsa-devel@alsa-project.org; Thu, 25 Feb 2010 14:31:11 +0100
Received: from client-144-140.speedy-net.bg ([78.159.144.140])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 14:31:11 +0100
Received: from fn42551 by client-144-140.speedy-net.bg with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 14:31:11 +0100
In-Reply-To: <alpine.LNX.2.00.1002250915480.28127@eeebox2.perex-int.cz>
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

This is a multi-part message in MIME format.
--------------080304050307020608010806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jaroslav Kysela wrote:
> On Thu, 25 Feb 2010, Angel Tsankov wrote:
> 
>> Hello,
>>
>> I run 'alsactl restore' on a machine with 2 sound cards -- a built-in
>> Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev
>> 02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Audio
>> Controller] (rev 03) -- and get the following message:
>>
>> Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84" "AC97a:83847600"
>> "0x1073" "0x000d"
>> Hardware is initialized using a guess method
>>
>> As a consequence the volume levels of the Yamaha card do not get
>> restored to the levels stored in /etc/asound.state.  The volume levels
>> of the built-in card however are properly restored.  The asound.state
>> file has been created by executing 'alsactl store'.
>>
>> The kernel has been built with support for ALSA.  I've built and
>> installed the kernel modules for both cards (not the ones in the
>> alsa-driver package but those that come with kernel version 2.6.30.2).
>> Any ideas why alsactl cannot find the hardware it has previously
>> identified as "YMF724F", "SigmaTel STAC9700,83,84", and so on?
> 
> The logic of alsactl is to restore the state from /etc/asound.state if it 
> is valid. It seems like the set_controls() function in alsactl/state.c 
> returns an error code for a reason.
> 
> Could you try to compile the latest alsa-utils snapshot 
> (http://www.alsa-project.org/snapshot/) and run './alsactl -d restore' in 
> alsa-utils/alsactl directory? A warning (fail reason) should be printed.
> 
>  					Jaroslav

I've attached a bash shell script that I used to download, configure, 
compile, and run alsactl.  I've also attached a .log file with stdout 
and stderr that I got while executing the script.


Regards,
Angel Tsankov

--------------080304050307020608010806
Content-Type: application/octet-stream;
 name="test-alsa-utils.log.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test-alsa-utils.log.tar.bz2"

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
J7ndoA==
--------------080304050307020608010806
Content-Type: application/octet-stream;
 name="test-alsa-utils.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test-alsa-utils.tar.bz2"

QlpoOTFBWSZTWevcbscAAVf/hMQQAIB5g/+SwAEwBP//3tAAAQAIMAF6mzawlFNTEwRkyAyA
aaBkBk0EqaE1G1PUZqA9QABoAAAkoTFPSnhkmUDaRoNAAGT1PTT7m5yQEHpAjB5kxOVbEIG+
F682GrsYNQxjjvvsOwPTC4lwY6vQxsNT8NfetfgoTxEhfKiDSIUDCgTGyYi4oA3KLGMqDE5g
463Dcq4Fe8dK3cH7ua7YdpS4s76GoGB65g04RN4vF8SEpeWkioqIA4YNPJWOKm1MYREXPwhP
QabjYpUXtAy0wBK61DbbpnrNMKiqoQWUbEtxJSrpBGbh1CU4OSsYhQSA2yCVQnfLmimFsYX5
FUYRj7CoskjRFzklkSJmePFD1nKRRdG1J6FmZYFb5taQIlNCg/ItIE8SlQTHdvbT1MW8dmkH
xKUJCGXDEVRJYpUnuhM9HoiGCFjbr60cJJRRaRDAxOJnpkl0bC8m01j7tDq7kIP4u5IpwoSH
XuN2OA==
--------------080304050307020608010806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080304050307020608010806--
