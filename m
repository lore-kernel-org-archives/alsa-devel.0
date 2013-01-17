From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: libao problem (Re: No dmix/dsnoop on Intel ICH4/5
 by default?)
Date: Thu, 17 Jan 2013 13:12:17 +0100
Message-ID: <50F7EAA1.7040504@ladisch.de>
References: <50F6FF00.7020706@gmail.com> <50F71312.1000009@ladisch.de>
 <50F7D0E3.3020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id BA86C2650BD
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 13:12:20 +0100 (CET)
In-Reply-To: <50F7D0E3.3020401@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org, vorbis-dev@xiph.org
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> I can mix as many streams as I want using just "aplay" but if I start
> by playing one track with "ogg123" (which uses a default, unconfigured
> libao as its backend), I can't start a second ogg123, which then says:
>
> ao_alsa WARNING: Unable to open surround playback.  Trying default device...

The default dmix is for stereo only.  For a surround dmix device, you'd
have to write your own definition.


Regards,
Clemens
