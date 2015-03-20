From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: firewire mixer interface -- was Re: [PATCH 11/11]
	ALSA: digi00x:	apply double-oh-three algorism to multiplex
	PCM samples
Date: Fri, 20 Mar 2015 15:07:56 +0100
Message-ID: <550C29BC.4040909@ladisch.de>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>	<1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>	<5506E7EE.6060300@gareus.org>
 <55070409.8090107@sakamocchi.jp>	<55070F3B.7000509@gareus.org>
 <55075D65.20406@sakamocchi.jp>	<55082E06.6010008@gareus.org>
 <55083103.5030704@gmail.com>	<5508CFA5.7060903@sakamocchi.jp>
 <550AD65F.10803@gareus.org>	<550B51BC.80506@sakamocchi.jp>
 <550C0CFC.4060404@gareus.org>	<550C1FC6.4050700@sakamocchi.jp>
 <550C26BA.3060703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 413DF2655B6
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 15:07:58 +0100 (CET)
In-Reply-To: <550C26BA.3060703@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Robin Gareus <robin@gareus.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Damien Zammit wrote:
> On 21/03/15 00:25, Takashi Sakamoto wrote:
>> Any userspace applications can destroy packet streaming which kernel
>> driver starts, by transaction to streaming-related register.
>>
>> In current implementation of ALSA firewire stack and Linux FireWire
>> subsystem, we cannot avoid this.
>
> Does that mean the mixer control will need root permissions to execute
> in userspace because the /dev/fwX node is usually owned by root?

/dev/fw* of audio devices typically get a different group to allow FFADO
to run.  Whatever software implements these mixer controls (whether it
ends up called FFADO or not) would run with the same permissions.


Regards,
Clemens
