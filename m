From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: alsa-lib plugin for bluetooth
Date: Mon, 29 Nov 2004 22:49:11 +0100
Message-ID: <1101764951.7562.47.camel@pegasus>
References: <41AB969E.3020709@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.holtmann.net (coyote.holtmann.net [217.160.111.169])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 38B642B7
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 22:49:16 +0100 (MET)
In-Reply-To: <41AB969E.3020709@xmission.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brad Midgley <bmidgley@xmission.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Brad,

> Does the card,dev,subdev device description map well to bluetooth? Would 
> it be bluetooth-adapter,headset,service or something like that?

you can define a PCM in your local .asoundrc and then let it be handled
by an externel library extension like this:

	pcm.headphone {
	        type a2dp
	        bdaddr "00:0B:0D:50:12:10"
	}

This requires a dynamic library called libasound_module_pcm_a2dp.so
under /usr/lib/alsa-lib/.

The problem is that it is impossible to create a library extension
outside the ALSA source tree. The reason is mostly a missing include or
the dependencies on pcm_local.h.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
