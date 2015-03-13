From: Tim Cussins <timcussins@eml.cc>
Subject: struct timespec as part of kernel/userspace ABI
Date: Fri, 13 Mar 2015 14:02:21 +0000
Message-ID: <5502EDED.5030008@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B7856264FE3
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 15:02:35 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 76F8B2067F
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 10:02:33 -0400 (EDT)
Received: from [10.2.10.211] (unknown [195.59.102.251])
 by mail.messagingengine.com (Postfix) with ESMTPA id D8D4BC00295
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 10:02:34 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

Like the other ALSA ioctls, the proposed start_at ioctl currently uses 
struct timespec.

A reviewer (of the start_at patchset) has mentioned that communicating 
timespecs across the kernel/userspace boundary requires special 
32bit/64bit compatibility handling (pcm_compat.c). I didn't appreciate 
this :(

Should I follow the same pcm_compat.c pattern for dealing with timespecs 
for the proposed start_at ioctl?

Cheers,
Tim
