From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Digidesign Eleven Rack support
Date: Thu, 31 Oct 2013 17:14:18 +0100
Message-ID: <527281DA.7060305@ladisch.de>
References: <loom.20131031T120700-144@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 799D226570F
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 17:14:49 +0100 (CET)
In-Reply-To: <loom.20131031T120700-144@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Aidan Schurr <aidan.schurr@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Aidan Schurr wrote:
> Hi guys, am wondering if support for the Digidesign Eleven Rack is on the
> cards for the future at all?

The latest kernel (version 3.11) will recognize the PCM inputs/outputs,
but still has bugs.  To remove those, wait for kernel 3.13 or compile
your own kernel from sound.git.


Regards,
Clemens
