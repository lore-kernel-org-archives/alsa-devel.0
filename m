From: Dejay <alsa@dclayton.com>
Subject: Translating USB device names to ALSA client numbers
Date: Mon, 29 Aug 2016 17:25:32 -0400
Message-ID: <1472505932.3679045.709655473.18074466@webmail.messagingengine.com>
References: <1472252453.1070452.707423985.19A2B395@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id F420E260506
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 23:25:33 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 426C6206AB
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 17:25:33 -0400 (EDT)
In-Reply-To: <1472252453.1070452.707423985.19A2B395@webmail.messagingengine.com>
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

Hello,

I'm trying to write some udev wrappers to automatically connect USB MIDI devices to each other.  My logic could be really robust if I had a way of mapping ALSA client numbers (e.g. from 'aconnect -l', such as '20:0') to physical USB devices (either by bus ID, /dev/ symlink name, /proc/asound/ files, etc.)  My ultimate goal is so that when a udev rule executes upon hotplugging a MIDI device, I can reference that MIDI device by client number and then execute an aconnect command.  Thus, I need some way to map USB device information to the ALSA client numbers that get reported by aconnect.

Is there any way to accomplish this?  I tried to review the ALSA source code, but my eyes got jumbly after awhile.

Thanks,
Dejay 
