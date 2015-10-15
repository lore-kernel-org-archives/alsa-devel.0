From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: firewire-lib: schedule work again when MIDI
 substream has rest of MIDI messages
Date: Thu, 15 Oct 2015 10:04:18 +0300
Message-ID: <20151015070418.GA7076@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 9983F265E28
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 09:04:27 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: o-takashi@sakamocchi.jp
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi Sakamoto,

This is a semi-automatic email about new static checker warnings.

The patch e8a40d9bcb23: "ALSA: firewire-lib: schedule work again when 
MIDI substream has rest of MIDI messages" from Oct 9, 2015, leads to 
the following Smatch complaint:

sound/firewire/lib.c:88 async_midi_port_callback()
	 error: we previously assumed 'substream' could be null (see line 77)

sound/firewire/lib.c
    76	
    77		if (rcode == RCODE_COMPLETE && substream != NULL)
                                               ^^^^^^^^^^^^^^^^^
Existing code assumes substream can be NULL.

    78			snd_rawmidi_transmit_ack(substream, port->consume_bytes);
    79		else if (!rcode_is_permanent_error(rcode))
    80			/* To start next transaction immediately for recovery. */
    81			port->next_ktime = ktime_set(0, 0);
    82		else
    83			/* Don't continue processing. */
    84			port->error = true;
    85	
    86		port->idling = true;
    87	
    88		if (!snd_rawmidi_transmit_empty(substream))
                                                ^^^^^^^^^
Patch adds an unchecked dereference (inside the function call).

    89			schedule_work(&port->work);
    90	}

regards,
dan carpenter
