From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: aserver, smix
Date: Wed, 26 Feb 2003 14:17:24 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302261914.UAA08589@alsa.alsa-project.org>
References: <3E5D0647.8040407@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail09.voicenet.com (mail09.voicenet.com [207.103.0.43])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id UAA08589
	for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2003 20:14:59 +0100
In-reply-to: Your message of "Thu, 27 Feb 2003 03:24:07 +0900."
             <3E5D0647.8040407@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Jozef Kosoru <zyzstar@uid0.sk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> I would like to ask what is the main purpose of the aserver. It can run
>> on the same machine as the client only (AFAIK) and it cannot mix multiple
>> client streams into the one device. So I've missed the point of that
>> application -- is there something for which it could be good for?
>> 
>> ALSA plugin documentation mentions the 'smix' plugin. But I cannot find
>> any further information nor the source code in the library for that. Is
>> it something which will be introduced it the future ALSA releases?
>> According the doc it is exactly something I've been looking for a long
>> time; pcm device sharing.
>> 
>
>This has been discussed many times.
>
>Currently the only ways to get pcm device sharing, I assume you mean 
>using multiple devices as one virtual device are to write it up in your 
>.asoundrc or use the patch which has been submitted but not applied to 
>jack for this purpose.

we also have the dmix plugin now, right jaroslav?


-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
