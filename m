From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Rane SL-4 USB sound card
Date: Tue, 07 Jul 2015 09:23:36 +0200
Message-ID: <559B7E78.3080906@ladisch.de>
References: <5597A9AE.2090002@gmail.com>	<55996A35.6030904@ladisch.de>	<559A77B5.5060905@gmail.com>	<559A7D98.7000707@ladisch.de>
 <559B6580.706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id EDBD1261490
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 09:23:37 +0200 (CEST)
In-Reply-To: <559B6580.706@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tuukka Pasanen <pasanen.tuukka@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tuukka Pasanen wrote:
> I've tested Quirck and it worked (at least channels 1-2 input/output) fine when changed S24_LE.
> Problem is that currently it doesn't have Mixer

According to the descriptors, it does not have mixer controls.
Does the Windows driver have mixer controls that affect the hardware?

> so pulseaudio or jackd can't see it without .asoundrc.

That should make no difference.


Regards,
Clemens
