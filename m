From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: what is exactly pcm.boundary?
Date: Fri, 6 Jan 2017 09:09:00 +0100
Message-ID: <922adfc9-c436-905a-466e-7fbba239439e@ladisch.de>
References: <CAAu8Fse4GcOV5PkgnWQfBSQjM3SoiEurVuhvuNgQ3zD_8TeHbw@mail.gmail.com>
 <cf5b8891-5d8e-9df1-dbfa-b4471ef32f55@sakamocchi.jp>
 <CAAu8FscDY1R7EG2GsTmV9=JUWGh3K3HEw4RdF-g8NHjzFNYO8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A23F3266725
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 09:09:26 +0100 (CET)
In-Reply-To: <CAAu8FscDY1R7EG2GsTmV9=JUWGh3K3HEw4RdF-g8NHjzFNYO8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Biehl <rbpoficial@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Ricardo Biehl wrote:
> In this way, can I get the offset of hardware pointer in my pcm char device
> mmaped area with:
>
> 	offset_in_buffer = hw_ptr % buffer_size;  ?

Are you talking about code in your driver (where you are responsible for
asking the hardware), or user space code (where you must not directly
read hw_ptr)?  What is the actual problem you're trying to solve?


Regards,
Clemens
