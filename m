From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [PATCH RFC 0/6] ASoC: sgtl5000: fix use of
 regulators and internal LDO
Date: Fri, 06 Mar 2015 16:31:28 -0700
Message-ID: <54FA38D0.1060203@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <54FA2F03.2060804@boundarydevices.com>
 <20150306225337.GH8656@n2100.arm.linux.org.uk>
 <54FA3122.9050805@boundarydevices.com> <54FA3542.1010402@boundarydevices.com>
 <20150306232429.GI8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id F3C6A26609F
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 00:31:33 +0100 (CET)
Received: by paceu11 with SMTP id eu11so41307262pac.1
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2015 15:31:32 -0800 (PST)
In-Reply-To: <20150306232429.GI8656@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

Hi Russell,

On 03/06/2015 04:24 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 06, 2015 at 04:16:18PM -0700, Eric Nelson wrote:
>> Hi Russell,
>>
>> <snip>
>>
>> I'm not sure why the code above is needed though.
>>
>> Do you know what sequence of events causes this to fail?
> 
> All that I remember is that as the mainline code stood in 3.19 etc,
> the SGTL5k would be partially detected and then I2C communication
> with it was lost.  Probing the pins with a scope showed that it had
> basically lost power.
> 
> The patch above is over a year old now, and I don't remember much
> more detail than that.
> 
> I'm not going to be physically in a state where I can look at it for
> about a week and a bit, sorry.
> 

No worries. I appreciate the feedback.
