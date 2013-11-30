From: Daniel Wagner <wagi@monom.org>
Subject: Re: [FFADO-devel] [RFC][PATCH 00/13] bebob: a new
 driver for BridgeCo BeBoB based device
Date: Sat, 30 Nov 2013 18:55:29 +0100
Message-ID: <529A2691.4000401@monom.org>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hotel311.server4you.de (hotel311.server4you.de [85.25.146.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ED55A261A4D
 for <alsa-devel@alsa-project.org>; Sat, 30 Nov 2013 18:55:30 +0100 (CET)
In-Reply-To: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 11/23/2013 07:09 AM, Takashi Sakamoto wrote:
> In previous series of patch, I showed enhancement of current firewire-lib. So
> I should show the way to use new functions in each driver side. This driver is
> under development but functionalities for streaming seems to be fixed.  I'm
> happy to receive your comments.

I have tried this series (incl. the bug fix you recommend) on a FA-66. 
While I see some output in alsa-info, pulseaudio didn't pick it up. I
also noted that some logs in the dmesg. I am not sure what is supposed
to work already or not.

Here are my logs

http://www.monom.org/misc/alsa-firewire/2013-11-30

cheers,
daniel
