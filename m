From: Milan Oravec <moravec@ukf.sk>
Subject: Re: SoundBlaterX G5
Date: Tue, 17 Jan 2017 22:20:33 +0100
Message-ID: <53f1f3cc-f9ac-7cd2-a9c3-25288ede34f3@ukf.sk>
References: <c7f0fe10-92b0-0866-f638-96e78b6175c5@ukf.sk>
 <35808a43-245b-a075-a433-d892897b40b4@ladisch.de>
 <8893efe5-8e73-3f75-b19c-b47891383342@ukf.sk>
 <d961d16c-aa8e-18b7-226f-ede89945f5cc@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inmail2.ukf.sk (inmail2.ukf.sk [193.87.12.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B02C26693C
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 22:20:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by inmail2.ukf.sk (Postfix) with ESMTP id 0C4831007D9
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 22:20:41 +0100 (CET)
Received: from inmail2.ukf.sk ([127.0.0.1])
 by localhost (inmail2.ukf.sk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AvNGb8eR0Qfk for <alsa-devel@alsa-project.org>;
 Tue, 17 Jan 2017 22:20:37 +0100 (CET)
Received: from posta.ukf.sk (posta.ukf.sk [193.87.12.33])
 by inmail2.ukf.sk (Postfix) with ESMTPS id 4CDB21007D8
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 22:20:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by posta.ukf.sk (Postfix) with ESMTP id C71051DF2B7
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 22:20:37 +0100 (CET)
Received: from posta.ukf.sk ([127.0.0.1])
 by localhost (posta.ukf.sk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ly+q4rzPy0XR for <alsa-devel@alsa-project.org>;
 Tue, 17 Jan 2017 22:20:33 +0100 (CET)
Received: from [192.168.15.252] (unknown [5.22.154.11])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by posta.ukf.sk (Postfix) with ESMTP id A21E91DF121
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 22:20:33 +0100 (CET)
In-Reply-To: <d961d16c-aa8e-18b7-226f-ede89945f5cc@ladisch.de>
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

I've forgot to list alsa-info output after successfull change:

http://www.alsa-project.org/db/?f=fb3f42ec787fafc0ca646d0da1a3a907909f90a8


Regards,

Milan


s pozdravom

Milan Oravec

CIKT UKF Nitra
mobil: +421907670270
email: moravec@ukf.sk

--------------------------------------------------------------------

Tuto spravu nepreveril ziadny antivirus - nebolo treba...

On 17.01.2017 10:39, Clemens Ladisch wrote:
> Milan Oravec wrote:
>> I think when I change "Speaker Clock Source" to direct audio sound card capabilities need to be re-enumerated to update sampling rates.
>>
>> Is there any way to achieve this?
>
> Try unloading and re-loading the driver module (snd-usb-audio).
>
>
> Regards,
> Clemens
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
