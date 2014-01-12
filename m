From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Sample program for hwdep interface
Date: Mon, 13 Jan 2014 00:26:19 +0900
Message-ID: <52D2B41B.7090505@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
 <52B45837.2080804@sakamocchi.jp> <20131221101123.GA17855@marvin.atrad.com.au>
 <52C93F8B.1010701@sakamocchi.jp> <20140112142230.4aacdc9e@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D0432618F2
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 16:26:23 +0100 (CET)
In-Reply-To: <20140112142230.4aacdc9e@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

 > another alternative would be to implement sharing/multiplexing of the
 > EFC response address range in firewire-core, like it is implemented
 > for FCP_COMMAND and FCP_RESPONSE.  Not sure if it is wise to share
 > nonstandard address ranges though.

Currently I'm considering to use AV/C-command-based EFC in kernel-land. 
Fireworks has a face of GenericAVC and commands with issue may be 
replaced with some AV/C commands for a few purposes (but I have never 
checked my idea).

I need more time for this issue.

And, just from my curiosity, is your solution allowed by related 
specifications such as OHCI1394 or IEEE1394? I have a little 
knowledgement about these specification.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
