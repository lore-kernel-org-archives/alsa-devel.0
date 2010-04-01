From: Lars Schotte <lars.schotte@schotteweb.de>
Subject: Re: line in recording w/ alsa - suggestions for a snd
 card?
Date: Thu, 1 Apr 2010 16:01:33 +0200
Message-ID: <20100401160133.4bbf4a77@romy.gusto>
References: <20100401151931.6ff54457@romy.gusto> <4BB4A40E.2040809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ms16-1.1blu.de (ms16-1.1blu.de [89.202.0.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A566243E5
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 16:01:52 +0200 (CEST)
Received: from [78.99.186.124] (helo=romy.gusto)
	by ms16-1.1blu.de with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69) (envelope-from <lars.schotte@schotteweb.de>)
	id 1NxKxk-0007aZ-AZ
	for alsa-devel@alsa-project.org; Thu, 01 Apr 2010 16:01:36 +0200
In-Reply-To: <4BB4A40E.2040809@ladisch.de>
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

WOW,
thanks for these suggestions and informations a lot, because that saved
me really a lot of trouble.

so from that what you are telling me here I can get the SB 5.1 VX, like
I wrote in the mail to you, and of course the much more expensive Asus
Xonar would be no problem at all.

The ICE1712/1724, I cant get at all and CA0106, I dont know what it is.

so the question now is, which of these two - SB 5.1 VX or Asus Xonar.
I have a debian stable (lenny) w/ 2.6.26 old kernel and I would prefer
if the card were already supported by that kernel, so I dont need to
make any changes to the system any more.

thanks again Clemens, I appreciate your time and awaiting the
definitive suggestion now, so we can solve the problem here.

(I maybe get also some card for me according to these inf. Now I am
doing it for a friend who wants to digitalize a lot of his audio, so
it would be nice to surprise him positively by linux and ALSA and
everything around OSSoft.)

On Thu, 01 Apr 2010 15:47:58 +0200
Clemens Ladisch <clemens@ladisch.de> wrote:

> Lars Schotte wrote:
> > does anybody have a suggestion for a sound card PCI-internal that
> > works w/ ALSA and records HQ from line-in that can be used for
> > digitalizing?
> 
> There aren't that many PCI chipsets.  The CMI8738/8768/8770 chips have
> the DACs and ADCs integrated and aren't very good (although the 68/70
> are noticeably better).  The ICE1712/1724, CA0106, X-Fi and CMI8788
> chips are purely digital and must be combined with separate DAC/ADC
> chips, which usually are quite good.
> 
> The X-Fi is not supported very well.  The CA0106 is supported, and
> used on several cheap Sound Blaster cards, e.g. the SB 5.1 VX.  The
> ICE1712/ ICE1724 chips are used in many models; see the .h files in
> <http://git.alsa-project.org/?p=alsa-kernel.git;a=tree;f=sound/pci/ice1712;hb=HEAD>.
> (The "ICE1723" is a low-end model, and I don't know if it's supported
> at all).  The CMI8788 is used on the Asus Xonar cards; the
> D1/DX/D2/D2X/ST/ STX are supported; the DS is partially supported in
> the latest kernel.
> 
> 
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
-------------------
Lars Schotte @ romy
