From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Thu, 25 Jun 2015 12:21:24 +0200
Message-ID: <20150625122125.72a1d72b4d3aa886d68fa3eb@ao2.it>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>
 <20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>
 <54F5CB3D.7020100@linux.intel.com>
 <20150304170218.7b397993ce670902800109f1@ao2.it>
 <20150403153414.b8de8df914664d7d7967120c@ao2.it>
 <20150414150236.3e8288307124a43941ab94f7@ao2.it>
 <552D1EE3.6090707@linux.intel.com>
 <20150624101613.GK19530@localhost>
 <20150625055046.GT19530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp206.alice.it (smtp206.alice.it [82.57.200.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 83AAA26007E
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 12:21:38 +0200 (CEST)
In-Reply-To: <20150625055046.GT19530@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Ramesh Babu K V <Ramesh.Babu@intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Harsha Priya <priya.harsha@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Jun 2015 11:20:46 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Wed, Jun 24, 2015 at 03:46:13PM +0530, Vinod Koul wrote:
> > On Tue, Apr 14, 2015 at 05:06:27PM +0300, Jarkko Nikula wrote:
[...]
> > > 
> > > Which makes me thinking how does those strings describe the SSP port
> > > setup? E.g. do they reflect what port is actually used or could it
> > > be possible that those are just driver strings but firmware could
> > > have been tuned for SSP0? If I looked at earlier right, Teclast has
> > > the low pin-count Baytrail without SSP2 but I'm not sure about that.
> > The FW doesnt provide way to changes ports from driver in this, so this
> > doesnt mean much. If we are sure it is not ssp2, I can provide ssp1 fw for
> > test
> I ahve pushed latest BYT version we have as well as added binary for second
> SSP port. Please give it a try:
> 
> https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/commit/?h=byt&id=28ff420dd33ec299217bad7d526ff3bfd163b551
> 

Thanks Vinod, but I see these are in the ELF format, and the mainline
driver does not support this format, at least the last time I checked it
didn't.

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
