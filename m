From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/2] RFC: support for audio wall clock
Date: Fri, 20 Jul 2012 14:57:38 -0500
Message-ID: <5009B832.5060802@linux.intel.com>
References: <1340917955-31422-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <CAN8cciZR73c74p6yTDn7qu4CKJUC_o7d4mwQthFmAtC9j3SzVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EA7626535F
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 21:57:38 +0200 (CEST)
In-Reply-To: <CAN8cciZR73c74p6yTDn7qu4CKJUC_o7d4mwQthFmAtC9j3SzVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Manuel Jander <manuel.jander@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/29/2012 8:03 PM, Raymond Yau wrote:
> Do suspsend/resume affect the usage of the wall clock ? Those au88x0 
> also have a 32 bit register which return the ticks from a 12.288 Mz 
> oscillator (i.e. 256 x 48000Hz) , this register wrap around in around 
> 349.5 seconds Can this clock be used to determine the drift too ? 

In theory any clock can be used, as long as it's synchronous with the 
bitclock used in the serial stream. I am planning to use our 19.2 MHz 
clock on non HDAudio platforms, a 12.288 would work at well. The cycle 
count will be translated to ns, the initial clock base has a marginal 
impact on the result.
I haven't validated anything related to suspend/resume. It should work 
if the trigger is invoked on resume where the audio wallclock is 
reinitialized with the system time
-Pierre
