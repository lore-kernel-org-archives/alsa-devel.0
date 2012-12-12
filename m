From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bug in aplay?
Date: Wed, 12 Dec 2012 14:01:05 +0100
Message-ID: <50C88011.8070302@ladisch.de>
References: <CABXa2sHAWX-q=tpMdLqJSXbu-kNeuuhhPY5UQ41qKQ+SisD=Rg@mail.gmail.com>
 <s5h38zbh557.wl%tiwai@suse.de>
 <CABXa2sEdsWcT8Prq59mTO6szeSvO9-AD6Me=gPF3-wpAGgHB9A@mail.gmail.com>
 <50C87185.6030008@ladisch.de>
 <CABXa2sHoAuhR=HWp-_0PqQoLb0Z=dXE85C52c8fkyDMMWc=JCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id A4B592616CE
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 14:01:07 +0100 (CET)
In-Reply-To: <CABXa2sHoAuhR=HWp-_0PqQoLb0Z=dXE85C52c8fkyDMMWc=JCg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Damien Zammit wrote:
> I wish to record and playback streams from my sound card which uses 24
> bit big endian format, but I do not wish to resample it.

You get resampling only if the sample rates do not match.


Regards,
Clemens
