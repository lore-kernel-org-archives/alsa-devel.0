From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
Date: Fri, 19 Apr 2013 18:25:46 +0200
Message-ID: <5171700A.50308__39566.1680763171$1366388770$gmane$org@ladisch.de>
References: <Pine.LNX.4.44L0.1304191132130.21363-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <Pine.LNX.4.44L0.1304191132130.21363-100000@netrider.rowland.org>
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

Alan Stern wrote:
> ...
> This trace shows that the frame numbers do not increase sequentially:
> 1057125, 1057126, 1057128, 1057129, 1053131, ...  This is because the
> new driver is a little more conservative than the old driver,
> requiring latencies to be larger than 1 ms.  You can see this
> explicitly in one of the new lines added by the commit you found:
>
> +		next = uhci->frame_number + 2;
>
> That 2 is the minimum latency, in frames (one frame per ms).

One frame worked fine with the old driver.  What is the reason for
this regression?

> Anyway, the solution is simple: The audio driver needs either to submit
> buffers that are at least 2 ms long, or to use more than two buffers
> (or both).

The audio driver already has the infrastructure to cope for hardware
restrictions like this, it just needs to *know* about them.  How can
it detect that it runs on the OHCI/UHCI drivers?


Regards,
Clemens
