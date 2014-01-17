From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ProVideo PV 918A - audi o device created but
 cannot capture sound
Date: Fri, 17 Jan 2014 11:08:19 +0100
Message-ID: <52D90113.50406@ladisch.de>
References: <loom.20140117T085941-825@post.gmane.org>
 <52D8EE31.4000304@ladisch.de>
 <57064bdb1c580b864c735a01d0d4bdea@imap.greenearthnetwork.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2705A265090
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 11:08:22 +0100 (CET)
In-Reply-To: <57064bdb1c580b864c735a01d0d4bdea@imap.greenearthnetwork.in>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: siddharth <siddharth@greenearthnetwork.in>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

siddharth wrote:
> For capturing, I used vlc alsa://hw:1,1 I also tried 1,0, 2,0 2,1 etc.

It's possible that the tuner does not output anything unless it is actually
tuned to something, i.e., you need to run video capture.

> Am not sure how the card hardware is constructed

Then it's likely that it's not possible to record the sound that way.


Regards,
Clemens
