From: Cyrus Harmon <cyrus@bobobeach.com>
Subject: Re: add Steinberg UR44 USB Audio Interface support to
 quirks-table
Date: Tue, 27 Jan 2015 09:21:55 -0800
Message-ID: <54C7C933.8080002@bobobeach.com>
References: <CAH7VmLJQojMB5mH_mcq3-Q5HVcfs8QZf4m8D3MK0p7qBWkctGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aspen.bobobeach.com (unknown [208.79.93.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 751AB2608EC
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 18:22:13 +0100 (CET)
Received: from aspen.bobobeach.com (localhost [127.0.0.1])
 by aspen.bobobeach.com (Postfix) with ESMTP id BB3B010154
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 09:24:27 -0800 (PST)
Received: from [192.168.1.224] (unknown [107.200.11.235])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by aspen.bobobeach.com (Postfix) with ESMTPSA id 8DD1E1014A
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 09:24:27 -0800 (PST)
in-reply-to: <CAH7VmLJQojMB5mH_mcq3-Q5HVcfs8QZf4m8D3MK0p7qBWkctGw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 01/23/2015 03:42 AM, Vlastimil Wagner wrote:
> hi In what state is the driver for Steinberg UR44

I sent a patch to to quirks-table.h a few months back that makes things 
work with the UR44. Clemens commented that, in theory, kernel 3.11 and 
later should support the UR44 out of the box, without needing the patch 
to the quirks table. He also sent along some patches with some debugging 
information to try to track down why things were failing, but I never 
got around to investigating the fully the source of the error, nor did I 
push for inclusion of the quirks-table.h patch, so it's still sitting 
out there. Check the list archives for details.

Cyrus
