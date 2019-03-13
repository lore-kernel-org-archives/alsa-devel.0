From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: opening rawmidi on user ports
Date: Wed, 13 Mar 2019 14:48:51 +0900
Message-ID: <20190313054850.GA13393@workstation>
References: <9c82e740-a327-3809-875c-3eb4f01945e8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF895F8961E
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 06:48:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9c82e740-a327-3809-875c-3eb4f01945e8@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: AlGrenadine <a.granvaud@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Mar 12, 2019 at 05:19:38PM +0100, AlGrenadine wrote:
> I use btmidi-server from the bluez stack, which creates user ports to send
> and receive midi via bluetooth.
> I can't manager which parameter string i must provide to snd_rawmidi_open
> function, can you help ?
> 
> (of course the user ports don't appear in amidi -l)
> I only have a client and port ids (128:0) when using aconnect -l

As long as reading code of 'btmidi-server'[1], it uses ALSA sequencer
interface. You need to use ALSA sequencer APIs instead of ALSA rawmidi
APIs. Some tools will assist your work; 'aseqdump' and 'aplaymidi' in
'alsa-utils' repository[2].

[1] https://github.com/oxesoft/bluez/blob/midi/tools/btmidi-server.c
[2] https://git.alsa-project.org/?p=alsa-utils.git

Regards

Takashi Sakamoto
