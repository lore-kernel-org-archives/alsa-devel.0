From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Fri, 15 Oct 2010 14:08:29 +0200
Message-ID: <201010151408.30428.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141358.27706.julian@jusst.de>
	<1287070099.2975.19.camel@laptop-alex>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EDEA103801
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 14:08:33 +0200 (CEST)
In-Reply-To: <1287070099.2975.19.camel@laptop-alex>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alex Lee <lee188@singnet.com.sg>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 17:28:19 schrieb Alex Lee:
> On Thu, 2010-10-14 at 13:58 +0200, Julian Scheel wrote:
> > One more question on the feedback: In your project you fo 10.14 for Full
> > Speed devices (which mine is - the AT91SAM7A3 can't do High Speed) and
> > 12.13 for highspeed. Why do you distinguish that way? Is your device
> > initialised in High Speed mode whenever it's connected to a Linux host?
> 
> I started off with the assumption that with UAC1 in FS, the specs says
> 10.14.  However, I'm running the widget in HS (but still UAC1), so
> according to USB2.0 spec, the ISO feedback should be in 16.16 format.
> Later I found out that Linux uses 12.13 (for whatever reasons), so I
> changed the HS format to 12.13, leaving the FS format at 10.14.
> 
> My project uses the AT32UC3A3, which can operate it both HS and FS.  So
> it can enumerate to be either a HS or a FS device depending on the PC/
> USB Hub's capabilities.  So the firmware has to cater to both cases.  We
> are also doing compatibility testing with Vista and Win7 (WinXP does not
> support rate feedback).  So we need to test HS and FS as well.  OSX can
> accept either 10.14 or 16.16 format, depending on whether the firmware
> sends it 3 bytes or 4 bytes in the feedback pipe, so it will work with
> FS or HS.

Besides my I2S/DAC troubles, I still seem to have some problem with the async 
mode. Actually my buffers are permanently overflowing (not slightly, but very 
extreme). So far I do not regulate the feedback data, but send a constant 
value of 48 - As I expect 48 samples per USB frame.

So my data is (48<<13):

    char data[4];
    data[0] = 0x00;
    data[1] = 0x06;
    data[2] = 0x00;
    data[3] = 0x00;

    AUDDSpeakerDriver_WriteFeedback(data, 4,
                    (TransferCallback)FeedbackSent,
                    NULL);

Whenever the feedback was sent (ie it was queried by the host), this method is 
called again and it sends the feedback again.
Is this ok in general or is there some basic problem with this feedback style?

Regards,
Julian
