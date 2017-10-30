From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: "PM / QoS: Fix device resume latency PM QoS"
	breaks sound
Date: Tue, 31 Oct 2017 00:36:59 +0100
Message-ID: <fc59ffc4-f103-b572-a8b1-9ae817b280c9@intel.com>
References: <6e4896f5-46ea-4b58-3b51-4ccde11ade04@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id B073A266CED
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 00:36:59 +0100 (CET)
In-Reply-To: <6e4896f5-46ea-4b58-3b51-4ccde11ade04@googlemail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chris Clayton <chris2553@googlemail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/28/2017 10:10 PM, Chris Clayton wrote:
> Hi,
>
> I pulled the latestchanges from Linus' tree this evening and have found that with the new kernel, sound is not working
> on my laptop. More precisely, the built-in speakers don't produce any sound. Sound does work when I use ear-plugs in the
> headphone socket. It also works via a bluetooth speaker.

This patch should fix it: https://patchwork.kernel.org/patch/10032147/

Thanks,
Rafael
