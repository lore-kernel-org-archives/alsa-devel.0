From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Sample program for hwdep interface
Date: Sun, 05 Jan 2014 20:18:35 +0900
Message-ID: <52C93F8B.1010701@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
	<52B45837.2080804@sakamocchi.jp>
	<20131221101123.GA17855@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20131221101123.GA17855@marvin.atrad.com.au>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Jonathan Woithe <jwoithe@just42.net>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Jonathan, Clemens,

I'm sorry to be late for reply but I need to enjoy my year-end holidays 
to refresh my brain.

(Dec 21 2013 19:11), Jonathan Woithe wrote:
 > I thought this ticket was more or less resolved.

I've just added a workaround for this ticket.
My patch avoids buffer-over-run/assertion and apply some fallback.
Then FFADO just looks to handle the models.

(Dec 21 2013 19:11), Jonathan Woithe wrote:
 > This ticket requires fixes within FFADO's mixer/control code (or so I 
thought).

Yes. And this ticket still affects FFADO's streaming functionality.

(Dec 21 2013 19:11), Jonathan Woithe wrote:
 > How exactly does this program deal with ticket #360?
 > Or is this program simply demonstrating what FFADO must do?

This program just demonstrates how to use hwdep interface.

For Fireworks, via this interface, FFADO can use all of implemented 
commands without failures. And it's my solution for this ticket.

Here, I try to describe the detail related to this ticket[1].
I should have mentioned the detail in ffado-devel but I got the whole 
picture in the end of last year.

Cause:
The bug is due to failure of some commands in some models.
The commands are 'EfcGetClockCmd' and 'EfcPolledValuesCmd'.
These commands are used to get device status.
The bug appears in initializing process of FFADO.
So this bug affects both streaming and mixer/control functionality.

Workaround:
Using alternative way when failed.
  - 'AV/C PLUG SIGNAL FORMAT' command to get sampling rate (applied at 
r2240)
  - 'AV/C SIGNAL SOURCE' command to get clock source (not applied)
But disadvantages.
  - No alternatives for 'EfcPolledValuesCmd'
  - GenericAVC device class has a bug to switch sampling rate (I'm under 
further investigation.)

Fact:
I actually confirmed these commands are failed in one of reported models.
But these commands are success in unreported models.
FFADO implementation of these commands is over 'AV/C VENDOR DEPENDENT' 
command.
So I tried these commands via specific addresses which Windows driver uses.
Then I got always success in the models.

Information:
In the end of last year, I had a contact in Echo Audio.
I asked the implementation of 'Echo Fireworks Command/Response' over 
'AV/C vendor dependent' command.
The person answered that some commands are not implemented on current 
firmware for reported models.
(I have no information for the reason.)
The person also said that there are no differences between firmwares 
installed by drivers of Windows/OS X.

A solution:
Using these addresses for command/response.

An issue:
Using an address range for response has an issue.
The address range is an exclusive-resource in an system [2].

In my opinion, considering ALSA/FFADO, it's better that such resource is 
used
in kernel-land driver and the driver gives an interface to use it for 
user-land
application.

Of cource, there is another way, to use this resource just in
one user-land application such as ffado-dbus-server.
Then I need to make another way for kernel-land driver.
(Maybe implementing alternative AV/C commands)

[1] http://subversion.ffado.org/ticket/360
[2] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070447.html

Regards


Takashi Sakamoto


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
