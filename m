From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: using all channels of RME Babyface Pro in
	class	compliant mode
Date: Thu, 10 Dec 2015 09:45:04 +0100
Message-ID: <56693B90.6040707@ladisch.de>
References: <56691C16.3050206@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 3D614261A57
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 09:45:06 +0100 (CET)
In-Reply-To: <56691C16.3050206@gmx.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Be <be.0@gmx.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Be wrote:
> /proc/asound/card1/stream0
> Playback:
>     Channels: 2
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000
>     Channels: 12
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000
> Capture:
>     Channels: 12
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000
>     Channels: 2
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000

This device supports either two or twelve channels.
Tell your program to use twelve, not four, channels.


Regards,
Clemens
