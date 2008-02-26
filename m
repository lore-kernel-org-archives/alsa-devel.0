From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Via VT82xx VT1708 ICE1724HT and higher
Date: Tue, 26 Feb 2008 21:47:52 +0100
Message-ID: <47C47AF8.1070005@insite.cz>
References: <mailman.2073.1204045163.2095.alsa-devel@alsa-project.org>
	<004401c878a2$6cade570$d450a8c0@PDSMain2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id E74E4244C1
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 21:48:01 +0100 (CET)
In-Reply-To: <004401c878a2$6cade570$d450a8c0@PDSMain2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Demian Martin <demianm@attglobal.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Demian Martin wrote:
> Pavel:
> Thanks for the insight. I thought I was doing something wrong since no one
> else has noticed.

I was surprised too I could not google any complaints.

> I tried your suggestion to use plughw:0,1  and the verbose output looks
> fine, the data rate shifts fine (I'm watching the L/R clock on the input to
> the DAC on an external DAC)  but no audible sound comes out the converter
> unless it's a 16 bit 44.1 file. The 24 bit stuff is not getting converted
> into something useful to the DAC. Should I check to see if the data clock is
> 48X the LR clock? 
 >
 > What info do you need from me to look deeper?

Which card are you using? Juli driver in alsa is not really functional. 
E.g. Prodigy 192 (standard clock arrangement) has no problem with 24bit 
SPDIF-OUT.

> 
> I looked at the Plug plugin but have not been able to figure out how to
> configure it for my needs. There is way too much marginal information on the
> web and little that directs me to an optimum setting.
>                            -Demian
> 

I do not think the plug plugin needs any configuration. It compares 
input stream parameters with the card capabilities supplied by the 
driver and does appropriate conversions.

Pavel.
