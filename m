From: Sean Thayne <sthayne@summitmediagroupllc.com>
Subject: Re: How can you tell if the speaker jack on your	sound
 card has anything plugged into it???
Date: Fri, 25 Apr 2008 15:02:09 -0600
Message-ID: <481246D1.1050101@summitmediagroupllc.com>
References: <48123137.70107@summitmediagroupllc.com>	<20080425194917.GA26621@sirena.org.uk>	<481244BD.3060501@summitmediagroupllc.com>
	<4812458E.5030508@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail46.opentransfer.com (mail46.opentransfer.com
	[76.162.254.46]) by alsa0.perex.cz (Postfix) with SMTP id 9C9E9103822
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 23:02:25 +0200 (CEST)
In-Reply-To: <4812458E.5030508@freescale.com>
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
List-Id: alsa-devel@alsa-project.org

How do you think Vista does it? I've used a couple of different 
computers (totally different hardware) and it can detect insertion for 
them all...

Timur Tabi wrote:
> Sean Thayne wrote:
>   
>> How would one go about getting this info? I'm trying to create a 
>> monitoring tool for a specific sound card, so the driver's standardized...
>>     
>
> First, the hardware has to detect insertion.  Then, it has to send a 
> signal to the driver (either via a status register or an interrupt).
>
> Assuming you have all that (I've never seen a sound card that provides 
> this info), perhaps you can specify the output jack only when something 
> is plugged in?  That is, you register the output jack when something is 
> plugged in, and then deregister it when something is removed.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>   

-- 
Sean Thayne
Summit Media Group LLC.
5532 Lillehammer Lane, Suite 300
Park City, UT 84098
T: (435) 575-0610 ext 115
F: (435) 615-9979
E: sthayne@smgroupllc.com <mailto:sthayne@smgroupllc.com>
W: http://www.smgroupllc.com
