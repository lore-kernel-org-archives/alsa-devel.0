From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: trouble using S/PDIF input on CMI8738-MC6:
	C-Media	CMI8738 (model 55)
Date: Fri, 22 Aug 2014 10:50:45 +0200
Message-ID: <53F70465.9000007@ladisch.de>
References: <53EA40EB.2060201@seniorblanco.com>	<53EB80C3.7020909@ladisch.de>	<53EB9C3B.2070602@seniorblanco.com>	<53F53B4C.20905@seniorblanco.com>
 <53F5CA80.8020300@ladisch.de> <53F66DA7.4010807@seniorblanco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id AB5A62658E8
 for <alsa-devel@alsa-project.org>; Fri, 22 Aug 2014 10:50:48 +0200 (CEST)
In-Reply-To: <53F66DA7.4010807@seniorblanco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jon <jon@seniorblanco.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jon wrote:
> if I start speaker-test, then toggle the "IEC958 In Record" (which at
> that point has turned itself on automatically) to off, arecord then
> records an arbitrary amount of silence instead

There is a reason the "In Record" control is disabled; it is used
internally by the driver to switch between analog and digital input.


Regards,
Clemens
