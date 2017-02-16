From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v8 1/1] ALSA: Tascam US-16x08 DSP mixer
	quirk
Date: Thu, 16 Feb 2017 11:42:02 +0100
Message-ID: <6cc1f011-dd59-c205-633b-fc6ac8c5fe75@ladisch.de>
References: <1487238522-4421-1-git-send-email-onkel@paraair.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0929E266FCD
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 11:42:04 +0100 (CET)
In-Reply-To: <1487238522-4421-1-git-send-email-onkel@paraair.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: OnkelDead <onkel@paraair.de>, alsa-devel@alsa-project.org
Cc: tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

OnkelDead wrote:
> +const char *route_names[] = {

The strings are const, but the array is not.  This should be

  static const char * const route_names[] = { ...

There are lots of other static variables that probably can be const.


Regards,
Clemens
