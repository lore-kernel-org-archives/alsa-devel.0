From: Robin Gareus <robin@gareus.org>
Subject: Re: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
 algorism to multiplex PCM samples
Date: Tue, 17 Mar 2015 14:37:10 +0100
Message-ID: <55082E06.6010008@gareus.org>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
 <55070F3B.7000509@gareus.org> <55075D65.20406@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.216])
 by alsa0.perex.cz (Postfix) with ESMTP id A4572264F0F
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 14:37:26 +0100 (CET)
In-Reply-To: <55075D65.20406@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, damien@zamaudio.com, clemens@ladisch.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On 03/16/2015 11:47 PM, Takashi Sakamoto wrote:

Hi Takashi,

> This is another sample, with the last four data blocks in a CIP and the
> first four data blocks in next CIP. You can see the continuous value in
> data-block-counter (dbc) field in each CIP header.
> 

[snip]

> We can see the pattern is carried to the data block in next packet. But
> current implementation is not good for this case.


Indeed, thanks for the heads up.

I've just updated https://github.com/x42/003amdtp/ accordingly.

You'll have to retain the state and reset it on open/re-start but that's
part of driver integration.

Cheers!
robin
