From: Alan Young <consult.awy@gmail.com>
Subject: Re: Improving status timestamp accuracy
Date: Sat, 4 Jun 2016 17:20:30 +0100
Message-ID: <5752FFCE.1070301@gmail.com>
References: <5752A005.2050309@gmail.com>
 <84551786-d910-efa0-3cc7-23a3e8f6ed8f@ladisch.de>
 <5752B0EC.3030605@gmail.com>
 <946c2480-fa6e-3f72-ad04-f585e9648f52@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A873260831
 for <alsa-devel@alsa-project.org>; Sat,  4 Jun 2016 18:20:32 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id n184so6118810wmn.1
 for <alsa-devel@alsa-project.org>; Sat, 04 Jun 2016 09:20:32 -0700 (PDT)
In-Reply-To: <946c2480-fa6e-3f72-ad04-f585e9648f52@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/06/16 16:59, Clemens Ladisch wrote:
>> >I want to know, at any given point in wall-clock time, how many samples
>> >have been output.
>  From the buffer, or from the speaker?
Obviously the speaker would be ideal, but there will likely be 
components between the output of the DMA and the speaker that will add 
some delay, such as a DAC and maybe a DSP. However, such components will 
typically add: (a) a very small delay, (b) a near constant delay,
