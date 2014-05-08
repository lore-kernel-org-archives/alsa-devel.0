From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH]: snd_seq_virmidi.c do not use running
 status for virmidi raw input
Date: Thu, 08 May 2014 22:08:05 +0200
Message-ID: <536BE425.1070701@ladisch.de>
References: <536A7104.7010009@gmx.de> <536A9A70.4020401@ladisch.de>
 <536B1D63.8000909@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 030EB261684
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 22:08:25 +0200 (CEST)
In-Reply-To: <536B1D63.8000909@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ralfbeck1@gmx.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ralf Beck wrote:
> Am 07.05.2014 22:41, schrieb Clemens Ladisch:
>> This is a bug in Bitwig.
>
> I agree, but see above. I can't change Bitwig.

You can submit a bug report.

>> And changing this setting might introduce regressions in other programs that rely on the size of the raw MIDI data.
>
> Being able to receive MIDI data with running status disabled is mandatory for a midi client.
> So any client relying on running status always on would be buggy.

As buggy as Bitwig?

If there is a conflict between two API behaviours, avoiding regressions wins.
Bitwig has no excuse; it has been buggy from the beginning.

> Would the patch be acceptable, if i make switching on/off of running status selectable by a module parameter
> with the current behaviour being the default?

A module parameter would be worse.


Regards,
Clemens
