From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC] XEN support in aserver
Date: Wed, 28 Jan 2015 21:04:10 +0500
Message-ID: <54C9087A.1020303@gmail.com>
References: <CAJKxXovW8LWVWSUoYRZt6RR9-=UdVCNCYDzr+hS6Gmx7jH=WMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B91F5261ACA
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:04:13 +0100 (CET)
Received: by mail-wg0-f51.google.com with SMTP id k14so21398896wgh.10
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 08:04:13 -0800 (PST)
In-Reply-To: <CAJKxXovW8LWVWSUoYRZt6RR9-=UdVCNCYDzr+hS6Gmx7jH=WMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vitaly.v.ch@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

28.01.2015 20:52, Vitaly V. Ch wrote:
> Hi all!
>
> What do you think about introducing XEN support into aserver? It will allow
> to share sound between domains with few little changes.

It seems that you are the only person who cares about aserver. 
Seriously, try to valgrind it and the related "share" and "shm" plugins, 
and you'll understand why I propose to remove it instead of fixing.

-- 
Alexander E. Patrakov
