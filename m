From: Jason Fox <jfox@gai-tronics.com>
Subject: [ASoc] TDM over one SSC channel on AT91 possible?
Date: Tue, 21 Jun 2011 13:15:12 -0400
Message-ID: <1308676512.32380.11.camel@alice.bigman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exprod7og127.obsmtp.com (exprod7og127.obsmtp.com [64.18.2.210])
	by alsa0.perex.cz (Postfix) with SMTP id 274651037EA
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 19:15:28 +0200 (CEST)
In-Reply-To: 4734465C.4020900@scottygroup.com
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

Hello everyone,

I am looking for some help where I need an AD193X codec to be shared
between 8 audio streams using one SSC channel on an AT91SAM9263, in
other words, I need it to look like 8 different soundcards.  We have the
8 TDM channels working in the driver but I can't figure out how to
create the proper interface of 8 soundcards for ALSA.  In an earlier
email in this topic was posted:  

> I would instantiate one driver with 3 pcms. This would allow:-
>
> pcm0: 2 channel, slot 0,1
> pcm1: 2 channel, slot 2,3
> pcm2: 4 channel, slot 0,1,2,3
>
> Giving full flexibility for many use cases. The pcms would be mutually
> exclusive (enforced by machine driver).
>
> HTH
>
> Liam

I think that maybe that I want to instantiate one driver with 8 pcms.  Where/how do I
instantiate the PCMs?  I guess it in in the machine driver?

This is our first attempt at developing a Linux based system so please forgive my 
newbie question.  I am sure this is really simple but I'm not following somewhere.

Thanks for your help,
Jason Fox
GAI-Tronics   
*******************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager. This footnote also confirms that this
email message has been swept for the presence of computer viruses.
www.Hubbell.com - Hubbell Incorporated**
