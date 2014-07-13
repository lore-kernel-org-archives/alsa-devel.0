From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: C-Media USB Audio Device (0d8c:000c) volume scale
Date: Sun, 13 Jul 2014 22:25:28 +0200
Message-ID: <53C2EB38.6030500@ladisch.de>
References: <1651150.0tgDBQbzXi@alexander-nb.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0B3952610A6
 for <Alsa-devel@alsa-project.org>; Sun, 13 Jul 2014 22:26:17 +0200 (CEST)
In-Reply-To: <1651150.0tgDBQbzXi@alexander-nb.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Schlarb <alexander-alsa@xmine128.tk>, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alexander Schlarb wrote:
> I have a DeLock USB audio device with an C-Media audio chip. When changing the
> volume in alsamixer there is no problem, but when changing the volume through
> any PulseAudio frontend (in my case either pavucontrol or veromix-plasmoid),
> all volumes below 30% in the GUI are shown as 0% in alsamixer and no sound is
> played.
> The PulseAudio wiki[2] blames this on ALSA for exporting incorrect dB
> information. However there is a StackExchange answer[3] which suggests adding
> the parameter ignore_dB=1 in /etc/pulse/default.pa which fixed the issue, so
> I'm not sure if this is indeed ALSAs fault?

ALSA exports the dB information that is reported by the device.

It might be possible to override this information in the driver if you
can determine what the actual mapping between raw mixer values and dB
is.


Regards,
Clemens
