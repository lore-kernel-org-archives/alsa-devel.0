From: Florian Faber <faber@faberman.de>
Subject: Re: alsa midi tutorial
Date: Thu, 12 Jun 2008 17:57:48 +0200
Message-ID: <200806121757.49050.faber@faberman.de>
References: <48514480.90802@earthsong.free-online.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de
	(static-ip-85-25-152-101.inaddr.intergenia.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 922BB24A44
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 17:57:49 +0200 (CEST)
In-Reply-To: <48514480.90802@earthsong.free-online.co.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Andy,

> What I want to do is feed drum trigger signals from an arduino board
> (a usb development board that lets you interface electronics to the
> computer) to a midi sequencer.

Why do you need to go through the computer for this? You can use the 
arduino's serial port to send and receive MIDI commands. It's really 
simple and there are tons of projects on the web that do exactly that.

> I had a look at the following page from the alsa api reference:
>
> http://www.alsa-project.org/alsa-doc/alsa-lib/seq.html
>
> but I'm finding it a bit hard to follow - I'm looking for something a
> bit simpler with code examples to work through that will give me a
> way in to alsa midi programming.
>
> Does anyone know of anything like this?

No, but that's the wrong page. For sending MIDI data you simply open the 
device (snd_rawmidi_open) and send your commands (snd_rawmidi_write).


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
