From: Mark Brand <mark.brand@nmmu.ac.za>
Subject: gitcompile fails
Date: Tue, 03 Jun 2014 16:20:08 +0200
Message-ID: <538DD998.1050904@nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay06.smp.mweb.co.za (relay06.smp.mweb.co.za [196.28.80.26])
 by alsa0.perex.cz (Postfix) with ESMTP id C5A5326162E
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 16:20:19 +0200 (CEST)
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

Fresh git clones of alsa-driver and alsa-kmirror produce a ./gitcompile 
failure for me:

ln -s ../../alsa-kernel/include/pcm-indirect.h
cp ../../alsa-kernel/include/pcm.h .
patch -p0 -i pcm.patch pcm.h
patching file pcm.h
Hunk #1 FAILED at 280.
Hunk #2 succeeded at 291 (offset -3 lines).
[snip]
Hunk #11 succeeded at 566 (offset -4 lines).
1 out of 11 hunks FAILED -- saving rejects to file pcm.h.rej
make[3]: *** [pcm.h] Error 1
make[3]: Leaving directory 
`/home/mark/workspace/alsa/alsa-driver/alsa/include/sound'

Since I've seen this before 
(http://mailman.alsa-project.org/pipermail/alsa-devel/2012-July/053419.html), 
would I be forgiven for assuming that this is once again as a result of 
a mismatch between alsa-driver and alsa-kmirror?  Any suggestion will be 
much appreciated, thank you.

Mark Brand.
