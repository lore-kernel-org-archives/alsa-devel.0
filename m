From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: Indirect Callback with ack is called with no data
Date: Mon, 8 Jun 2009 19:21:45 +0530
Message-ID: <98769532B4BB14429434178695419EAE584F05F0@bgsmsx501.gar.corp.intel.com>
References: <BAY119-W8E3C7EC7BE9C8606E2D28B0480@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id E08152442E
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 15:51:58 +0200 (CEST)
In-Reply-To: <BAY119-W8E3C7EC7BE9C8606E2D28B0480@phx.gbl>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am facing this issue with flash.

With aplay and paplay, the audio drivers are working perfectly ok.

With flash player, the audio stops after sometime. The reason is that flash player is not sending data. All the data sent from Flash has been played out and reported accurately as well in _pointer function.

Can anyone help with any clues of flash player working with ALSA? 

This would really help.

Thanks
Harsha


-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Singaravelan Nallasellan
Sent: Friday, June 05, 2009 5:19 PM
To: alsa-devel@alsa-project.org
Subject: [alsa-devel] Indirect Callback with ack is called with no data


 

I am using indirect callback mechanism inside ack. I see that ack does not call my indirect callback pointer. Going through the code, I suspect that the appl_ptr is not being incremented and there is no data for the indirect callback to be called. 

 

After few acks, I get the indirect callback called. 

 

With aplay, I am able to play the wav file. But with flash, there is not data being sent to the driver.

 

Please help me with any clues.

 

Thanks in advance.

 

Sing

_________________________________________________________________
Insert movie times and more without leaving Hotmail(r). 
http://windowslive.com/Tutorial/Hotmail/QuickAdd?ocid=TXT_TAGLM_WL_HM_Tutorial_QuickAdd_062009
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
