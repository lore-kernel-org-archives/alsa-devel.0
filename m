From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
Date: Mon, 22 Apr 2013 11:29:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1304221126200.1388-100000__17747.6088436835$1366644594$gmane$org@iolanthe.rowland.org>
References: <20130420003533.GA4607@richardiv.omgwallhack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130420003533.GA4607@richardiv.omgwallhack.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tova-dev@tovacompany.com, linux-usb@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Apr 2013, Joe Rayhawk wrote:

> On Fri, Apr 19, 2013 at 02:18:24PM -0400, Alan Stern wrote:
> > On Fri, 19 Apr 2013, Clemens Ladisch wrote:
> > > Alan Stern wrote:
> > > > +		next = uhci->frame_number + 2;
> > > >
> > > > That 2 is the minimum latency, in frames (one frame per ms).
> > > 
> > > One frame worked fine with the old driver.  What is the reason for
> > > this regression?
> > 
> > Perhaps that was a mistake.  Joe, you can try changing the 2 above to a 
> > 1 to see if it fixes the problem.
> 
> Hey, that worked great! Audio's coming through continuously, now.

This change could be added to the driver, but I would prefer not to.  
In any case, it would be best if the usb-audio driver were changed to
keep the pipeline length at least 2 ms at all times.

Clemens, what do you suggest?

Alan Stern

