From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Handle large period size end-of-stream situation
Date: Thu, 04 Apr 2013 08:09:42 -0700
Message-ID: <515D97B6.1080701@gmail.com>
References: <515C459A.5070209@codeaurora.org> <515D1122.9020502@gmail.com>
 <515D477F.9010406@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id A2FD5265EF4
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 17:09:58 +0200 (CEST)
Received: by mail-pa0-f46.google.com with SMTP id lb1so1526961pab.19
 for <alsa-devel@alsa-project.org>; Thu, 04 Apr 2013 08:09:57 -0700 (PDT)
In-Reply-To: <515D477F.9010406@ladisch.de>
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
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/04/2013 02:27 AM, Clemens Ladisch wrote:
> Gabriel M. Beddingfield wrote:
>> In the typical end-of-stream case, you simply write the data that you
>> have.  When the hw pointer catches up to the application pointer, you
>> get an XRUN and the stream stops immediately.
>
> But that happens only when ALSA actually reads the hardware pointer.
> The application could ask for the pointer position for some reason, but
> when it is blocked, only the end-of-period interrupt will cause that.

I stand corrected.  (Thanks also to Peter Ujfalusi for setting me straight.)

So, if the hardware can detect it then the hardware needs to signal an 
interrupt for the XRUN.

Another option... from userspace you can call SYNC_PTR (e.g. 
pcm_get_htimestamp() in tinyalsa) to update the hw and application 
pointers, then inspect them to detect when all the data is transferred. 
  When you see all is played, immediately stop the stream.  Again, this 
presumes that the "hw" side is able to query the state of the pointer.

-gabriel
