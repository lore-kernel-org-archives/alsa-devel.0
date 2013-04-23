Return-Path: <alsa-devel-bounces@alsa-project.org>
Message-ID: <5176A42F.6080409@ladisch.de>
Date: Tue, 23 Apr 2013 17:09:35 +0200
From: Clemens Ladisch <clemens@ladisch.de>
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.1304231050510.1679-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1304231050510.1679-100000@iolanthe.rowland.org>
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
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
