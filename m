From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 13:58:27 +0200
Message-ID: <201010141358.27706.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<20101014104855.GI10432@buzzloop.caiaq.de>
	<3879AFD1-61E6-47FB-8ECB-8A7D7B233B3B@singnet.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id ECF84103B50
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 13:58:29 +0200 (CEST)
In-Reply-To: <3879AFD1-61E6-47FB-8ECB-8A7D7B233B3B@singnet.com.sg>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex <lee188@singnet.com.sg>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 13:15:45 schrieb Alex:
> > Great to hear that ASYNC OUT with rate feedback is working for u now :-)
> 
> Btw, are u using 12.13 format for Linux ?  U can try with OSX snow leopard,
> which can understand 10.14 and 16.16.  Apply Clemens' patch and linux can
> understand all formats - but users will have to wait for kernel 2.6.37 !
> 
> I have implemented a sophisticated rate feedback with ping pong audio
> buffer, calculation of gap between USB data and i2s data, determining
> whether gap is increasing or decreasing etc.

One more question on the feedback: In your project you fo 10.14 for Full Speed 
devices (which mine is - the AT91SAM7A3 can't do High Speed) and 12.13 for 
highspeed. Why do you distinguish that way? Is your device initialised in High 
Speed mode whenever it's connected to a Linux host?

Regards,
Julian
