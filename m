From: Alex Lee <lee188@singnet.com.sg>
Subject: Re: USB asynchronous mode feedback format
Date: Fri, 15 Oct 2010 20:52:15 +0800
Message-ID: <1287147135.3429.1.camel@laptop-alex>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141358.27706.julian@jusst.de>
	<1287070099.2975.19.camel@laptop-alex>
	<201010151408.30428.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp17.singnet.com.sg (smtp17.singnet.com.sg [165.21.6.27])
	by alsa0.perex.cz (Postfix) with ESMTP id B0474103806
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 14:52:19 +0200 (CEST)
In-Reply-To: <201010151408.30428.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-10-15 at 14:08 +0200, Julian Scheel wrote:

> 
> Besides my I2S/DAC troubles, I still seem to have some problem with the async 
> mode. Actually my buffers are permanently overflowing (not slightly, but very 
> extreme). So far I do not regulate the feedback data, but send a constant 
> value of 48 - As I expect 48 samples per USB frame.
> 
> So my data is (48<<13):
> 
>     char data[4];
>     data[0] = 0x00;
>     data[1] = 0x06;
>     data[2] = 0x00;
>     data[3] = 0x00;
> 
>     AUDDSpeakerDriver_WriteFeedback(data, 4,
>                     (TransferCallback)FeedbackSent,
>                     NULL);
> 
> Whenever the feedback was sent (ie it was queried by the host), this method is 
> called again and it sends the feedback again.
> Is this ok in general or is there some basic problem with this feedback style?
> 

UAC data should be Big Endian.  Send the LSB byte first.

Alex
