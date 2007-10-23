From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re:
	=?utf-8?b?562U5aSNOiAgW1JGQ10gQUxTQQlzY2VuYXJpbyBB?= =?utf-8?q?PI?=
Date: Tue, 23 Oct 2007 18:24:42 +0100
Message-ID: <1193160282.7052.326.camel@localhost.localdomain>
References: <24796D40B87E66409C5ABD9733F46E024A467D@mtnex1.mtn.palmsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id E35ED24A1D
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Oct 2007 19:24:43 +0200 (CEST)
In-Reply-To: <24796D40B87E66409C5ABD9733F46E024A467D@mtnex1.mtn.palmsource.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leijin Tang <Leijin.Tang@access-company.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, ohm-devel <ohm-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-10-22 at 18:50 +0800, Leijin Tang wrote:
> Hi
> 
>      Thanks for the Takashi's idea.
> 
>      It's agreement that controlling the scenarios is needed in the
> alsa-lib. To the mobile device, the policy about the router switch or
> volume control is so complex that we can't resolve all issues by
> modified the alsa-lib.
> 
> Whether we can develop a simple server which carries out the policy? 
> 
> But we still need define the control element, it's very important to
> the server's portability. Because the definition makes BSP to write
> driver which have the same interface. 

The current zaurusd (policy/scenario manager for OpenZaurus) manages the
complete and complex audio routing atm very well without any new control
elements. It does this by having an asound.state for each scenario and a
driver that exposes all it's audio controls. This way it's covers all
possible routes within the sound card.

I'm now beginning to think it may be quick and easy to turn some of
alsactl into a separate lib (from alsa-lib) and reuse it's file format
and store/restore code for scenarios. A new master scenario file could
then be added that will list the supported scenarios. e.g.

scenario {
  name = "phone call handset"  # standard name
  file = "/path/to/phone-call-handset.state"
  alias master playback volume = 1 # number is control id from state
file
}

(This format is up to the implementer)

This new file would be parsed by the scenario lib and would allow apps
to get/set/list scenarios. It would also allow the aliases to be queried
by any device manager daemon/application (in order to update any volume
controls).

Liam 
