From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Broken IRQs on BayTrail devices
Date: Mon, 25 Apr 2016 08:15:15 -0500
Message-ID: <571E1863.9090202@linux.intel.com>
References: <571D8633.9050707@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 96E72264F39
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 15:15:28 +0200 (CEST)
In-Reply-To: <571D8633.9050707@airwebreathe.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joel Holdsworth <joel@airwebreathe.org.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/24/16 9:51 PM, Joel Holdsworth wrote:
> Dear All,
>
> I've been working on a kernel patch for a firmware IRQ quirk issue that
> affects multiple Intel Atom Bay-Trail boards:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=117141
>
> If you have a Bay Trail device with non-functioning sound, can you
> attach the DSDT and dmidecode output to the bug so I can investigate
> whether the quirk affect your device.

The IRQ fix is not enough to get sound on Baytrail-CR devices. You need 
to also swap SSP2 with SSP0 due to a package change, which is not 
supported with the 'older' byt-rt5640 driver so that's a dead-end - 
sorry. There are Intel patching coming for the bytcr-rt5640 to model all 
the possible routing and quirks, stay tuned.
