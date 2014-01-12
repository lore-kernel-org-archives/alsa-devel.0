From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Sample program for hwdep interface
Date: Sun, 12 Jan 2014 14:22:30 +0100
Message-ID: <20140112142230.4aacdc9e@stein>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
 <52B45837.2080804@sakamocchi.jp>
 <20131221101123.GA17855@marvin.atrad.com.au>
 <52C93F8B.1010701@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ED77261703
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 14:22:36 +0100 (CET)
In-Reply-To: <52C93F8B.1010701@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jan 05 Takashi Sakamoto wrote:
[...]
> This program just demonstrates how to use hwdep interface.
> 
> For Fireworks, via this interface, FFADO can use all of implemented 
> commands without failures. And it's my solution for this ticket.
> 
> Here, I try to describe the detail related to this ticket[1].
> I should have mentioned the detail in ffado-devel but I got the whole 
> picture in the end of last year.
> 
> Cause:
> The bug is due to failure of some commands in some models.
> The commands are 'EfcGetClockCmd' and 'EfcPolledValuesCmd'.
> These commands are used to get device status.
> The bug appears in initializing process of FFADO.
> So this bug affects both streaming and mixer/control functionality.
[...]
> In the end of last year, I had a contact in Echo Audio.
> I asked the implementation of 'Echo Fireworks Command/Response' over 
> 'AV/C vendor dependent' command.
> The person answered that some commands are not implemented on current 
> firmware for reported models.
> (I have no information for the reason.)
> The person also said that there are no differences between firmwares 
> installed by drivers of Windows/OS X.
> 
> A solution:
> Using these addresses for command/response.
> 
> An issue:
> Using an address range for response has an issue.
> The address range is an exclusive-resource in an system [2].
> 
> In my opinion, considering ALSA/FFADO, it's better that such resource is used
> in kernel-land driver and the driver gives an interface to use it for user-land
> application.
> 
> Of cource, there is another way, to use this resource just in
> one user-land application such as ffado-dbus-server.
> Then I need to make another way for kernel-land driver.
> (Maybe implementing alternative AV/C commands)
> 
> [1] http://subversion.ffado.org/ticket/360
> [2] http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070447.html

Takashi and Clemens,

another alternative would be to implement sharing/multiplexing of the EFC
response address range in firewire-core, like it is implemented for
FCP_COMMAND and FCP_RESPONSE.  Not sure if it is wise to share nonstandard
address ranges though.
-- 
Stefan Richter
-=====-====- ---= -==--
http://arcgraph.de/sr/
