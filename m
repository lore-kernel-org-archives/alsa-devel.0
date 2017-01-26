From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa-lib Dmix issue
Date: Thu, 26 Jan 2017 13:03:15 +0100
Message-ID: <946f3a49-e014-8119-acd7-d17750779465@ladisch.de>
References: <CACmL+LCqwU8A8uq+Z=wFSazTCSMsKoRm0U+w7airoza240aHVQ@mail.gmail.com>
 <1aeb13c4-e84e-dc51-d596-51898a16a5d1@ladisch.de>
 <CACmL+LDz+j=id=aJh+G6aSHCBqEsVf8gmEsBKmWLmRSgoUfCew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BFA142666F2
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 13:04:03 +0100 (CET)
In-Reply-To: <CACmL+LDz+j=id=aJh+G6aSHCBqEsVf8gmEsBKmWLmRSgoUfCew@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anoop Rajan <anoopmannil@gmail.com>
Cc: alsa-devel@alsa-project.org, ajith karnik <ajithskarnik@gmail.com>
List-Id: alsa-devel@alsa-project.org

Anoop Rajan wrote:
> I assume the issue is in Dmix, it is not incrementing the appl pointer.

When there are multiple clients, there are multiple appl pointers.
So the dmix plugin does not bother to tell the hardware about any
of them.

Are you using a driver that lokos at appl_ptr?


Regards,
Clemens
