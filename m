From: Milan Oravec <moravec@ukf.sk>
Subject: Re: SoundBlaterX G5
Date: Mon, 16 Jan 2017 22:29:14 +0100
Message-ID: <8893efe5-8e73-3f75-b19c-b47891383342@ukf.sk>
References: <c7f0fe10-92b0-0866-f638-96e78b6175c5@ukf.sk>
 <35808a43-245b-a075-a433-d892897b40b4@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inmail2.ukf.sk (inmail2.ukf.sk [193.87.12.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 6256926738D
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 22:29:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by inmail2.ukf.sk (Postfix) with ESMTP id 22A63108719
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 22:29:22 +0100 (CET)
Received: from inmail2.ukf.sk ([127.0.0.1])
 by localhost (inmail2.ukf.sk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gmqOmMzyECGV for <alsa-devel@alsa-project.org>;
 Mon, 16 Jan 2017 22:29:18 +0100 (CET)
Received: from posta.ukf.sk (posta.ukf.sk [193.87.12.33])
 by inmail2.ukf.sk (Postfix) with ESMTPS id 4306C1189DE
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 22:29:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by posta.ukf.sk (Postfix) with ESMTP id C96151DF2B8
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 22:29:18 +0100 (CET)
Received: from posta.ukf.sk ([127.0.0.1])
 by localhost (posta.ukf.sk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iu5l2jxMa3zX for <alsa-devel@alsa-project.org>;
 Mon, 16 Jan 2017 22:29:14 +0100 (CET)
Received: from [192.168.15.252] (unknown [5.22.154.11])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by posta.ukf.sk (Postfix) with ESMTP id B3C5A1DF10F
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 22:29:14 +0100 (CET)
In-Reply-To: <35808a43-245b-a075-a433-d892897b40b4@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Sound card capabilities are enumerated when si device plugged in. I 
think when I change "Speaker Clock Source" to direct audio sound card 
capabilities need to be re-enumerated to update sampling rates.

Is there any way to achieve this? I've tried to re-plug device after 
changing "Speaker Clock Source" to direct audio, but DSP Clock is 
default value.

No additional drivers install is needed under OSX, there must be way to 
do the same in Linux. Or am I optimist?

Thank you, kind regards,

Milan

s pozdravom

Milan Oravec

CIKT UKF Nitra
mobil: +421907670270
email: moravec@ukf.sk

--------------------------------------------------------------------

Tuto spravu nepreveril ziadny antivirus - nebolo treba...

On 15.01.2017 11:29, Clemens Ladisch wrote:
> Milan Oravec wrote:
>> http://www.alsa-project.org/db/?f=74ca49f354e9a100ebf7ba9fe9f6eb82c019f3ef
>>
>> The device is 192K/24 capable under OSX but only when is DSP clock
>> source set to direct stereo, this may be the problem in linux.
>
> There is a mixer control named "Speaker Clock Source".  Doesn't it work?
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
