From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Fri, 15 Oct 2010 15:04:56 +0200
Message-ID: <201010151504.56742.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010151408.30428.julian@jusst.de>
	<1287147135.3429.1.camel@laptop-alex>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EC5C103811
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 15:04:59 +0200 (CEST)
In-Reply-To: <1287147135.3429.1.camel@laptop-alex>
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

Am Freitag, 15. Oktober 2010, 14:52:15 schrieb Alex Lee:
> > So my data is (48<<13):
> >     char data[4];
> >     data[0] = 0x00;
> >     data[1] = 0x06;
> >     data[2] = 0x00;
> >     data[3] = 0x00;
> >     
> >     AUDDSpeakerDriver_WriteFeedback(data, 4,
> >     
> >                     (TransferCallback)FeedbackSent,
> >                     NULL);
> > 
> > Whenever the feedback was sent (ie it was queried by the host), this
> > method is called again and it sends the feedback again.
> > Is this ok in general or is there some basic problem with this feedback
> > style?
> 
> UAC data should be Big Endian.  Send the LSB byte first.

Ah right, thanks.
Well now I swapped data[1] and data[2]. When monitoring the amount of data I 
get per read, it is constant at 192bytes, which would be expected for feedback 
ratio of 48, right? But if I have 0x06 to 0x07 for example I do still get 
exactly 192bytes per read, shouldn't I get less data in that case? (I always 
try to read up to MAXPACKETSIZE which is 512, btw)

Regards,
Julian
