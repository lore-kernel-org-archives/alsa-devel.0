From: Daniel Griscom <griscom@suitable.com>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Tue, 27 Nov 2012 13:40:57 -0500
Message-ID: <p0624080cccdaac242dc3@[192.168.1.8]>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]>
 <50AE99E7.6080008@gmail.com> <p06240802ccd72a8f5c3e@[192.168.1.12]>
 <50B21255.8080202@gmail.com> <p06240812ccd8489d6378@[192.168.1.12]>
 <50B31800.2000000@gmail.com> <p06240804ccd98cef996c@[192.168.1.8]>
 <50B4A870.7040201@gmail.com> <p06240808ccdaa0a47bbb@[192.168.1.8]>
 <50B4F699.5090205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway05.websitewelcome.com (gateway05.websitewelcome.com
 [67.18.103.7]) by alsa0.perex.cz (Postfix) with ESMTP id C65A626157F
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 19:41:01 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway05.websitewelcome.com (Postfix) with ESMTP id 9B8519C3BE916
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 12:41:00 -0600 (CST)
In-Reply-To: <50B4F699.5090205@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa Developer <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

At 6:21 PM +0100 11/27/12, Clemens Ladisch wrote:
>Daniel Griscom wrote:
>>>  [  432.591698] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>>>  [  432.591702] ALSA sound/usb/pcm.c:1163 packet 1 failed: -18
>>>  [  432.592684] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>>>  [  432.592702] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>>>  [  432.592706] ALSA sound/usb/pcm.c:1163 packet 1 failed: -18
>>>  [  432.593684] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>>>  [  432.593701] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>>>  [  432.593705] ALSA sound/usb/pcm.c:1163 packet 1 failed: -18
>>>  [  432.594680] ALSA sound/usb/pcm.c:1163 packet 0 failed: -18
>
>These packet numbers never get above 1.  Are you using two
>microframes per URB?

We are using a bInterval value of 1 (on a high-speed device). We've 
recently tried bumping this up to 2, and the problem was no longer 
evident, but given the difficulty in reproducing it I wasn't at all 
clear that we hadn't just moved it to a different set of reproduce 
conditions.

... is that what you meant?

>What is the ALSA buffer size?

We're handing a value of 3072 to snd_pcm_hw_params_set_buffer_size_near().

>Regards,
>Clemens

Thanks,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
