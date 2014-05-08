From: Ralf Beck <musical_snake@gmx.de>
Subject: Re: [PATCH]: snd_seq_virmidi.c do not use running
 status for virmidi raw input
Date: Thu, 08 May 2014 08:00:03 +0200
Message-ID: <536B1D63.8000909@gmx.de>
References: <536A7104.7010009@gmx.de> <536A9A70.4020401@ladisch.de>
Reply-To: ralfbeck1@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DEA426549F
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 08:00:04 +0200 (CEST)
In-Reply-To: <536A9A70.4020401@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 07.05.2014 22:41, schrieb Clemens Ladisch:
> Ralf Beck wrote:
>> Rationale: Not every rawmidi alsa client (e.q. Bitwig) support 
>> running status on input. 
> Why does Bitwig use RawMIDI when it is only interested in the events? 
Its a closed source application. I'm not the author, so cannot change 
the application,
but i can change the virmidi code.
> Anyway, running status is part of the MIDI protocol. This is a bug in 
> Bitwig. 
I agree, but see above. I can't change Bitwig.

> And changing this setting might introduce regressions in other 
> programs that rely on the size of the raw MIDI data.
Being able to receive MIDI data with running status disabled is 
mandatory for a midi client.
So any client relying on running status always on would be buggy.

Would the patch be acceptable, if i make switching on/off of running 
status selectable by a module parameter
with the current behaviour being the default?
>> + vmidi->parser->nostat = 1; vmidi->seq_mode = rdev->seq_mode; 
> The patch formatting is still broken. 
I'll look into that.
> And please read Documentation/SubmittingPatches, I'l look into that.

I'l look into that.

Regards
Ralf
>
> Regards, Ralf
