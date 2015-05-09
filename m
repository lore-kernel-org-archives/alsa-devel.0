From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PreSonus Information For Developers
Date: Sat, 09 May 2015 09:02:03 +0200
Message-ID: <554DB0EB.9090502@ladisch.de>
References: <554C1AED.7070503@frontier.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 553FD260455
 for <alsa-devel@alsa-project.org>; Sat,  9 May 2015 09:02:11 +0200 (CEST)
In-Reply-To: <554C1AED.7070503@frontier.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Karl Swisher <k_swisher@frontier.com>, ALSA-DEVEL <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Karl Swisher wrote:
> I have what might be useful information to some developers but I do
> not sure who or how to contact the right people.  I recently purchased
> a PreSonus StudioLive AI 32.4.2 mixer.  Have it half way working under
> Linux.  This mixer has a network connection in addition to the
> firewire interface.  I've installed their software under VirtualBox
> and ran tcpflow capturing packet content between the computer and the
> mixer.  I have started creating text files of the packets of which
> below is an example of their software performing functions like the
> mixer booting, backing up, restore, and selecting the digital output
> channels 33 through 48.
>
> 55 43 00 01 06 00 4b 41 65 00 64 00
> 55 43 00 01 1d 00 46 52 65 00 64 00 01 00
> Listpresets/scene 00 00
>
> 55 43 00 01 1b 00 46 52 65 00 64 00 01 00
> Listpresets/channel 00 00
>
> 55 43 00 01 19 00 46 52 65 00 64 00 01 00
> Listpresets/geq 00 00
>
> 55 43 00 01 19 00 46 52 65 00 64 00 01 00
> Listpresets/reverb 00 00
>
> Does anyone here know if there is value in this information or anyone
> that might want it?

This information might be useful for somebody who wants to write a mixer
for this device.

Please add this to a page on the FFADO wiki: http://subversion.ffado.org/


Regards,
Clemens
