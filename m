From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
Date: Tue, 23 Apr 2013 11:23:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1304231119060.1679-100000__4189.06759373403$1366730652$gmane$org@iolanthe.rowland.org>
References: <5176A42F.6080409@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5176A42F.6080409@ladisch.de>
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
Cc: tova-dev@tovacompany.com, linux-usb@vger.kernel.org, Joe Rayhawk <jrayhawk@fairlystable.org>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Apr 2013, Clemens Ladisch wrote:

> Alan Stern wrote:
> > On Tue, 23 Apr 2013, Clemens Ladisch wrote:
> >> Why is having a queue of two URB with one packet each suddenly not
> >> allowed?
> >
> > It _is_ allowed when URB_ISO_ASAP is clear.  I have never fully
> > understood why the audio driver sets that flag.  By setting it, you are
> > telling the host controller driver that you are willing to give up
> > reduced latency in order to avoid underruns.
> 
> This flag was needed to avoid having to set urb->start_frame.

Ah, okay.  It is now unnecessary to set urb->start_frame; in fact that 
field is now output-only.

(To be fair, I haven't checked _all_ the HCDs in this regard, just 
uhci-hcd, ohci-hcd, and ehci-hcd.  However, if any other HCD requires 
urb->start_frame to be set then that HCD should be considered buggy and 
should be fixed.)

> With the changed queueing API, the audio driver needs to change too.
> I'll look into this ...

Let me know if you have any questions.

Alan Stern

