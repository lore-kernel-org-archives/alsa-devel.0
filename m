From: robert.devanna@nospammail.net
Subject: Re: After kernel upgrade to v ~~> 4.1.0, no audio
 output unless UNPLUG/RE-PLUGIN of audio jack on card;
 OK with earlier kernels
Date: Sat, 18 Jul 2015 14:22:18 -0700
Message-ID: <1437254538.1244332.327145681.21B320E8@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4623A2604FA
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2015 23:22:19 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 787F92075F
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2015 17:22:18 -0400 (EDT)
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

On Mon, Jul 6, 2015, at 01:46 AM, Takashi Iwai wrote:
> It's a known problem with VIA codecs, and the fix was already merged
> in 4.2-rc1, the commit 735c75cf4d434862e38c01dcfb2ce8d2fcb9035f.
> The next stable 4.1.x kernel should contain the fix.

Upgraded to 

 uname -rm
  4.1.2-1.g5ccacb4-desktop x86_64

Fyi, the problem remains unchanged.  To get sound, a physical unplug/replug is required.
