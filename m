From: Robin Gareus <robin@gareus.org>
Subject: Re: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
 algorism to multiplex PCM samples
Date: Mon, 16 Mar 2015 18:13:31 +0100
Message-ID: <55070F3B.7000509@gareus.org>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.219])
 by alsa0.perex.cz (Postfix) with ESMTP id 30A0A26145B
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 18:13:44 +0100 (CET)
In-Reply-To: <55070409.8090107@sakamocchi.jp>
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

On 03/16/2015 05:25 PM, Takashi Sakamoto wrote:
[..]
> 
> We can see the data in 7th MBLA data channel influences data in next
> data block (data block is represented as 'frame' in driver code). The
> pattern is what you discovered. In my understanding, this is the lack of
> my implementation.
> 
> Do you mean this issue?
> 

yes, precisely.

Though from the information Damien sent me it looked like it wraps
around in the current frame, rather then progress to the next..

Anyway, in this case the original code at
https://github.com/x42/003amdtp is also wrong and the driver will have
to allocate space for the state and retain it for subsequent calls.
Using a static on the stack won't work in case someone has multiple of
those devices.

best,
robin
