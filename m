From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [Intel-gfx] [RFC][PATCH] ELD routines and proc interface
Date: Fri, 21 Nov 2008 15:47:49 +0800
Message-ID: <20081121074749.GA16937@localhost>
References: <20081119075545.GA19833@csy.ca> <20081119080800.GA522@localhost>
	<20081119093940.GA17245@localhost> <20081119200201.GA23246@csy.ca>
	<20081120010204.GA25454@localhost> <20081120200606.GA4164@csy.ca>
	<20081121013655.GA8992@localhost> <20081121014649.GA12072@csy.ca>
	<20081121034150.GA11242@localhost> <s5hod09o759.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5hod09o759.wl%tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "Ma, Ling" <ling.ma@intel.com>, intel-gfx@lists.freedesktop.org, Shane W <shane-intel@csy.ca>, xorg@lists.freedesktop.org, "Fu, Michael" <michael.fu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 21, 2008 at 08:44:18AM +0100, Takashi Iwai wrote:
> At Fri, 21 Nov 2008 11:41:50 +0800,
> Wu Fengguang wrote:
> > 
> > On Thu, Nov 20, 2008 at 05:46:49PM -0800, Shane W wrote:
> > > On Fri, Nov 21, 2008 at 09:36:55AM +0800, Wu Fengguang wrote:
> > 
> > > > Yes it's unexpected. Do you know its real speaker numbers and
> > > > allocations? Does it provide some number of line-out ports?
> > > 
> > > There are six speakers connected, fl, ct, fr, rl, rr and lfe.
> > 
> > Hi Shane,
> > 
> > Apply this patch and run "echo speakers f > /proc/asound/card0/eld\#3".
> > That will make the ELD "speakers" field right.
> > 
> > Thanks,
> > Fengguang
> > ---
> > support writing to the ELD proc file
> > 
> > Allow users to fix quicks of ELD ROMs by writing new values to the ELD proc
> > interface. The format is one or more lines of "name hex_value".
> > 
> > Users can add/remove/modify up to 32 SAD(Short Audio Descriptor) entries.
> > 
> > Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
> 
> This is a nice feature, so I applied now as is.
> Please give an incremental patch if you need more fixes.

OK, thank you!

Fengguang
