From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 26/37] ALSA: firewire-tascam: add MMAP
 support to show status and control message
Date: Thu, 23 Jul 2015 00:19:03 +0900
Message-ID: <55AFB467.2020704@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>	<1436623968-10780-27-git-send-email-o-takashi@sakamocchi.jp>
 <55AE51FC.3020204@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 742AF2606C5
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 17:19:07 +0200 (CEST)
In-Reply-To: <55AE51FC.3020204@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Yoshifuji Hideaki <yoshfuji@linux-ipv6.org>, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jul 21 2015 23:06, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> Typically, such messages should be converted to MIDI control change
>> messages for userspace applications.
> 
> It would be possible to have ALSA mixer controls for these, but this
> would make sense only if these controls are suitable to be displayed in
> a generic mixer application.  I guess this isn't the case for most of
> them.

Indeed. The main purpose of these physical controls is to control DAW
softwares or the other devices. On the other hand, the major usage of
ALSA control elements is to control the device itself.

>> Thus, this driver should have a converter with appropriate MIDI map.
>> Currently I have no good idea for the map and it is not implemented
>> yet.
> 
> I guess the Windows driver does not makes this information available in
> any way?

Windows driver gives GUI to select the way to parse the control
information with three options. All of the options are based on MIDI
messaging. Therefore, the driver perform to convert to MIDI messages, I
think.

Furthermore, two of the options are somewhat compliant to Mackie
something. In Open Source Software, Ardour Gtk+ can handle the Mackie
something. In this reason, I think it's users' advantage to apply MIDI
converter for the control messages.

> If all the data is device-specific, the actual mapping chosen does not
> really matter, because the mixer/control application needs to have
> special code for parsing the data from this particular Linux driver
> anyway.

Exactly, with ignoring the updating interval.


Regards

Takashi Sakamoto
