From: Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH - alsa-lib 1/1] Change card/pid get
 functions to return -ENOSYS if the kernel is too old
Date: Fri, 1 Apr 2016 23:15:58 +0200
Message-ID: <20160401211558.GA20661@mail.zuhause>
References: <1459532030-6387-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe03-3.mx.upcmail.net
 (vie01a-dmta-pe03-3.mx.upcmail.net [62.179.121.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D6AB265173
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 23:16:00 +0200 (CEST)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe03.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1am6QB-0005FS-Pl
 for alsa-devel@alsa-project.org; Fri, 01 Apr 2016 23:15:59 +0200
Content-Disposition: inline
In-Reply-To: <1459532030-6387-1-git-send-email-agoode@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@google.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, martin.koegler@chello.at
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 01, 2016 at 01:33:50PM -0400, Adam Goode wrote:
> When trying to get the pid or card of a client, the get functions will
> return -1 if there is no pid or card for a client. Clients have zero or
> one of these, so -1 is correct for these cases. But we also need to detect
> the case where the kernel cannot tell us if there is a card or pid, so
> that userspace can fallback to probing this information in the old way.

Its a pity, that alsa-lib 1.1.1 has just been released, which just returns -1.
If the time between releases is really about 2 kernel releases, you will very likely
have to cope with the old API for some time.

Regards,
Martin
