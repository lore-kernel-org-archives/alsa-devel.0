From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Playback - Overwrite buffer with silence
Date: Sat, 11 Apr 2015 22:05:02 +0200
Message-ID: <55297E6E.20302@ladisch.de>
References: <5529421B.7050601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 756A2260434
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 22:05:22 +0200 (CEST)
In-Reply-To: <5529421B.7050601@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nilhcraiv <nilhcraiv@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nilhcraiv wrote:
> If I obtain the boundary for ring pointers in frames at the start (snd_pcm_sw_params_get_boundary), the boundary is always zero.

It is impossible for the boundar to be zero.

> Here you can see a light version of my code (without error checking):

Error checking would be important.


Regards,
Clemens
