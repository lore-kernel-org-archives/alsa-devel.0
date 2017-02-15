From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Fwd: Re: [PATCH v6 1/1] ALSA: Tascam US-16x08 DSP
 mixer quirk
Date: Wed, 15 Feb 2017 18:37:59 +0100
Message-ID: <b4fef4c6-9dc9-dfbc-bc2e-7cf2e262a645@ladisch.de>
References: <201702152346.f2qgk7s0%fengguang.wu@intel.com>
 <9f0131bf-1bf2-1488-ef24-831612447fa2@paraair.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id CD13F266D02
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 18:39:08 +0100 (CET)
In-Reply-To: <9f0131bf-1bf2-1488-ef24-831612447fa2@paraair.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Detlef Urban <onkel@paraair.de>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Detlef Urban wrote:
> It seems that my approach to add names to snd_ctl_elem_info enumeration is wrong (see bleow).

You don't add names, you set a single name.
Anyway, just call snd_ctl_enum_info().


Regards,
Clemens
