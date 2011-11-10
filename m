From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: iec958 device
Date: Thu, 10 Nov 2011 17:48:04 +0100
Message-ID: <4EBC0044.9060209@ladisch.de>
References: <4EBB557F.3020309@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id EB9E9243DC
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 17:47:19 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3C7842192E
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 11:47:18 -0500 (EST)
In-Reply-To: <4EBB557F.3020309@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vipin Kumar <vipin.kumar@st.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Vipin Kumar wrote:
> I am writing an SPDIF controller's driver which is almost complete
> I understand that a user should be able to see a iec958 device with 
> "alsa -L"
> 
> I am not able to comprehend how to do it. Is it just a user
> configuration or something needs to be exported from the driver as well

Write a configuration file for your driver and put it into
alsa-lib/src/conf/cards/.


Regards,
Clemens
