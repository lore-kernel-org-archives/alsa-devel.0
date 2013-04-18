From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
Date: Thu, 18 Apr 2013 12:42:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1304181241010.1525-100000__21139.7433806725$1366617411$gmane$org@iolanthe.rowland.org>
References: <20130417183436.GA4381@richardiv.omgwallhack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130417183436.GA4381@richardiv.omgwallhack.org>
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
Cc: tova-dev@tovacompany.com, linux-usb@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

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

