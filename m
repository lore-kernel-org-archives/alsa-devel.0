From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Tue, 27 Nov 2012 18:21:29 +0100
Message-ID: <50B4F699.5090205@ladisch.de>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]> <50AE99E7.6080008@gmail.com>
 <p06240802ccd72a8f5c3e@[192.168.1.12]> <50B21255.8080202@gmail.com>
 <p06240812ccd8489d6378@[192.168.1.12]> <50B31800.2000000@gmail.com>
 <p06240804ccd98cef996c@[192.168.1.8]> <50B4A870.7040201@gmail.com>
 <p06240808ccdaa0a47bbb@[192.168.1.8]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id BECBA261576
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 18:21:32 +0100 (CET)
In-Reply-To: <p06240808ccdaa0a47bbb@[192.168.1.8]>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Griscom <griscom@suitable.com>
Cc: Alsa Developer <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Daniel Griscom wrote:
>> [  432.591698] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>> [  432.591702] ALSA sound/usb/pcm.c:1163 packet 1 failed: -18
>> [  432.592684] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>> [  432.592702] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>> [  432.592706] ALSA sound/usb/pcm.c:1163 packet 1 failed: -18
>> [  432.593684] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>> [  432.593701] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>> [  432.593705] ALSA sound/usb/pcm.c:1163 packet 1 failed: -18
>> [  432.594680] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18

These packet numbers never get above 1.  Are you using two
microframes per URB?  What is the ALSA buffer size?


Regards,
Clemens
