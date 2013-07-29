From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_seq_system_info_get_cur_ports function
Date: Mon, 29 Jul 2013 21:52:49 +0200
Message-ID: <51F6C811.4070501@ladisch.de>
References: <51F4A6C0.1060505@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E6448264F10
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 21:52:54 +0200 (CEST)
In-Reply-To: <51F4A6C0.1060505@yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jose B <jose.cuerv0@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jose B wrote:
> Shouldnt there be a function for getting the current port count as seen below?
>
> snd_seq_system_info_get_cur_ports(const snd_seq_system_info_t *info)

There is no such value:
<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/sound/asequencer.h#n308>

> I was writing a function to quickly check if any new ports were registered
> on the sequencer after the application using the wrapper starts up.

The number of ports is not helpful for detecting all changes.

Subscribe to port 0:1 (SND_SEQ_CLIENT_SYSTEM:SND_SEQ_PORT_SYSTEM_ANNOUNCE) to
receive events for any changes.


Regards,
Clemens
