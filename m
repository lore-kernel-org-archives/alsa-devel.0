From: Tom Tromey <tom@tromey.com>
Subject: bug report - headphones stopped working
Date: Fri, 07 Aug 2015 07:49:07 -0600
Message-ID: <87fv3v1a5o.fsf@tromey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gproxy5-pub.mail.unifiedlayer.com
 (gproxy5-pub.mail.unifiedlayer.com [67.222.38.55])
 by alsa0.perex.cz (Postfix) with SMTP id B32F9260418
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 15:49:26 +0200 (CEST)
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

A recent kernel upgrade caused my headphones to stop working.
I asked on #alsa about this and after a lot of help from "debianuser"
(thank you very much), he suggested I report this to this list.

I'm using x86-64 Fedora 22.
The kernel that works is kernel-4.0.5-300.fc22.x86_64.
The kernel that fails is kernel-4.1.3-200.fc22.x86_64.
(These are the RPM package names in case that isn't clear.)


The output from alsa-info.sh for the working case:

http://www.alsa-project.org/db/?f=1da69e358935e2d4a35513fc308a74a07925a4fd

... and for the failing case:

http://www.alsa-project.org/db/?f=6a1439affc507f1b83f99b5f42b7cbfe0664f9e8


I'm happy to provide other information as needed, though you'll have to
tell me exactly what to do, and turnaround may be on the slow side.

thanks,
Tom
