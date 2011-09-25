From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Adding ELD control to alsa-lib hdmi device
Date: Sun, 25 Sep 2011 11:44:23 +0200
Message-ID: <4E7EF7F7.1090100@canonical.com>
References: <1316793246-819-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<000901cc7a21$0a3bea70$1eb3bf50$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id DA944244FB
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Sep 2011 11:44:24 +0200 (CEST)
In-Reply-To: <000901cc7a21$0a3bea70$1eb3bf50$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/23/2011 08:46 PM, Pierre-Louis Bossart wrote:
> Hi,
> Now that I almost done with exposing a read-only ELD control for HDA/HDMI
> outputs, I was wondering how to read it from user-land. PulseAudio and
> others rely on the 'hdmi' device, and apparently I can't access this new ELD
> control, I have to use the 'hw:x,y' details.

The hdmi:x(,y) device is only used for pcm. For opening the mixer, hw:x 
(never hw:x,y - that's pcm only as well) is used as the device string.

> I really don't understand much to alsa-lib... Can I expose this new control
> through the ALSA configuration files where the hdmi device is defined? Or is
> there a way to infer the card and device number actually used by an alsa-lib
> plugin? Or do I have to add code to propagate the information from
> hardware-level to higher-level plugins?
> Thanks for your feedback!

I'm not the expert here, but if I were you, I would run

amixer -D hw:x contents
amixer -D hw:x scontents

To see if your controls show up there. If it shows up in scontents, that 
would be the "simple" mixer interface that PulseAudio uses. If not, 
using the control api (as being done by "contents") should work.

Anyway, reading the source code to amixer would then be the first step 
towards understanding how to enumerate and read mixer controls.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
