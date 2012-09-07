From: Daniel Mack <zonque@gmail.com>
Subject: Re: ALSA release cycle
Date: Fri, 07 Sep 2012 13:58:28 +0200
Message-ID: <5049E164.3000405@gmail.com>
References: <5049DCA4.6000607@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id ED0542616C9
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 13:58:38 +0200 (CEST)
Received: by bkuw5 with SMTP id w5so1099251bku.38
 for <alsa-devel@alsa-project.org>; Fri, 07 Sep 2012 04:58:38 -0700 (PDT)
In-Reply-To: <5049DCA4.6000607@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07.09.2012 13:38, David Henningsson wrote:
> Hi,
> 
> At Plumber's we discussed the ALSA release cycle. Our releases recently 
> have been irregular, and the reasoning behind why a release was done at 
> that time, has not been very obvious.
> 
> IIRC, we kind of leaned towards releasing every six months. I don't 
> remember if there was any consensus about whether to try to align this 
> cycle to something else (e g Gnome, KDE, Fedora, Ubuntu, etc), or not.

... or the kernel? At least for the kernel parts of ALSA, syncing an
ALSA version to kernel version would automatically tell us which patches
will make it into a new release. Plus, it would also be easier to
compare feature sets (something like "ALSA 1.0.26 gives us what we have
in kernel 3.6").

Would that be feasible or am I missing something?


Daniel
