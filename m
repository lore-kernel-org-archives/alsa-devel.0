From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [FFADO-devel] [PATCH 05/44] firewire-lib: Add
 support for MIDI capture/playback
Date: Wed, 02 Apr 2014 21:58:25 +0200
Message-ID: <533C6BE1.2050807@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-6-git-send-email-o-takashi@sakamocchi.jp>
 <533C6510.7000605@ladisch.de> <20140402194255.GZ12365@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 31378265519
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 21:58:31 +0200 (CEST)
In-Reply-To: <20140402194255.GZ12365@ltw.loris.tv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Adrian Knoth wrote:
> On Wed, Apr 02, 2014 at 09:29:20PM +0200, Clemens Ladisch wrote:
>
>>> +		len = b[0] - 0x80;
>>> +		if ((len > 1) &&  (3 < len) && (s->midi[port]))
>>
>> This condition is true only for len==2.
>
> I don't know if len can be larger than 3. If so, the condition requires
> len to be at least 4.

Oops, you're right.  (The goal is do detect 1..3.)


Regards,
Clemens
