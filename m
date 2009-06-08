From: kls.schlz@googlemail.com
Subject: Re: M-Audio Transit: alsamixer shows 100% and -0.5db
	at the same time !?
Date: Mon, 08 Jun 2009 12:05:42 +0000
Message-ID: <000e0cd286e2b64e43046bd50fa6@google.com>
References: <4A2CF88D.8050203@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-2122.google.com (fg-out-2122.google.com [72.14.220.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 19CCC2433F
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 14:05:43 +0200 (CEST)
Received: by fg-out-2122.google.com with SMTP id 23so180549fge.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 05:05:42 -0700 (PDT)
In-Reply-To: <4A2CF88D.8050203@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Klaus Schulz <kls.schlz@googlemail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens.

BTW: I sent you corrections to sourceforge related to madfuload  
installation/udev setup/new driver for the transit some days ago. I am  
wondering if you still maintain the package.

See below comments:


On Jun 8, 2009 1:39pm, Clemens Ladisch <clemens@ladisch.de> wrote:
> Klaus Schulz wrote:

> > My M-Audio Transit shows at 100% and 0.5db attentuation in alsamixer at  
> the

> > same time.



> "100%" just means that the control has its maximum value.



Hmmh. I understand that. But how do I get around this? My goal would be to  
run the mixer at 0db.




> > See below printout.



> This is not a printout of alsamixer.



Sorry. Below is an amixer output. Alsamixer says: gain -0.5




> > Front Left: Playback 254 [100%] [0.50dB] [on]

> > Front Right: Playback 254 [100%] [0.50dB] [on]



> I can see neither "-0.5dB" nor "0.5dB attenuation" in there; it's 0.5 dB

> gain. (If you actually run alsamixer, it gets labeled with "gain".)





> Best regards,

> Clemens
