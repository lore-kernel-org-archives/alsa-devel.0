Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Fri, 19 Apr 2013 14:18:24 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <5171700A.50308@ladisch.de>
Message-ID: <Pine.LNX.4.44L0.1304191359350.26229-100000@netrider.rowland.org>
MIME-Version: 1.0
Subject: Re: [alsa-devel] BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tova-dev@tovacompany.com, linux-usb@vger.kernel.org, Joe Rayhawk <jrayhawk@fairlystable.org>, alsa-devel@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

On Fri, 19 Apr 2013, Clemens Ladisch wrote:

> Alan Stern wrote:
> > ...
> > This trace shows that the frame numbers do not increase sequentially:
> > 1057125, 1057126, 1057128, 1057129, 1053131, ...  This is because the
> > new driver is a little more conservative than the old driver,
> > requiring latencies to be larger than 1 ms.  You can see this
> > explicitly in one of the new lines added by the commit you found:
> >
> > +		next = uhci->frame_number + 2;
> >
> > That 2 is the minimum latency, in frames (one frame per ms).
> 
> One frame worked fine with the old driver.  What is the reason for
> this regression?

The semantics of URB_ISO_ASAP changed; now the driver interprets as
meaning "the earliest time that is certain to work".  Since I wasn't
sure that a 1-ms latency would always work, I increased the minimum to
2.

Perhaps that was a mistake.  Joe, you can try changing the 2 above to a 
1 to see if it fixes the problem.

> > Anyway, the solution is simple: The audio driver needs either to submit
> > buffers that are at least 2 ms long, or to use more than two buffers
> > (or both).
> 
> The audio driver already has the infrastructure to cope for hardware
> restrictions like this, it just needs to *know* about them.  How can
> it detect that it runs on the OHCI/UHCI drivers?

That is a very good question.  In fact, the audio driver shouldn't care 
about what kind of driver is used at the lower level; all it should 
care about are bounds on the latency.

The kernel's USB API doesn't provide this information, unfortunately.  
There should be a way for drivers to find out, for any USB device:

     A.	The maximum delay time needed for starting a new isochronous
	stream;

     B.	The minimum advance time required for submitting a new URB
	to an existing isochronous stream (i.e., the minimum pipeline
	size);

     C.	The maximum time into the future that isochronous URBs can be 
	scheduled (the maximum pipeline size).

I don't think there's any way to add this information into all of the 
existing host controller drivers, though.

For now, the best approach is to be conservative.  I believe all the
existing USB host controller drivers will work okay if you assume the
following values:

	A: 50 ms;

	B: 2 ms;

	C: 200 ms.

The audio driver probably doesn't care about A; you try to start a new 
stream and it gets going whenever the HCD chooses.  You may or may not 
care about C.  B is the important one for this discussion.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
