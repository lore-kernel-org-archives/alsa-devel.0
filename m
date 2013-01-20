From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Must MIDI SysEx data contain the start byte 0xf0
 and the end byte 0xf7?
Date: Sun, 20 Jan 2013 17:40:51 +0100
Message-ID: <50FC1E13.7060306@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A41EFE3BA591@HE113481.emea1.cds.t-internal.com>
 <50F9865C.4010200@ladisch.de>
 <8E4C156DA5797D418DBFADFD8CE655A41EFE3BA5CB@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 827D5261651
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2013 17:41:40 +0100 (CET)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A41EFE3BA5CB@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joerg-Cyril.Hoehle@t-systems.com wrote:
>> Just put the partial chunks into separate events.
>> The first must begin with the F0 byte, the last end with F7.
>
> So the F7 continuation event / status byte solely exists in MIDI files,
> but not as an intermediate sub-packet starter on the wire.

Yes.

> I'm precisely wondering whether Wine's auto-adding F0/F7 around SysEx
> messages (when missing) is TRT.  Now I seriously doubt it.

TRT is whatever Windows does.  According to the docs, it doesn't:
| If you are using multiple data blocks to send a single system-exclusive
| message ...
<http://msdn.microsoft.com/en-us/library/windows/desktop/dd798657(v=vs.85).aspx>


Regards,
Clemens
