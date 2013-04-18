Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Thu, 18 Apr 2013 12:42:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <20130417183436.GA4381@richardiv.omgwallhack.org>
Message-ID: <Pine.LNX.4.44L0.1304181241010.1525-100000@iolanthe.rowland.org>
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
Cc: tova-dev@tovacompany.com, linux-usb@vger.kernel.org, alsa-devel@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

On Wed, 17 Apr 2013, Joe Rayhawk wrote:

> Small buffer/period sizes on usb audio playback though UHCI works fine on v3.7 but causes audio discontinuities/delays on v3.8 and v3.9-rc7.
> 
> I've bisected the behavior down to
> 
>     c44b225077bb1fb25ed5cd5c4f226897b91bedd4
>     'UHCI: implement new semantics for URB_ISO_ASAP'
> 
> Tested on two UHCI hosts and three usb-audio devices, all from different vendors.

Can you provide a usbmon trace showing the problems?  And maybe also a 
similar trace made under a 3.7 kernel, where the problem doesn't occur?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
