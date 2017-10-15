From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Surface 3 audio broken between 4.11 and 4.13
 (rt5645)
Date: Sun, 15 Oct 2017 05:41:48 +0200
Message-ID: <1508038908.5910.54.camel@hadess.net>
References: <1507920036.5910.46.camel@hadess.net>
 <5f93009c-e41a-f339-442a-cf5a757460cc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A9D4266A0C
 for <alsa-devel@alsa-project.org>; Sun, 15 Oct 2017 05:41:51 +0200 (CEST)
In-Reply-To: <5f93009c-e41a-f339-442a-cf5a757460cc@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey Pierre-Louis,

On Fri, 2017-10-13 at 18:49 -0500, Pierre-Louis Bossart wrote:
> 
> On 10/13/2017 01:40 PM, Bastien Nocera wrote:
> > Hey,
> > 
> > As I was trying to test PulseAudio HDMI LPE audio support fixes, I
> > realised that the internal sound card of my Surface 3 wasn't
> > working
> > anymore, using the same user-space configuration.
> > 
> > Looks like detection of the device regressed between 2 versions.
> > Does
> > this look familiar to anyone, or should I start bisecting? (which
> > will
> > take me absolutely ages, as the CPU is anemic on that machine)
> 
> Yes this looks familiar unfortunately. Surface has a BIOS quirk
> iirc, 
> and there are reports of broken audio on other platforms that have a 
> similar quirk, see
> https://bugzilla.kernel.org/show_bug.cgi?id=96691 where the patch 
> 7827d66946ad3af734ed46d1d68c23fa6974595c is flagged as being the
> issue.
> 
> I tried providing a patch for what I think is the problem, but the 
> reports from users were inconsistent and I don't have access to the 
> hardware.
> 
> If you could try both the revert and the suggested fix (separately)
> it'd 
> help a great deal

I compiled 2 test kernels with each one of those patches, tested them
both and added the results to the bug.

Did you want to continue the discussion here, or should I add that
information to the (rather long-winded) bug?

Cheers
