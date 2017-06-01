From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: cht_bsw_rt5645 mostly silent
Date: Thu, 1 Jun 2017 09:44:59 -0700
Message-ID: <5fb2f1ba-71d9-f9f1-dcbe-b7fae975427c@linux.intel.com>
References: <20170601065304.GJ31785@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 414BB266C87
 for <alsa-devel@alsa-project.org>; Thu,  1 Jun 2017 18:45:01 +0200 (CEST)
In-Reply-To: <20170601065304.GJ31785@us.netrek.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Cameron <quozl@laptop.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/31/17 11:53 PM, James Cameron wrote:
> G'day,
>
> I've a laptop on my lab bench with a Realtek ALC5645 codec attached to
> an Intel(R) Atom(TM) x5-Z8350.  Built-in speakers work properly.  Not
> working are;
>
> - headphones; only ever silent playback,
>
> - built-in microphone; only ever silent recording,
>
> - headset microphone; only ever silent recording,
>
> - there is no response to headset jack insertion or removal,
>
> It has never worked.
>
> http://www.alsa-project.org/db/?f=f14914c88544d57f736ed6623000957c93bc4612
> http://dev.laptop.org/~quozl/z/1dCw32.txt dmesg
> http://dev.laptop.org/~quozl/z/1dD2qx.txt dmidecode
> http://dev.laptop.org/~quozl/z/1dGJdK.txt dsdt.dsl
>
> I'm testing with 4.11.1 kernel on Ubuntu 17.04.
>
> I've tried latest UCM/chtrt5645/HiFi.conf c8b344c.
>
> I've tried using alsamixer to experiment with some of the 253 or so
> controls.
>
> I don't have a datasheet.  (My previous work was with ALC5631, for
> which I do have a datasheet, and it was very helpful!)
>
> Also in the box was an NTC thermistor cabled to a TRRS plug, which may
> suggest a design with switchable decoupling capacitors.

I've tested a Realtek rt5645 eval board connected to a MinnowBoard Max 
without issues, the headset worked fine. You can look at example mixer 
settings at https://github.com/plbossart/UCM/tree/master/chtrt5645 or
in the attachments of https://bugzilla.kernel.org/show_bug.cgi?id=95681
