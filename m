From: prashant chopade <prashantchopade@yahoo.com>
Subject: Re: unable to do simultaneous playback and recording
Date: Thu, 20 Aug 2009 16:48:03 +0530 (IST)
Message-ID: <80747.19350.qm@web94704.mail.in2.yahoo.com>
References: <4A8CF1EF.2000204@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n6-vm1.bullet.mail.in.yahoo.com
	(n6-vm1.bullet.mail.in.yahoo.com [202.86.4.133])
	by alsa0.perex.cz (Postfix) with SMTP id 3675C1037FB
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 13:24:47 +0200 (CEST)
In-Reply-To: <4A8CF1EF.2000204@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,


How to check my AT91SAM9263-EK - AC97C hardware driver is not supporting simultaneous playback and recording of an audio?

Thanks & Regards,
Prashant C.

--- On Thu, 20/8/09, Clemens Ladisch <clemens@ladisch.de> wrote:

From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] unable to do simultaneous playback and recording
To: "prashant chopade" <prashantchopade@yahoo.com>
Cc: "Takashi Iwai" <tiwai@suse.de>, alsa-devel@alsa-project.org
Date: Thursday, 20 August, 2009, 12:19 PM

prashant chopade wrote:
> As per discussion, I know that ALSA driver does not have support for
> simultaneous playback and recording.

ALSA _does_ support full duplex, if the hardware and driver support it.

> We are using AD1981B codec, so our hardware has a support for
> simultaneous playback and recording of an audio.

It looks as if your AC'97 controller driver is buggy.


Best regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



      Yahoo! recommends that you upgrade to the new and safer Internet Explorer 8. http://downloads.yahoo.com/in/internetexplorer/
