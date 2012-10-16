From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Tue, 16 Oct 2012 14:27:46 +0200
Message-ID: <507D52C2.3090902@ladisch.de>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>	<CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>	<507D0F6D.1000102@gmail.com>	<CABn3OEF1L7hqVAcjs5E5NveA741HPVd4a9eq0w9sS77PYg+2hQ@mail.gmail.com>	<507D268E.2070609@ladisch.de>
 <CABn3OEHgc5RHDX-C3yJsHj9iVFH6Zn9hg3Z0umUhK6SyPVqVJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 78020265147
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 14:29:03 +0200 (CEST)
In-Reply-To: <CABn3OEHgc5RHDX-C3yJsHj9iVFH6Zn9hg3Z0umUhK6SyPVqVJw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pete Leigh <pete.leigh@gmail.com>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Pete Leigh wrote:
> On 16 October 2012 10:19, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Are you sure there are three MIDI ports per direction, and not two?
>
> No, that sounds wrong, in fact I didn't realise I'd set this. I guess
> the two ports would be one for sysex and one for normal messages? Two
> seems to fit with what lsusb shows
>
> I've tested with .out_cables and .in_cables both set to 0x0011 (is
> that two?)

These are bit masks; two ports would be 0x0003.


Regards,
Clemens
