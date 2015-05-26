From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: ALSA: firewire-lib: pass the number of data blocks
 in incoming packets to outgoing packets
Date: Tue, 26 May 2015 23:46:22 +0900
Message-ID: <5564873E.9020409@sakamocchi.jp>
References: <20150526084924.GA25178@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id AD91D261469
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 16:46:28 +0200 (CEST)
In-Reply-To: <20150526084924.GA25178@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Dan,

On May 26 2015 17:49, Dan Carpenter wrote:
> Hello Takashi Sakamoto,
> 
> The patch 6fc6b9ce41c6: "ALSA: firewire-lib: pass the number of data
> blocks in incoming packets to outgoing packets" from May 22, 2015,
> leads to the following static checker warning:
> 
> 	sound/firewire/amdtp.c:857 in_stream_callback()
> 	warn: unsigned 'data_blocks' is never less than zero.
> 
> sound/firewire/amdtp.c
>    855  
>    856                  data_blocks = handle_in_packet(s, payload_quadlets, buffer);
>    857                  if (data_blocks < 0) {
>                             ^^^^^^^^^^^^^^^
> Never true.  But handle_in_packet() does return negative error codes.
> 
>    858                          s->packet_index = -1;
>    859                          break;
>    860                  }
>    861  

Exactly. And this is a cause of my system hangup. Under compiler
optimization, the condition statement is removed and error handling is
not executed...

Thanks for your indication!


Takashi Sakamoto
