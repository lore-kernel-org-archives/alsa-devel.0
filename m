From: Bo Shen <voice.shen@atmel.com>
Subject: Re: Fwd: Overrun Errors - SAM9G
Date: Tue, 22 Jul 2014 10:27:56 +0800
Message-ID: <53CDCC2C.1010400@atmel.com>
References: <CABSY_ZsjSaZQA+KadBWnzR-9=YQby-Fnb9ZpBGZpXHtVsZZXMw@mail.gmail.com>
 <CABSY_Zsh44D19KtDYkc6ozSsxKpTk+cQJiy4rEGKqWgbv_a=tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SJOEDG01.corp.atmel.com (nasmtp02.atmel.com [204.2.163.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 89F242654E0
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 04:30:37 +0200 (CEST)
In-Reply-To: <CABSY_Zsh44D19KtDYkc6ozSsxKpTk+cQJiy4rEGKqWgbv_a=tQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshay Mishra <akshaymishra@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Akshay,

On 07/17/2014 08:54 PM, Akshay Mishra wrote:
> Hello,
>      I am trying a simple alsa capture on the Atmel ARM9 (SAM9G45). While
> only capture runs fine, putting any os call on the same thread gives XRUNs.
>
> Even a innocent usleep(1) seems to lead to regular XRUNs. Eventually I want
> to dump this capture on the serial port and I am not able to get past this.

Do you test with alsa utils. If yes, where you add the usleep(1) in code?

> I have tried on AT91 linux as well as on kernel 3.10.10-rt7 with no success.

I try both kernel and don't reproduce this issue with alsa utils.

> Please advice,
> Akshay

Best Regards,
Bo Shen
