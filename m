From: David Binderman <dcb314@hotmail.com>
Subject: Re: linux-4.6-rc4/sound/pci/ens1370.c:1551: possible
 bad expression ?
Date: Thu, 21 Apr 2016 07:11:10 +0000
Message-ID: <DUB128-W32707A910683069992E5F59C6E0@phx.gbl>
References: <DUB128-W44E71E14CBE4AC54396DFA9C6B0@phx.gbl>,
 <DUB128-W43C83AA6E3851834E8340F9C6B0@phx.gbl>, <57187578.2010609@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DUB004-OMC4S22.hotmail.com (dub004-omc4s22.hotmail.com
 [157.55.2.97]) by alsa0.perex.cz (Postfix) with ESMTP id 2CAF22604DF
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 09:11:11 +0200 (CEST)
In-Reply-To: <57187578.2010609@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello there,

----------------------------------------
> David Binderman wrote:
>> [linux-4.6-rc4/sound/pci/ens1370.c:1551]: (style) Expression '(X & 0xf0000)>= 0x4' is always false.
>
> What tool generated this message?

A static analysis tool called cppcheck, available from sourceforge.


Regards

David Binderman
 		 	   		  
