From: Dan O'Donovan <dan@emutex.com>
Subject: CherryTrail SST firmware limitations query
Date: Thu, 21 Jan 2016 23:10:50 +0000
Message-ID: <56A1657A.5060600@emutex.com>
References: <56A162A1.1070602@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bert.emutex.com (bert.emutex.com [91.103.1.109])
 by alsa0.perex.cz (Postfix) with ESMTP id C7DFA2606BA
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 00:10:51 +0100 (CET)
In-Reply-To: <56A162A1.1070602@emutex.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(Sorry, re-sending as I wasn't subscribed to the alsa-devel mailing list 
on my previous attempt)

Hi Vinod

I am currently attempting to use the SSP0 port on an Intel X5-Z8300 SoC 
(Cherry Trail) with a new codec.

I have seen that you have committed SST firmware 'fw_sst_22a8.bin' and 
related SST audio soc drivers in the past, so I hope you don't mind if I 
ask you some questions about it here.

Primarily, I am wondering if there are any limitations imposed by that 
firmware binary that I need to be aware of. I haven't been able to find 
much information about what this firmware does or doesn't support.

For example, existing CHT SST machine drivers suggest that the PCM bit 
clock is fixed at 19.2MHz.
Also, I am wondering if all SSP ports on the SoC are supported by that 
firmware, or if it is limited to just SSP2?

Are there any other limitations that I may need to be aware of in the 
firmware (or in the SSP back-end driver) when attempting to connect a 
new codec (TI PCM5122 initially) to SSP0.

Many thanks in advance for any help/advice you can provide.

Best regards,
-Dan
