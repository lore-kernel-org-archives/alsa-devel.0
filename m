From: Milan Oravec <moravec@ukf.sk>
Subject: SoundBlaterX G5
Date: Sat, 14 Jan 2017 20:06:06 +0100
Message-ID: <c7f0fe10-92b0-0866-f638-96e78b6175c5@ukf.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inmail2.ukf.sk (inmail2.ukf.sk [193.87.12.27])
 by alsa0.perex.cz (Postfix) with ESMTP id D48B8266CC5
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2017 20:06:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by inmail2.ukf.sk (Postfix) with ESMTP id E33421007D7
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2017 20:06:13 +0100 (CET)
Received: from inmail2.ukf.sk ([127.0.0.1])
 by localhost (inmail2.ukf.sk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Mr1VUSJ9uCg for <alsa-devel@alsa-project.org>;
 Sat, 14 Jan 2017 20:06:10 +0100 (CET)
Received: from posta.ukf.sk (posta.ukf.sk [193.87.12.33])
 by inmail2.ukf.sk (Postfix) with ESMTPS id 178831007D6
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2017 20:06:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by posta.ukf.sk (Postfix) with ESMTP id 8973524300A
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2017 20:06:10 +0100 (CET)
Received: from posta.ukf.sk ([127.0.0.1])
 by localhost (posta.ukf.sk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XdVX6TmjlHCQ for <alsa-devel@alsa-project.org>;
 Sat, 14 Jan 2017 20:06:06 +0100 (CET)
Received: from [192.168.15.252] (unknown [5.22.154.11])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by posta.ukf.sk (Postfix) with ESMTP id ADE32242F41
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2017 20:06:06 +0100 (CET)
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

Greetings to all, excuse me please if I'm posting to wrong mailing list.

I've bought  SoundBlaterX G5 USB soundcard/DAC and want to use it in 
linux. Sound-card works OOB in linux with snd_usb_audio driver but only 
at max. 96k/24 sample rate, but HW should be 192K/24 capable. Device 
volume button works too, but LED backlight doesn't change with volume 
set.  Device needs to be plugged twice i to PC to get USB high speed and 
96k support enabled.

Here is alsa-info output after plugging in first time:

http://www.alsa-project.org/db/?f=1805a3c80208a62da101a27e660a8f020ac6ea71

and after re-plugging:

http://www.alsa-project.org/db/?f=74ca49f354e9a100ebf7ba9fe9f6eb82c019f3ef

The device is 192K/24 capable under OSX but only when is DSP clock 
source set to direct stereo ( 
http://support.creative.com/kb/ShowArticle.aspx?sid=132116 ), this may 
be the problem in linux.

Can anybody help/guide me to how to change this setting or tell me what 
to do please? If more info/debugging is needed I'm here to serve.

How can I submit info about this sound-card to ALSA SoundCard Matrix?

Thank you in advance!

Kind regards

Milan

-- 

s pozdravom

Milan Oravec

CIKT UKF Nitra
mobil: +421907670270
email:moravec@ukf.sk

--------------------------------------------------------------------

Tuto spravu nepreveril ziadny antivirus - nebolo treba...
