From: Rick Mann <rmann@latencyzero.com>
Subject: Re: Noise in tlv320aic3104-based audio system
Date: Thu, 29 Oct 2015 18:08:06 -0700
Message-ID: <74948082-F465-445E-8CB4-6F401061A4DD@latencyzero.com>
References: <2C04C84B-D0DC-40F6-9E5C-0BE659ABD7CA@latencyzero.com>
 <CA+sos79u_usBFsV=w5PKN5xq10E_biFrWWX__Cn4kXqAYcKKPA@mail.gmail.com>
 <D00A3079-506F-4C42-8353-A903208D70AA@latencyzero.com>
 <CAG5mAdwvbBSVsnvYMbh3UJnnT9hZ2nMzvFzUpWb+KPJqummr8g@mail.gmail.com>
 <71E80DDD-A9CF-454B-84F8-3D6A61106678@latencyzero.com>
 <CA+sos7-E8agRg-LhOLo4reZp09BJjV2P_nTfSDWT9_u+2h4dqw@mail.gmail.com>
 <D388183F-A107-4831-AB29-4AC9817BDE4A@latencyzero.com>
 <20151030005320.GB7311@us.netrek.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id A1CD9265917
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 02:08:08 +0100 (CET)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 26D152031A
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 21:08:08 -0400 (EDT)
In-Reply-To: <20151030005320.GB7311@us.netrek.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Cameron <quozl@laptop.org>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Caleb Crome <caleb@crome.org>, =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
List-Id: alsa-devel@alsa-project.org


> On Oct 29, 2015, at 17:53 , James Cameron <quozl@laptop.org> wrote:
> 
> On Thu, Oct 29, 2015 at 05:38:03PM -0700, Rick Mann wrote:
>> ... Is there a way to generate a default asound.state file? For
>> example, if I delete the file altogether, and then reboot, reload my
>> Device Tree Overlay, and then issue alsactl store, will it create a
>> "clean" asound file with just the right controls (with defaults)?
> 
> Yes, that's the way it is usually done; delete the file, somehow avoid
> it being written on shutdown, then on next boot whatever the driver
> and hardware has as a default will be used.  Many drivers will use
> what the hardware has in registers.  If the system firmware hasn't
> touched those registers, then you should have chip reset values.  If
> the chip is specified without reset values, you'll have unpredictable
> values.  Exciting times ensue.

Thanks James...Cameron? Whoa. ;-)

I think what I'll do is reboot, delete the file, then load the overlay which will add the device to the device tree (it's not there after boot).

I might delete the file, reboot, delete it again? Dunno. We'll see.

Thanks for the confirmation that it works this way.

-- 
Rick Mann
rmann@latencyzero.com
