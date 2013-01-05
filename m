From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Sat, 5 Jan 2013 13:19:17 +1030
Message-ID: <20130105024917.GA11016@marvin.atrad.com.au>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de> <50E69ABD.40109@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 825802616CF
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2013 03:49:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <50E69ABD.40109@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 04, 2013 at 10:02:53AM +0100, David Henningsson wrote:
> On 01/03/2013 11:39 AM, Takashi Iwai wrote:
> >The jack retasking of the headphone input is still an open issue.
> >I can provide a patch to add the support via "Headphone Jack Mode"
> >enum, but David didn't like that approach.
> 
> Meanwhile, there is hda-jack-retask utility (in the alsa-tools
> package) that might be helpful for Jonathan?

I discovered that utility during my initial investigations.  Unfortunately
it requires GTK3 and I have not yet had an opportunity to upgrade the laptop
to a distro version which includes it.  Given my schedule I suspect it's
going to be several months before I get the chance.

On Fri, 04 Jan 2013 10:35:48 +0100, Takashi Iwai wrote:
> OK, if so, we can go forward in that way :)

Sounds good.  I'm more than happy to test patches as they become available.

Regards
  jonathan
