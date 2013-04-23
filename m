From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
Date: Tue, 23 Apr 2013 17:09:35 +0200
Message-ID: <5176A42F.6080409__1553.52759543366$1366729806$gmane$org@ladisch.de>
References: <Pine.LNX.4.44L0.1304231050510.1679-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <Pine.LNX.4.44L0.1304231050510.1679-100000@iolanthe.rowland.org>
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
> On Tue, 23 Apr 2013, Clemens Ladisch wrote:
>> Why is having a queue of two URB with one packet each suddenly not
>> allowed?
>
> It _is_ allowed when URB_ISO_ASAP is clear.  I have never fully
> understood why the audio driver sets that flag.  By setting it, you are
> telling the host controller driver that you are willing to give up
> reduced latency in order to avoid underruns.

This flag was needed to avoid having to set urb->start_frame.

With the changed queueing API, the audio driver needs to change too.
I'll look into this ...


Regards,
Clemens
