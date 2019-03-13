From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: opening rawmidi on user ports
Date: Wed, 13 Mar 2019 14:37:02 +0100
Message-ID: <16e0299a-549b-951b-a3e9-5d70be8b3ad5@ladisch.de>
References: <9c82e740-a327-3809-875c-3eb4f01945e8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0519DF80799
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 14:37:03 +0100 (CET)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id B791F5583933
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 14:37:02 +0100 (CET)
In-Reply-To: <9c82e740-a327-3809-875c-3eb4f01945e8@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

AlGrenadine wrote:
> I use btmidi-server from the bluez stack, which creates user ports to send and receive midi via bluetooth.
> I can't manager which parameter string i must provide to snd_rawmidi_open function, can you help ?

Load the snd-virmidi module to get a bridge between raw MIDI ports and sequencer ports.


Regards,
Clemens
